Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Anyone using a NEC e606 and BlueZ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik =?ISO-8859-1?Q?Hallg=E5rde?= <fredrik@libcon.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F66141E.6050201@libcon.net>
References: <3F66141E.6050201@libcon.net>
Content-Type: text/plain
Message-Id: <1063710802.22723.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 16 Sep 2003 13:13:16 +0200

Hi Fredrik,

> I have serious problems keeping the ppp-connection via bluetooth.
> The system is as follows:
> mh3-patched Linux 2.4.21
> IOGEAR GBU-301 (USB BC2033)
> NEC e606 (3G/UMTS) Mobile
> 
> Using bluefw I get hci0 working.
> Binding with rfcomm works.
> I connect with rp3-config (RedHat ppp-dialer config)
> the connection comes up, setting routing etc.
> after a few moments (10-30 sec) te connection dies.
> 
> After that the bluetooth device seems stop working...

first, give us some infos about your devices.

	hciconfig -a
	hcitool info <nec-e606-addr>
	sdptool browse --tree <nec-e606-addr>

> Any ideas? Any part of BlueZ kernelpatches I must have? (I think I 
> didn't put i zero-packets) Should I post any specific dumps/logfiles?

Using 2.4.22-mh1 should be fine. A "hcidump -w <file>" and the pppd logs
will maybe help.

Have your tried other programs like "attest" from bluez-utils/test/
directory to verify that some stuff is working.

What is your data layer? GPRS? Do have special AT commands for the PPP
setting?

What happens if you use "rfcomm connect ..."? Is the RFCOMM connection
also closed or did only the PPP part dies.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
