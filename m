Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 May 2008 14:36:02 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <508684.60714.qm@web52902.mail.re2.yahoo.com>
Cc: rankincj@yahoo.com
Subject: Re: [Bluez-users] USB dongle cannot pair with A2DP speakers
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

> I had a pairing & timing problem like this with an at&t tilt. It might
> work for you to log out of the machine and from the console, run
> 
> passkey-agent --default 0000 &
> 
> then attempt the connection using command-line tools (like aplay in your case).

Hi,

Thanks for the reply. I'm not sure that this is a timing issue, because I did manage to "win" the
race once or twice, and it still didn't work. However, I tried your suggestion with the
passkey-agent, and aplay failed with this error:

ALSA lib pcm_bluetooth.c:1589:(bluetooth_init) BT_GETCAPABILITIES failed : Input/output error(5)
aplay: main:546: audio open error: Input/output error

This "Input/output error" is the same error I get when I "win" the race to enter the passkey with
bluez-gnome. Interestingly, my laptop's bluetooth adaptor doesn't suffer from this race - the
connection with the speakers stays up until I can send the pin code.

To be honest, I don't think I've ever managed to use something with the particular Belkin adapter,
although my only other bluetooth device is a headset. (Is Voice/SCO supposed to work in an
unpatched 2.6.25.x kernel?) Apparently, I have a v2.0 adapter although it's meant to be backwards
compatible with v1.2. Both this adapter and my laptop are using Broadcom chips, and here is the
hciconfig output from my (working) laptop:

hci0:   Type: USB
        BD Address: 00:19:7E:EB:29:5A ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:2810088 acl:37 sco:55020 events:84 errors:0
        TX bytes:1241 acl:34 sco:0 commands:51 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'lantern.modemnet-0'
        Class: 0x000404
        Service Classes: Unspecified
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 2.0 (0x3) HCI Rev: 0x212b LMP Ver: 2.0 (0x3) LMP Subver: 0x41d3
        Manufacturer: Broadcom Corporation (15)

Cheers,
Chris



      __________________________________________________________
Sent from Yahoo! Mail.
A Smarter Email http://uk.docs.yahoo.com/nowyoucan.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
