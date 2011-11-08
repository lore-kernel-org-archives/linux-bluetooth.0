Return-Path: <cyrus@holtmann.org>
From: "Yao, Costa" <cqyao@qca.qualcomm.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "padovan@profusion.mobi"
	<padovan@profusion.mobi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:ath3k&btusb: Add support for Qualcomm Atheros
 3006 composite device
Date: Tue, 8 Nov 2011 03:13:00 +0000
Message-ID: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62@nasanexd02b.na.qualcomm.com>
Content-Type: multipart/alternative;
	boundary="_000_07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62nasanexd02bnaqual_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62nasanexd02bnaqual_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 312e18c8c46527cb7213fa57afc32094cdc9459c Mon Sep 17 00:00:00 2001
From: Costa yao <cqyao@qca.qualcomm.com>
Date: Thu, 3 Nov 2011 14:45:33 +0800


AR3006 is a composite device, and interface 0 is used for hid function, not=
 bluetooth function.
So, we should make the following changes:
1  Blacklist AR3006 PID/VID in btusb and ath3k to load patch and sysconfig =
files
2  Add composite_device_table in btusb.c and ath3k_composite_device_table i=
n ath3k.c
    to check whether it is bluetooth interface
3  interface 3 is used for data->isoc

Signed-off-by: Costa yao <cqyao@qca.qualcomm.com>
---
drivers/bluetooth/ath3k.c |   67 ++++++++++++++++++++++++++++++++++++++++++=
+--
drivers/bluetooth/btusb.c |   36 +++++++++++++++++++++++-
2 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 1622772..5c877c7 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -40,6 +40,7 @@

#define ATH3K_MODE_MASK                                    0x3F
#define ATH3K_NORMAL_MODE                    0x0E
+#define ATH3K_PREBOOT_MODE                            0x0D

#define ATH3K_PATCH_UPDATE                      0x80
#define ATH3K_SYSCFG_UPDATE                    0x40
@@ -71,6 +72,7 @@ static struct usb_device_id ath3k_table[] =3D {

        /* Atheros AR3012 with sflash firmware*/
       { USB_DEVICE(0x0CF3, 0x3004) },
+     { USB_DEVICE(0x0CF3, 0x3006) },

        /* Atheros AR5BBU12 with sflash firmware */
       { USB_DEVICE(0x0489, 0xE02C) },
@@ -81,16 +83,26 @@ static struct usb_device_id ath3k_table[] =3D {
MODULE_DEVICE_TABLE(usb, ath3k_table);

#define BTUSB_ATH3012                0x80
+#define BTUSB_ATH3006                0x0100
/* This table is to load patch and sysconfig files
  * for AR3012 */
static struct usb_device_id ath3k_blist_tbl[] =3D {

        /* Atheros AR3012 with sflash firmware*/
       { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },
+     { USB_DEVICE(0x0cf3, 0x3006), .driver_info =3D BTUSB_ATH3006 },

        { }      /* Terminating entry */
};

+/* Atheros composite devices table
+ */
+static struct usb_device_id ath3k_composite_device_table[] =3D {
+
+       { USB_DEVICE(0x0cf3, 0x3006) },
+
+       { }      /* Terminating entry */
+};
#define USB_REQ_DFU_DNLOAD 1
#define BULK_SIZE                  4096
#define FW_HDR_SIZE           20
@@ -361,11 +373,20 @@ static int ath3k_probe(struct usb_interface *intf,
       const struct firmware *firmware;
       struct usb_device *udev =3D interface_to_usbdev(intf);
       int ret;
+      unsigned char fw_state;
+      const struct usb_device_id *match_comp_dev;

        BT_DBG("intf %p id %p", intf, id);
-
-        if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
-                 return -ENODEV;
+    /* For composite device */
+       match_comp_dev =3D usb_match_id(intf, ath3k_composite_device_table)=
;
+       if (match_comp_dev)
+      {
+               if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
+                        return -ENODEV;
+      }else {
+               if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
+                        return -ENODEV;
+      }

        /* match device ID in ath3k blacklist table */
       if (!id->driver_info) {
@@ -399,6 +420,46 @@ static int ath3k_probe(struct usb_interface *intf,
                }
                ath3k_switch_pid(udev);
                return 0;
+       } else if (id->driver_info & BTUSB_ATH3006) {
+
+                if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
+               {
+                        BT_ERR("ath3k_probe: udev->descriptor.bcdDevice");
+                          return -ENODEV;
+               }
+               ret =3D ath3k_get_state(udev, &fw_state);
+                if (ret < 0) {
+                        BT_ERR("ath3k_probe: ath3k_get_state err");
+                          return ret;
+               }
+              if ((fw_state & ATH3K_MODE_MASK) =3D=3D ATH3K_PREBOOT_MODE) =
{
+                          BT_ERR("ath3k_probe: firmware are in preboot mod=
e now");
+                          BT_ERR("ath3k_probe: try to switch to Normal Mod=
e");
+                        ret =3D ath3k_set_normal_mode(udev);
+                        if (ret <0) {
+                               BT_ERR("ath3k_probe: set normal mode failed=
");
+                               return ret;
+                       }
+              }
+                      /*Note we should wait for a while*/
+                      mdelay(100);
+                ret =3D ath3k_load_patch(udev);
+                if (ret < 0) {
+                          BT_ERR("ath3k_probe: Load patch file failed");
+                          return ret;
+                }
+                ret =3D ath3k_load_syscfg(udev);
+                if (ret < 0) {
+                          BT_ERR("ath3k_probe: Load sysconfig file failed"=
);
+                          return ret;
+                }
+                ret =3D ath3k_switch_pid(udev);
+                if (ret < 0) {
+                          BT_ERR("ath3k_probe: switch pid failed");
+                          return ret;
+                }
+
+                return 0;
       }

        ret =3D request_firmware(&firmware, ATH3K_FIRMWARE, &udev->dev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abfc4ee..47e8498 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -55,6 +55,7 @@ static struct usb_driver btusb_driver;
#define BTUSB_BROKEN_ISOC      0x20
#define BTUSB_WRONG_SCO_MTU     0x40
#define BTUSB_ATH3012                0x80
+#define BTUSB_ATH3006                0x0100

 static struct usb_device_id btusb_table[] =3D {
       /* Generic Bluetooth USB device */
@@ -100,6 +101,9 @@ static struct usb_device_id btusb_table[] =3D {
       /* Canyon CN-BTU1 with HID interfaces */
       { USB_DEVICE(0x0c10, 0x0000) },

+       /* Qualcomm atheros with HID interfaces */
+       { USB_DEVICE(0x0cf3, 0x3006) },
+
       { }      /* Terminating entry */
};

@@ -122,6 +126,7 @@ static struct usb_device_id blacklist_table[] =3D {

        /* Atheros 3012 with sflash firmware */
       { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },
+       { USB_DEVICE(0x0cf3, 0x3006), .driver_info =3D BTUSB_ATH3006 },

        /* Atheros AR5BBU12 with sflash firmware */
       { USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },
@@ -179,6 +184,18 @@ static struct usb_device_id blacklist_table[] =3D {
       { }      /* Terminating entry */
};

+/*
+ * For composite device, interface 0 may be not for bluetooth function.
+ * It is better to let the vendor code to handle this situation.
+ * So, We use composite_device_table to record the composite devices.
+ */
+static struct usb_device_id composite_device_table[] =3D {
+       /* Qualcomm Atheros composite device 3006 */
+       { USB_DEVICE(0x0cf3, 0x3006) },
+
+       { }      /* Terminating entry */
+};
+
#define BTUSB_MAX_ISOC_FRAMES    10

 #define BTUSB_INTR_RUNNING  0
@@ -909,13 +926,25 @@ static int btusb_probe(struct usb_interface *intf,
       struct btusb_data *data;
       struct hci_dev *hdev;
       int i, err;
+       const struct usb_device_id *match_comp_dev;

        BT_DBG("intf %p id %p", intf, id);
+      /* For composite device
+     * it may not the case that interface 0 is for bluetooth function.
+     */
+       match_comp_dev =3D usb_match_id(intf, composite_device_table);
+       if (match_comp_dev)
+       {
+              if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
+                       return -ENODEV;
+              goto match_id;
+       }

        /* interface numbers are hardcoded in the spec */
       if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
                return -ENODEV;

+match_id:
       if (!id->driver_info) {
                const struct usb_device_id *match;
                match =3D usb_match_id(intf, blacklist_table);
@@ -935,7 +964,7 @@ static int btusb_probe(struct usb_interface *intf,
       if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
                return -ENODEV;

-        if (id->driver_info & BTUSB_ATH3012) {
+       if ((id->driver_info & BTUSB_ATH3012) || (id->driver_info & BTUSB_A=
TH3006)) {
                struct usb_device *udev =3D interface_to_usbdev(intf);

                 /* Old firmware would otherwise let ath3k driver load
@@ -1059,6 +1088,11 @@ static int btusb_probe(struct usb_interface *intf,
                }
       }

+       if (id->driver_info & BTUSB_ATH3006) {
+                BT_ERR("hardcoded: Interface 3");
+                data->isoc =3D usb_ifnum_to_if(data->udev, 3);
+    }
+
       if (data->isoc) {
                err =3D usb_driver_claim_interface(&btusb_driver,
                                                               data->isoc, =
data);
--
1.7.4.1

--_000_07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62nasanexd02bnaqual_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">From 312e18c8c46527cb7213fa57af=
c32094cdc9459c Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Costa yao &lt;</span><spa=
n lang=3D"EN-US">cqyao@qca.qualcomm.com</span><span lang=3D"EN-US">&gt;<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Thu, 3 Nov 2011 14:45:33 =
&#43;0800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">AR3006 is a composite device, a=
nd interface 0 is used for hid function, not bluetooth function.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">So, we should make the followin=
g changes:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1&nbsp; Blacklist AR3006 PID/VI=
D in btusb and ath3k to load patch and sysconfig files<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2&nbsp; Add composite_device_ta=
ble in btusb.c and ath3k_composite_device_table in ath3k.c<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; to check whe=
ther it is bluetooth interface<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3&nbsp; interface 3 is used for=
 data-&gt;isoc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Costa yao &lt;</=
span><span lang=3D"EN-US">cqyao@qca.qualcomm.com</span><span lang=3D"EN-US"=
>&gt;</span><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">drivers/bluetooth/ath3k.c |&nbs=
p;&nbsp; 67 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">drivers/bluetooth/btusb.c |&nbs=
p;&nbsp; 36 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2 files changed, 99 insertions(=
&#43;), 4 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/drivers/bluetooth/=
ath3k.c b/drivers/bluetooth/ath3k.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 1622772..5c877c7 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/drivers/bluetooth/ath3k.c=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/drivers/bluet=
ooth/ath3k.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -40,6 &#43;40,7 @@<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:5.25pt"><span lang=3D"EN-US">#d=
efine ATH3K_MODE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0x3F<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:5.25pt"><span lang=3D"EN-US">#d=
efine ATH3K_NORMAL_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0E<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#define ATH3K_PREBOOT_MODE=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x0D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:5.25pt"><span lang=3D"EN-US">#d=
efine ATH3K_PATCH_UPDATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x80<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:5.25pt"><span lang=3D"EN-US">#d=
efine ATH3K_SYSCFG_UPDATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -71,6 &#43;72,7 @@ static st=
ruct usb_device_id ath3k_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Atheros AR3012 with sflash firmware*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0CF3, 0x3004) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; {=
 USB_DEVICE(0x0CF3, 0x3006) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Atheros AR5BBU12 with sflash firmware */<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0489, 0xE02C) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -81,16 &#43;83,26 @@ static =
struct usb_device_id ath3k_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">MODULE_DEVICE_TABLE(usb, ath3k_=
table);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:5.25pt"><span lang=3D"EN-US">#d=
efine BTUSB_ATH3012&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#define BTUSB_ATH3006&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x0100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/* This table is to load patch =
and sysconfig files<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * for AR3012 */<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static struct usb_device_id ath=
3k_blist_tbl[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Atheros AR3012 with sflash firmware*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; {=
 USB_DEVICE(0x0cf3, 0x3006), .driver_info =3D BTUSB_ATH3006 },<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; { }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Terminating entry */<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/* Atheros composite devic=
es table<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;static struct usb_device_i=
d ath3k_composite_device_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { USB_DEVICE(0x0cf3, 0x3006) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Terminating entry */<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define USB_REQ_DFU_DNLOAD 1<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define BULK_SIZE&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 4096<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define FW_HDR_SIZE&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -361,11 &#43;373,20 @@ stati=
c int ath3k_probe(struct usb_interface *intf,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; const struct firmware *firmware;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct usb_device *udev =3D interface_to_usbdev(intf);<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int ret;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
unsigned char fw_state;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
const struct usb_device_id *match_comp_dev;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; BT_DBG(&quot;intf %p id %p&quot;, intf, id);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (intf-&gt;cur_altsetting-&gt;desc.bInterfaceNumber !=3D 0)<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -=
ENODEV;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* For =
composite device */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; match_comp_dev =3D usb_match_id(intf, ath3k_composite_device_tab=
le);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (match_comp_dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (intf-&gt;cur_alts=
etting-&gt;desc.bInterfaceNumber !=3D 2)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
}else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (intf-&gt;cur_alts=
etting-&gt;desc.bInterfaceNumber !=3D 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* match device ID in ath3k blacklist table */<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!id-&gt;driver_info) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -399,6 &#43;420,46 @@ static=
 int ath3k_probe(struct usb_interface *intf,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ath3k_switch_pi=
d(udev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (id-&gt;driver_info &amp; BTUSB_ATH3006) {<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (le16_t=
o_cpu(udev-&gt;descriptor.bcdDevice) &gt; 0x0001)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe: udev-&gt;descrip=
tor.bcdDevice&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ath3k_get_sta=
te(udev, &amp;fw_state);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &l=
t; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe: ath3k_get_state =
err&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fw_state &amp; ATH3K_M=
ODE_MASK) =3D=3D ATH3K_PREBOOT_MODE) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe:=
 firmware are in preboot mode now&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe:=
 try to switch to Normal Mode&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ath3k_set_normal_mode(udev);<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt;0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ER=
R(&quot;ath3k_probe: set normal mode failed&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /*Note we should wait for a while*/<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; mdelay(100);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D at=
h3k_load_patch(udev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &l=
t; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe:=
 Load patch file failed&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D at=
h3k_load_syscfg(udev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &l=
t; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe:=
 Load sysconfig file failed&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D at=
h3k_switch_pid(udev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &l=
t; 0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&quot;ath3k_probe:=
 switch pid failed&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ret =3D request_firmware(&amp;firmware, ATH3K_FIRMWARE, &amp;ud=
ev-&gt;dev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/drivers/bluetooth/=
btusb.c b/drivers/bluetooth/btusb.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index abfc4ee..47e8498 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/drivers/bluetooth/btusb.c=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/drivers/bluet=
ooth/btusb.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -55,6 &#43;55,7 @@ static st=
ruct usb_driver btusb_driver;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define BTUSB_BROKEN_ISOC&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x20<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define BTUSB_WRONG_SCO_MTU&nbs=
p;&nbsp;&nbsp;&nbsp; 0x40<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define BTUSB_ATH3012&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x80<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;#define BTUSB_ATH3006&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x0100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;static struct usb_device_=
id btusb_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* Generic Bluetooth USB device */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -100,6 &#43;101,9 @@ static =
struct usb_device_id btusb_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* Canyon CN-BTU1 with HID interfaces */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0c10, 0x0000) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Qualcomm atheros with HID interfaces */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { USB_DEVICE(0x0cf3, 0x3006) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Terminating entry */<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -122,6 &#43;126,7 @@ static =
struct usb_device_id blacklist_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Atheros 3012 with sflash firmware */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { USB_DEVICE(0x0cf3, 0x3006), .driver_info =3D BTUSB_ATH3006 },<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* Atheros AR5BBU12 with sflash firmware */<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -179,6 &#43;184,18 @@ static=
 struct usb_device_id blacklist_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; { }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Terminating entry */<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * For composite device, i=
nterface 0 may be not for bluetooth function.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * It is better to let the=
 vendor code to handle this situation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * So, We use composite_de=
vice_table to record the composite devices.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;static struct usb_device_i=
d composite_device_table[] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Qualcomm Atheros composite device 3006 */<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { USB_DEVICE(0x0cf3, 0x3006) },<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Terminating entry */<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define BTUSB_MAX_ISOC_FRAMES&n=
bsp;&nbsp;&nbsp; 10<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;#define BTUSB_INTR_RUNNIN=
G&nbsp; 0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -909,13 &#43;926,25 @@ stati=
c int btusb_probe(struct usb_interface *intf,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct btusb_data *data;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct hci_dev *hdev;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int i, err;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct usb_device_id *match_comp_dev;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; BT_DBG(&quot;intf %p id %p&quot;, intf, id);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; &nbsp;&nbsp;&nbsp;&nbsp; =
/* For composite device <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp; &nbsp;* it m=
ay not the case that interface 0 is for bluetooth function.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; &nbsp; &nbsp;*/<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; match_comp_dev =3D usb_match_id(intf, composite_device_table);<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (match_comp_dev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (intf-&gt;cur_altsetting=
-&gt;desc.bInterfaceNumber !=3D 2)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto match_id;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* interface numbers are hardcoded in the spec */<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (intf-&gt;cur_altsetting-&gt;desc.bInterfaceNumber !=3D 0)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;match_id:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!id-&gt;driver_info) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct us=
b_device_id *match;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match =3D usb_m=
atch_id(intf, blacklist_table);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -935,7 &#43;964,7 @@ static =
int btusb_probe(struct usb_interface *intf,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ignore_sniffer &amp;&amp; id-&gt;driver_info &amp; BTUSB_SNIFFER)=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (id-&gt;driver_info &amp; BTUSB_ATH3012) {<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((id-&gt;driver_info &amp; BTUSB_ATH3012) || (id-&gt;driver_i=
nfo &amp; BTUSB_ATH3006)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct usb_devi=
ce *udev =3D interface_to_usbdev(intf);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Old fi=
rmware would otherwise let ath3k driver load<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1059,6 &#43;1088,11 @@ stat=
ic int btusb_probe(struct usb_interface *intf,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (id-&gt;driver_info &amp; BTUSB_ATH3006) {<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT_ERR(&qu=
ot;hardcoded: Interface 3&quot;);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;i=
soc =3D usb_ifnum_to_if(data-&gt;udev, 3);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (data-&gt;isoc) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D usb_dri=
ver_claim_interface(&amp;btusb_driver,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;isoc, data);<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1.7.4.1<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62nasanexd02bnaqual_--
