Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061210053749.GA11996@163.com>
References: <e4f1f0110612091109r3a89fa38t96afa23c7167e9d4@mail.gmail.com>
	<20061210053749.GA11996@163.com>
Date: Sun, 10 Dec 2006 13:30:14 +0100
Message-Id: <1165753814.22251.2.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Has my passkey agent registered?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> > I get the following message even when I have the passkey-agent from utils,
> > or the gnome bluetooth-applet.
> > 
> > I've heard I should be able to find out if the passkey-agent is registered
> > by reading the syslog. I use Fedora Core 5, but I don't know where that is -
> > do I need to set a config file somewhere to tell bluez where to log to?
> > 
> > 
> > HCI sniffer - Bluetooth packet analyzer ver 1.32
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >    bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > >HCI Event: Command Status (0x0f) plen 4
> >    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > >HCI Event: Link Key Request (0x17) plen 6
> >    bdaddr 00:16:53:03:1D:31
> > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> >    bdaddr 00:16:53:03:1D:31 key 918D88F4AB15B646C499779B3252344B
> > >HCI Event: Command Complete (0x0e) plen 10
> >    Link Key Request Reply (0x01|0x000b) ncmd 1
> >    status 0x00 bdaddr 00:16:53:03:1D:31
> > >HCI Event: Connect Complete (0x03) plen 11
> >    status 0x05 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00
> >    Error: Authentication Failure
>
> It seems that your computer have paired with the device before and
> stored the link key. So there is no need to call the passkey-agent to
> get a new PIN code from the user. You can use 
> 	hcitool key device_addr
> to change the link key, and this will ask you for a new PIN code.

actually that is wrong. There will be no request for a new PIN code.
Once a link key has been created, this link key can be used to create a
new link key. However to use this key, you need a successful established
and authenticated connection. This is not the case here.

And this is a security mode 3 connection. Make sure that your own device
in not in security mode 3, because this messes things up no matter what.
My simple guess would be that the link key is no longer valid and the
remote device needs to be put into pairing mode. So you can either do
that or remove the link with RemoveBonding D-Bus method.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
