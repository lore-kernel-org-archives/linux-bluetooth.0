Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fd87b6160602221602i3e3ea582md5f31fb4b69e5d65@mail.gmail.com>
From: "John McCabe-Dansted" <gmatht@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
Cc: "Administrator TOOTAI" <admin@tootai.net>
In-Reply-To: <43FC9783.5050708@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <43FB7C2C.2030203@tootai.net>
	 <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>
	 <43FC9783.5050708@tootai.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 23 Feb 2006 13:02:54 +1300

On 2/23/06, Administrator TOOTAI <admin@tootai.net> wrote:
> John McCabe-Dansted a =E9crit :
>
> >I found that killing all running kmix processes allowed me to shutdown.
> >this can be done by typing from the command line:
> >        killall kmix
> >        killall -9 kmix
> >
> >Does this help? What desktop are you using? (E.g. KDE or Gnome)
> >
> >
> I killed all stuff concerning sound, it change nothing.

Hmm, have you tryied killing virtually all processes (e.g. by going to
runlevel 1)

Have  you tried applying the patch below and replacing your hci_usb
module (probably only useful if you are using a bluetooth usb dongle)?

...
Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.git.orig/drivers/bluetooth/hci_usb.c
+++ linux-2.6.git/drivers/bluetooth/hci_usb.c
@@ -1043,10 +1043,65 @@
       hci_free_dev(hdev);
 }

+static int hci_usb_suspend(struct usb_interface *intf, pm_message_t messag=
e)
+{
+       struct hci_usb *husb =3D usb_get_intfdata(intf);
+       int i;
+       unsigned long flags;
+       struct list_head killed;
+
+       if (!husb || intf =3D=3D husb->isoc_iface)
+               return 0;
+
+       INIT_LIST_HEAD(&killed);
+
+       for (i =3D 0; i < 4; i++) {
+               struct _urb_queue *q =3D &husb->pending_q[i];
+               struct _urb *_urb, *_tmp;
+               while ((_urb =3D _urb_dequeue(q))) {
+                       /* reset queue since _urb_dequeue sets it to NULL *=
/
+                       _urb->queue =3D q;
+                       usb_kill_urb(&_urb->urb);
+                       list_add(&_urb->list, &killed);
+               }
+               spin_lock_irqsave(&q->lock, flags);
+               list_for_each_entry_safe(_urb, _tmp, &killed, list) {
+                       list_move_tail(&_urb->list, &q->head);
+               }
+               spin_unlock_irqrestore(&q->lock, flags);
+       }
+       return 0;
+}
+
+static int hci_usb_resume(struct usb_interface *intf)
+{
+       struct hci_usb *husb =3D usb_get_intfdata(intf);
+       int i, err =3D 0;
+       unsigned long flags;
+       if (!husb || intf =3D=3D husb->isoc_iface)
+               return 0;
+
+       for (i =3D 0; i < 4; i++) {
+               struct _urb_queue *q =3D &husb->pending_q[i];
+               struct _urb *_urb;
+               spin_lock_irqsave(&q->lock, flags);
+               list_for_each_entry(_urb, &q->head, list) {
+                       err =3D usb_submit_urb(&_urb->urb, GFP_ATOMIC);
+                       if (err) break;
+               }
+               spin_unlock_irqrestore(&q->lock, flags);
+               if (err)
+                       return -EIO;
+       }
+       return 0;
+}
+
 static struct usb_driver hci_usb_driver =3D {
       .name           =3D "hci_usb",
       .probe          =3D hci_usb_probe,
       .disconnect     =3D hci_usb_disconnect,
+       .suspend        =3D hci_usb_suspend,
+       .resume         =3D hci_usb_resume,
       .id_table       =3D bluetooth_ids,
 };

--
John C. McCabe-Dansted
Master's Student


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
