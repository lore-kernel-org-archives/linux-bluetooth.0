Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't get di Nuovo works in BT :'( help please.  (a bit long, sorry)
References: <1082745203.718.0.camel@darthvader.linuxkot.kap> <1082809790.4828.15.camel@pegasus> <1082819279.13178.0.camel@darthvader.linuxkot.kap>
In-Reply-To: <1082819279.13178.0.camel@darthvader.linuxkot.kap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200404241719.17583.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 24 Apr 2004 17:19:17 +0200

If your mouse doesn't work, try look into hcid.conf and find
out, if you have:

        auth disable;
        encrypt disable;

Michal

On Saturday 24 of April 2004 17:08, Di Pietro Nicolas wrote:
> Le sam 24/04/2004 =E0 14:29, Marcel Holtmann a =E9crit :
> > Hi Nicolas,
> >
> > > At the moment, the keyboard works and the media pad also (without the
> > > screen but
> > > for now, I don't care), the multimedia key doesn't work (some a of th=
em
> > > but not
> > > much) and the mouse doen't work at all.
> >
> > your report is totally messed up. Works, works not, done this, done
> > that, this device is ok and that is not. I can only help you if you
> > write in clear words what you are trying to do and what you've done so
> > far. Do it step by step and actually you should start with getting
> > hid2hci working reliable.
> >
> > Regards
> >
> > Marcel
>
> Okay, I'm sorry if it's messed up.
> What I've done :
> -patched kernel2.6.5 against patch-2.6.5-mh3.gz
> -I've looked if I've the multibyte support in hid, seems okay.
> -compiled utils2 and libs2 from CVS
>
> What works always :
> the keyboard
> the media pad in numpad mode
>
> What works somtimes :
> the mouse
> the media pad in nav mode
>
> What's the matter :
> Generally, the mouse doesn't work, the media pad in nav mode not either.
> I don't know why and when.
> In this case, when I move the mouse up/down, it scroll or click.
> If I move the mouse left/right, it move up/down and scroll
> the media pad in nav mode move the cursor (but in a odd way)
>
> if I try hid2hci (following the
> http://www.bueche.ch/comp/mx900/feedback/ghisoli_alexandre_mx900_with_hub=
=2Et
>xt advices, I get
> Switching device 046d:c704 to HCI mode failed (No such file or
> directory)
>
> In the other case (when the mouse work an the media pad also)
> It seems that this case appear more frequently if there is no
> batteries/cells in the mouse or media pad at boot-time.
>
> hid2hci, give me :
> Switching device 046d:c704 to HCI mode was successful
> usb 3-1.2 : new full speed USB deviceusing address 4
> Bluetooth : Core ver 2.4
> hci_usb : Unknow symbol hci_free_dev
> hci_usb : Unknow symbol hci_alloc_dev
> hci_usb : Unknow symbol hci_unregister_dev
> hci_usb : Unknow symbol hci_register_dev
> NET : Registered protocol family 31
> Bluetooth : HCI device and connection manager initialized
> Bluetooth : HCI socket layer initialized
> hci_usb : Unknow symbol hci_free_dev
> hci_usb : Unknow symbol hci_alloc_dev
> hci_usb : Unknow symbol hci_unregister_dev
> hci_usb : Unknow symbol hci_register_dev
> Bluetooth : HCI USB driverver 2.5
> drivers/usb/core/usb.c : registered new driver hci_usb
> and the hub is frozen.
>
> >if you switch to HCI mode, you have to run the HID profile by yourself
>
> before switching ?
> Could you explain that ? (or just give me link)
>
> Thanks a lot for your responses.
> Nicolas
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
