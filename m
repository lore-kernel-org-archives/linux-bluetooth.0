Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <fc27e74b0704240413v5b6e2e80h7b2feb40d27de686@mail.gmail.com>
Date: Tue, 24 Apr 2007 16:43:10 +0530
From: "list subscribe" <develnewbie@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH]Dynamic Alternate Setting patch (hci_usb.c)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0429618246=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0429618246==
Content-Type: multipart/alternative;
	boundary="----=_Part_19967_6038016.1177413190756"

------=_Part_19967_6038016.1177413190756
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

As per the discussion on #bluez channel , I am attaching a patch which
dynamically manages the the alternate settings for SCO channels.
The patch includes the following :

1. It declares a work queue(config_work), which is scheduled when
             1. There is a change in number of SCO channels OR
             2. There is a change in the Voice setting.

2. On invocation it determines the alternate setting based on the table
given in HCI - usb spec docs. The  table is also mentioned  in the patch.

3. It then empties all the queued isochronous URBs , except those which are
already submitted.

4. It then sets the alternate setting by calling   usb_set_interface().

I have tested this patch using "scotest".
I am using 2.6.21-rc7 with sco-flowcontrol-v4.2.diff patch.

Let me know if  any changes are necessary.
Any suggestions are welcome.



Alok.


--- hci_usb.c.orig    2007-04-16 19:37:41.000000000 +0530
+++ hci_usb.c    2007-04-24 01:41:31.000000000 +0530
@@ -47,6 +47,8 @@

 #include <linux/usb.h>

+#include <linux/workqueue.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>

@@ -57,6 +59,21 @@
 #define BT_DBG(D...)
 #endif

+/* The number of SCO channels  */
+int NoSco=0;
+/* The  Voice setting  */
+__u16 VocSetting=0;
+/* if bit=0,its 8bit encoding else its 16bit */
+__u16 bit = 0x20;
+
+struct hci_usb *hUSB;
+struct usb_device *usbdevice;
+struct usb_interface *isocIface;
+/* The Workque Function */
+static void set_alternate_config(struct work_struct *work);
+static DECLARE_WORK(config_work, set_alternate_config);
+
+
 #ifndef CONFIG_BT_HCIUSB_ZERO_PACKET
 #undef  URB_ZERO_PACKET
 #define URB_ZERO_PACKET 0
@@ -840,6 +857,10 @@
 static void hci_usb_notify(struct hci_dev *hdev, unsigned int evt)
 {
     BT_DBG("%s evt %d", hdev->name, evt);
+    NoSco = hdev->conn_hash.sco_num;
+    VocSetting = hdev->voice_setting;
+    hUSB = (struct hci_usb *) hdev->driver_data;
+    schedule_work(&config_work);
 }

 static int hci_usb_probe(struct usb_interface *intf, const struct
usb_device_id *id)
@@ -854,7 +875,7 @@
     struct hci_usb *husb;
     struct hci_dev *hdev;
     int i, e, size, isoc_ifnum, isoc_alts;
-
+    usbdevice = interface_to_usbdev(intf);
     BT_DBG("udev %p intf %p", udev, intf);

     if (!id->driver_info) {
@@ -926,9 +947,11 @@
     isoc_ifnum = 1;

 #ifdef CONFIG_BT_HCIUSB_SCO
-    if (isoc && !(id->driver_info & (HCI_BROKEN_ISOC | HCI_SNIFFER)))
+    if (isoc && !(id->driver_info & (HCI_BROKEN_ISOC | HCI_SNIFFER))){
         isoc_iface = usb_ifnum_to_if(udev, isoc_ifnum);
-
+            isocIface = usb_ifnum_to_if(udev, isoc_ifnum);
+    }
+
     if (isoc_iface) {
         int a;
         struct usb_host_endpoint *isoc_out_ep = NULL;
@@ -1142,6 +1165,121 @@
     return 0;
 }

+
+/*Set the alternate setting based on the number of SCO channels and the
+  voice setting.This function is invoked when there is a change in Number
of
+  SCO channels or when the voice encoding changes.*/
+static void set_alternate_config(struct work_struct *work)
+{
+    int isocIfnum=1, isocAlt=0;
+    struct usb_host_endpoint  *ep;
+    struct usb_host_interface *uif;
+    struct _urb *_urb,*_tmp;
+    struct _urb_queue *q = &hUSB->pending_q[isoc];
+    unsigned long flags;
+    atomic_t temp;/*Holds the number of URBs we need to skip(which are
submitted)*/
+    struct list_head inprocess;/*This list holds the already submitted URBs
*/
+
+    /*Change the alternate setting only if the number of SCO channels are
more than 1 */
+    if(NoSco > 0){
+        /* The alternate setting selection is based on the following table
*/
+        /*   No. of SCO channels    Bit-Encoding    Alternate Setting
Max. Packet Size */
+        /*           1                 8bit
1                  9 */
+        /*           1                16bit
2                 17 */
+        /*           2                 8bit
2                 17 */
+        /*           2                16bit
4                 33 */
+        /*           3                 8bit
3                 25 */
+        /*           3                16bit
5                 49 */
+        switch(NoSco)
+        {
+        case 1:
+            if(VocSetting && bit)
+                isocAlt=2;
+            else
+                isocAlt=1;
+            break;
+        case 2:
+            if(VocSetting && bit)
+                isocAlt=4;
+            else
+                isocAlt=2;
+            break;
+        case 3:
+            if(VocSetting && bit)
+                isocAlt=5;
+            else
+                isocAlt=3;
+            break;
+        }
+
+        /*Stop Current TX */
+        clear_bit(HCI_USB_TX_WAKEUP, &hUSB->state);
+        INIT_LIST_HEAD(&inprocess);
+        temp = hUSB->pending_tx[isoc];
+        /*  We cannot purge URBs which have been submitted. inprocess is a
*/
+        /*  temporary list which holds the currently submitted URBs. */
+        /*  This list is later merged with the emptyed pending queue.  */
+
+        while ((_urb = _urb_dequeue(q))) {
+            /*Dequeue all the submitted URBs and put them in the temporary
list*/
+            if(!atomic_dec_and_test(&temp)){
+                _urb->queue = q;
+                list_add(&_urb->list, &inprocess);
+            }
+            else{
+                /*Unlink all the rest of URBs and put them into the
completed queue.*/
+                _urb_unlink(_urb);
+                _urb_queue_tail(__completed_q(hUSB,HCI_SCODATA_PKT), _urb);
+            }
+        }
+        /*merge the inprocess queue with the pending queue*/
+        spin_lock_irqsave(&q->lock, flags);
+        list_for_each_entry_safe(_urb, _tmp, &inprocess, list) {
+            list_move_tail(&_urb->list, &q->head);
+        }
+        spin_unlock_irqrestore(&q->lock, flags);
+
+        /* Set the setting and the in/out endpoints */
+        if (isocIface) {
+            int e;
+            struct usb_host_endpoint *out = NULL;
+            struct usb_host_endpoint *in = NULL;
+            uif = &isocIface->altsetting[isocAlt];
+            for (e = 0; e < uif->desc.bNumEndpoints; e++) {
+                ep = &uif->endpoint[e];
+                switch (ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
{
+                case USB_ENDPOINT_XFER_ISOC:
+                    if (ep->desc.bEndpointAddress & USB_DIR_IN)
+                        in  = ep;
+                    else
+                        out = ep;
+                    break;
+                }
+            }
+
+            if (!in || !out)
+                BT_DBG("Isoc endpoints not found");
+            else {
+                BT_DBG("isoc ifnum %d alts %d", isocIfnum, isocAlt);
+                if (usb_set_interface(usbdevice, isocIfnum, isocAlt)) {
+                    BT_ERR("Can't set isoc interface settings");
+                    hUSB->isoc_iface = isocIface;
+                    usb_driver_release_interface(&hci_usb_driver,
isocIface);
+                    hUSB->isoc_iface = NULL;
+                } else {
+                    hUSB->isoc_iface  = isocIface;
+                    hUSB->isoc_in_ep  = in;
+                    hUSB->isoc_out_ep  = out;
+                }
+            }
+        }
+        set_bit(HCI_USB_TX_WAKEUP, &hUSB->state);
+    }
+
+}
+
+
+
 static struct usb_driver hci_usb_driver = {
     .name        = "hci_usb",
     .probe        = hci_usb_probe,

------=_Part_19967_6038016.1177413190756
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, <br><br>As per the discussion on #bluez channel , I am attaching a
patch which dynamically manages the the alternate settings for SCO
channels.<br>The patch includes the following :<br><br>1. It declares a wor=
k queue(config_work), which is scheduled when<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. There is a change in numb=
er of SCO channels OR <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 2. There is a change in the Voice setting.
<br><br>2.
On invocation it determines the alternate setting based on the table
given in HCI - usb spec docs. The&nbsp;&nbsp;table is also mentioned&nbsp;&=
nbsp;in the
patch. <br><br>3. It then empties all the queued isochronous URBs , except =
those which are already submitted. <br><br>4. It then sets the alternate se=
tting by calling&nbsp;&nbsp; usb_set_interface().<br> <br>I have tested thi=
s patch using &quot;scotest&quot;.=20
<br>I am using 2.6.21-rc7 with sco-flowcontrol-v4.2.diff patch. <br><br>Let=
 me know if&nbsp;&nbsp;any changes are necessary. <br>Any suggestions are w=
elcome. <br><br><br><br>Alok.&nbsp; <br>
<br><br>--- hci_usb.c.orig&nbsp;&nbsp;&nbsp; 2007-04-16 19:37:41.000000000 =
+0530<br>+++ hci_usb.c&nbsp;&nbsp;&nbsp; 2007-04-24 01:41:31.000000000 +053=
0<br>@@ -47,6 +47,8 @@<br>&nbsp;<br>&nbsp;#include &lt;linux/usb.h&gt;<br>&=
nbsp;<br>+#include &lt;linux/workqueue.h&gt;
<br>+<br>&nbsp;#include &lt;net/bluetooth/bluetooth.h&gt;<br>&nbsp;#include=
 &lt;net/bluetooth/hci_core.h&gt;<br>&nbsp;<br>@@ -57,6 +59,21 @@<br>&nbsp;=
#define BT_DBG(D...)<br>&nbsp;#endif<br>&nbsp;<br>+/* The number of SCO cha=
nnels&nbsp; */<br>+int NoSco=3D0;
<br>+/* The&nbsp; Voice setting&nbsp; */<br>+__u16 VocSetting=3D0;<br>+/* i=
f bit=3D0,its 8bit encoding else its 16bit */<br>+__u16 bit =3D 0x20;<br>+<=
br>+struct hci_usb *hUSB; <br>+struct usb_device *usbdevice; <br>+struct us=
b_interface *isocIface;
<br>+/* The Workque Function */<br>+static void set_alternate_config(struct=
 work_struct *work);<br>+static DECLARE_WORK(config_work, set_alternate_con=
fig);<br>+<br>+<br>&nbsp;#ifndef CONFIG_BT_HCIUSB_ZERO_PACKET<br>&nbsp;#und=
ef&nbsp; URB_ZERO_PACKET
<br>&nbsp;#define URB_ZERO_PACKET 0<br>@@ -840,6 +857,10 @@<br>&nbsp;static=
 void hci_usb_notify(struct hci_dev *hdev, unsigned int evt)<br>&nbsp;{<br>=
&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot;%s evt %d&quot;, hdev-&gt;name, evt);=
<br>+&nbsp;&nbsp;&nbsp; NoSco =3D hdev-&gt;conn_hash.sco_num;
<br>+&nbsp;&nbsp;&nbsp; VocSetting =3D hdev-&gt;voice_setting;<br>+&nbsp;&n=
bsp;&nbsp; hUSB =3D (struct hci_usb *) hdev-&gt;driver_data;<br>+&nbsp;&nbs=
p;&nbsp; schedule_work(&amp;config_work);<br>&nbsp;}<br>&nbsp;<br>&nbsp;sta=
tic int hci_usb_probe(struct usb_interface *intf, const struct usb_device_i=
d *id)
<br>@@ -854,7 +875,7 @@<br>&nbsp;&nbsp;&nbsp;&nbsp; struct hci_usb *husb;<b=
r>&nbsp;&nbsp;&nbsp;&nbsp; struct hci_dev *hdev;<br>&nbsp;&nbsp;&nbsp;&nbsp=
; int i, e, size, isoc_ifnum, isoc_alts;<br>-<br>+&nbsp;&nbsp;&nbsp; usbdev=
ice =3D interface_to_usbdev(intf);<br>&nbsp;&nbsp;&nbsp;&nbsp; BT_DBG(&quot=
;udev %p intf %p&quot;, udev, intf);
<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; if (!id-&gt;driver_info) {<br>@@ -92=
6,9 +947,11 @@<br>&nbsp;&nbsp;&nbsp;&nbsp; isoc_ifnum =3D 1;<br>&nbsp;<br>&=
nbsp;#ifdef CONFIG_BT_HCIUSB_SCO<br>-&nbsp;&nbsp;&nbsp; if (isoc &amp;&amp;=
 !(id-&gt;driver_info &amp; (HCI_BROKEN_ISOC | HCI_SNIFFER)))<br>+&nbsp;&nb=
sp;&nbsp; if (isoc &amp;&amp; !(id-&gt;driver_info &amp; (HCI_BROKEN_ISOC |=
 HCI_SNIFFER))){
<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; isoc_iface =3D usb_ifnum_to=
_if(udev, isoc_ifnum);<br>-<br>+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;isocIface =3D usb_ifnum_to_if(udev, isoc_ifnum);<br>+&nbsp;&n=
bsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; if (isoc_i=
face) {<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int a;<br>&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct usb_host_endpoint *isoc_out_ep =3D=
 NULL;
<br>@@ -1142,6 +1165,121 @@<br>&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&nbsp;=
}<br>&nbsp;<br>+<br>+/*Set the alternate setting based on the number of SCO=
 channels and the<br>+&nbsp; voice setting.This function is invoked when th=
ere is a change in Number of<br>
+&nbsp; SCO channels or when the voice encoding changes.*/<br>+static void =
set_alternate_config(struct work_struct *work)<br>+{<br>+&nbsp;&nbsp;&nbsp;=
 int isocIfnum=3D1, isocAlt=3D0;<br>+&nbsp;&nbsp;&nbsp; struct usb_host_end=
point&nbsp; *ep;<br>+&nbsp;&nbsp;&nbsp; struct usb_host_interface *uif;
<br>+&nbsp;&nbsp;&nbsp; struct _urb *_urb,*_tmp;<br>+&nbsp;&nbsp;&nbsp; str=
uct _urb_queue *q =3D &amp;hUSB-&gt;pending_q[isoc];<br>+&nbsp;&nbsp;&nbsp;=
 unsigned long flags;<br>+&nbsp;&nbsp;&nbsp; atomic_t temp;/*Holds the numb=
er of URBs we need to skip(which are submitted)*/<br>+&nbsp;&nbsp;&nbsp; st=
ruct list_head inprocess;/*This list holds the already submitted URBs */
<br>+&nbsp;&nbsp;&nbsp; <br>+&nbsp;&nbsp;&nbsp; /*Change the alternate sett=
ing only if the number of SCO channels are more than 1 */<br>+&nbsp;&nbsp;&=
nbsp; if(NoSco &gt; 0){<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* The al=
ternate setting selection is based on the following table */<br>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp; No. of SCO channels&nbsp;&nbsp;&=
nbsp; Bit-Encoding&nbsp;&nbsp;&nbsp; Alternate Setting&nbsp;&nbsp; Max. Pac=
ket Size */
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8bit&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9 */<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 16bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17 */<br>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8bit&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 17 */
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16bit&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 33 */<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 8bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25 */<br>+&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 49 */
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch(NoSco)<br>+&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; {<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 1:=
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(VocSetting=
 &amp;&amp; bit)<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; isocAlt=3D2;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; else<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; isocAlt=3D1;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; case 2:
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(VocSetting=
 &amp;&amp; bit)<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; isocAlt=3D4;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; else<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; isocAlt=3D2;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; case 3:<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if=
(VocSetting &amp;&amp; bit)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; isocAlt=3D5;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 else<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; isocAlt=3D3;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; break;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>+<br>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*Stop Current TX */<br>+&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; clear_bit(HCI_USB_TX_WAKEUP, &amp;hUSB-&gt;state);<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;inprocess);<br>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; temp =3D hUSB-&gt;pending_tx[isoc];<b=
r>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp; We cannot purge URBs whic=
h have been submitted. inprocess is a */<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; /*&nbsp; temporary list which holds the currently submitted URBs. *=
/
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*&nbsp; This list is later merg=
ed with the emptyed pending queue.&nbsp; */<br>+&nbsp;&nbsp; <br>+&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; while ((_urb =3D _urb_dequeue(q))) {<br>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*Dequeue all the submi=
tted URBs and put them in the temporary list*/&nbsp;=20
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(!atomic_de=
c_and_test(&amp;temp)){<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; _urb-&gt;queue =3D q;<br>+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; list_add(&amp;_urb-=
&gt;list, &amp;inprocess);<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 else{<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; /*Unlink all the rest of URBs and put them into the completed q=
ueue.*/
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; _urb_unlink(_urb);<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; _urb_queue_tail(__completed_q(hUSB,HCI_SCODAT=
A_PKT), _urb);<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; /*merge the inprocess queue with the pending queue*/<br>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;q-&gt;lock, flags)=
;
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; list_for_each_entry_safe(_urb, _=
tmp, &amp;inprocess, list) {<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; list_move_tail(&amp;_urb-&gt;list, &amp;q-&gt;head);<br>+&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; spin_unlock_irqrestore(&amp;q-&gt;lock, flags);<br>+&nbsp;&nbsp;&nbsp;=
=20
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Set the setting and the in/ou=
t endpoints */<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (isocIface) {<b=
r>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int e;<br>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct usb_host_endpoi=
nt *out =3D NULL;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; struct usb_host_endpoint *in =3D NULL;<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; uif =3D &amp;isoc=
Iface-&gt;altsetting[isocAlt];<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; for (e =3D 0; e &lt; uif-&gt;desc.bNumEndpoints; e++) {<br=
>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; ep =3D &amp;uif-&gt;endpoint[e];<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch (ep-&gt;desc.bmAttributes
 &amp; USB_ENDPOINT_XFERTYPE_MASK) {<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case USB_ENDPOINT_XFER_ISOC:<br>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; if (ep-&gt;desc.bEndpointAddress &amp; USB_DIR_IN)<br>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; in&nbsp; =3D ep;<br>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; else
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; out =3D ep;<br>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; break;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!in || !out)<br>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BT_DBG(&quot;Isoc=
 endpoints not found&quot;);
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else {<br>+&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; B=
T_DBG(&quot;isoc ifnum %d alts %d&quot;, isocIfnum, isocAlt);<br>+&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (usb_=
set_interface(usbdevice, isocIfnum, isocAlt)) {<br>+&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BT_=
ERR(&quot;Can&#39;t set isoc interface settings&quot;);
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; hUSB-&gt;isoc_iface =3D isocIface;<br>+&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; usb_driver_release_interface(&amp;hci_usb_driver, isocIface);<br>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; hUSB-&gt;isoc_iface =3D NULL;<br>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else {
<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; hUSB-&gt;isoc_iface&nbsp; =3D isocIface;<br>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; hUSB-&gt;isoc_in_ep&nbsp; =3D in;<br>+&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; hU=
SB-&gt;isoc_out_ep&nbsp; =3D out;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; }<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br=
>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; set_bit(HCI_USB_TX_WAKEUP, &amp;hUS=
B-&gt;state);
<br>+&nbsp;&nbsp;&nbsp; }<br>+<br>+}<br>+&nbsp; <br>+<br>+<br>&nbsp;static =
struct usb_driver hci_usb_driver =3D {<br>&nbsp;&nbsp;&nbsp;&nbsp; .name&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D &quot;hci_usb&quot;,<br>&nbsp;&nbsp;=
&nbsp;&nbsp; .probe&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D hci_usb_probe,=
<br>

------=_Part_19967_6038016.1177413190756--


--===============0429618246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0429618246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0429618246==--
