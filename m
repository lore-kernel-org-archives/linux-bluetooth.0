Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez BNEP connection close
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6.1.2.0.2.20050124180402.041c1eb0@pop.gmx.net>
References: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es>
	 <1106581771.8058.49.camel@pegasus>
	 <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net>
	 <1106583831.8058.52.camel@pegasus>
	 <6.1.2.0.2.20050124180402.041c1eb0@pop.gmx.net>
Content-Type: text/plain
Message-Id: <1106585260.8058.56.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 24 Jan 2005 17:47:40 +0100

Hi George,

>  >I actually expected to see this kind of messages. Seems like you should
>  >replace the hardware. What does "hciconfig hci0 version" say about your
>  >Bluetooth adapters?
> 
> hci0:   Type: USB
>          BD Address: 00:02:72:00:D4:29 ACL MTU: 192:8  SCO MTU: 64:8
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>          Manufacturer: Cambridge Silicon Radio (10)

is the SCO support for the hci_usb driver compiled in? Maybe this takes
away the USB bandwidth and this can result in troubles with a 2.4 kernel
and its USB subsystem. With a 2.6 kernel you can disable this with the
module parameter isoc, but I doubt that this is possible with a 2.4
kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
