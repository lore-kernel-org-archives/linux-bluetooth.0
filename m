Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Feb 2008 07:47:12 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <867146.70553.qm@web8414.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802120734360.18433@nge2.ngu.pk>
References: <867146.70553.qm@web8414.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


On Mon, 11 Feb 2008, pramod gurav wrote:

-> i tried adding options hci_usb force_scofix=1 to file etc/modprobe.d/bluez
-> but this file was not there I created it and added the option.
-> But no change

I'm not sure modprobe looks in that file. By default, it looks in 
/etc/modprobe.conf. Run 'strings /sbin/modprobe | grep conf' and you can see 
where it's looking.

-> One more thing is i have no module called hci_usb found when I do
-> [Pramod@localhost ~]$ lsmod | grep hci
-> uhci_hcd               29072  0

Hm. I wonder what is running your adapter then? Maybe it's compiled in? 
If there is CONFIG_BT_HCIUSB=y in your kernel config, then it is.


-> This is some info i would like to share 
-> [Pramod@localhost ~]$ cat /etc/modules.conf
->  #Bluez
-> #alias net-pf-31      bluez
-> #alias bt-proto-0     l2cap
-> alias net-pf-31 bluez
-> alias bt-proto-0 l2cap
-> alias bt-proto-2 sco
-> alias bt-proto-3 rfcomm

That's an old file, and you can probably kill it. All that info should be in 
the modprobe.conf now. Your alias for net-pf-31 should point to 'bluetooth', 
as that is the module for bluetooth protocol on modern kernels. There is no 
more 'bluez' module as far as I can tell.


-> [Pramod@localhost ~]$ /usr/local/sbin/hciconfig -a
-> hci0:   Type: USB
->         BD Address: 00:0B:0D:33:9E:FB ACL MTU: 120:20 SCO MTU: 64:0
->         UP RUNNING PSCAN ISCAN
->         RX bytes:6912199 acl:71 sco:135480 events:72 errors:0
->         TX bytes:1053 acl:35 sco:0 commands:30 errors:0
->         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
->         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
->         Link policy: HOLD PARK

I have 'lp rswitch,hold,sniff,part' in my hcid.conf, so there is those names 
above in "Link policy". I'm not sure if it matters here or not but I thought 
I'd mention it.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
