Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Message-ID: <d7ufvb$r2l$1@sea.gmane.org>
References: <d7qmmr$3fc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: btsco and Jabra Headset
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
Date: Sun, 05 Jun 2005 11:21:03 +0200

Gunter Ohrner wrote:
> These are the symptoms:
> ***
> # btsco -v 00:07:A4:05:2E:14
> btsco v0.4c
> Device is 2:0
> Error: Failed to connect to SDP server: Permission denied

I also tried using a different bluetooth USB stick but this one does not
seem to be supported:

***
CoriCelesti:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:11:67:03:D9:89 ACL MTU: 678:8 SCO MTU: 48:5
        Unsupported manufacturer
CoriCelesti:~#
***

So I probaly do not need to make further tests with this one, I guess?

I quick initial test with this stick was not too promising, although the
error message changed:

***
gunter@CoriCelesti:~$ btsco -v 00:07:A4:05:2E:14
btsco v0.4c
Device is 2:0
Error: Failed to connect to SDP server: Connection timed out
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Resource temporarily unavailable
gunter@CoriCelesti:~$
***

Unfortunately I do not have any different remote USB device to test
against... :-(

Does anyone have any additional ideas of what may be going wrong or should I
post to -devel instead?

Greetings,

  Gunter

PS: Details about the other (unsupported?) USB stick:

***
CoriCelesti:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:03:D9:89 ACL MTU: 678:8 SCO MTU: 48:5
        UP RUNNING PSCAN ISCAN
        RX bytes:422 acl:0 sco:0 events:22 errors:0
        TX bytes:349 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'CoriCelesti-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1a4 LMP Ver: 1.1 (0x1) LMP Subver:
0x1a4
        Manufacturer: Integrated System Solution Corp. (57)
CoriCelesti:~#
***
-- 
If the Creator had said, "Let there be light" in Ankh-Morpork, he'd 
have gotten no further because of all the people saying "What colour?"  
      -- (Terry Pratchett, Men At Arms)
*** PGP-Verschlüsselung bei eMails erwünscht :-) *** PGP: 0x1128F25F ***



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
