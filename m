Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Feb 2008 01:03:17 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <946355.48557.qm@web8415.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802190059000.13298@nge2.ngu.pk>
References: <946355.48557.qm@web8415.mail.in.yahoo.com>
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


On Tue, 19 Feb 2008, pramod gurav wrote:

-> hi All
-> I got my headset working ...

<cheers>


-> I bought one new BT dongle which clamed it supports HS audio Gtaeway.
-> It is a product of ENTER multimedia.
-> this is it.
-> [root@localhost Pramod]# /usr/local/sbin/hciconfig -a
-> hci0:   Type: USB
->         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
->         UP RUNNING PSCAN ISCAN
->         RX bytes:10283222 acl:386 sco:201151 events:719 errors:0
->         TX bytes:10319322 acl:347 sco:202172 commands:192 errors:0
->         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
->         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
->         Link policy: RSWITCH HOLD SNIFF PARK
->         Link mode: SLAVE ACCEPT
->         Name: 'BlueZ (0)'
->         Class: 0x080100
->         Service Classes: Capturing
->         Device Class: Computer, Uncategorized
->         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe
->         Manufacturer: Integrated System Solution Corp. (57)

Notice this one: SCO MTU: 48:10. The last one ended in zero. Maybe that was 
showing there was a problem after all? (learning as I go along, too)


-> Thanks to all who have given me their valuable time for this.
-> Especially thanks to Jayjwa who helped me a lot.

You're welcome.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
