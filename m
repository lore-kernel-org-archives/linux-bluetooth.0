Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Message-ID: <d7qmmr$3fc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] btsco and Jabra Headset
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
Date: Sat, 04 Jun 2005 00:51:12 +0200

Hi!

I've had a hard time trying to get my headset working but had no success so
far. :-(

I've found single report on the syptoms I get on the net
(http://www.linuxforen.de/forums/archive/index.php/t-182494.html), but
unfortunately no solution/follow up posting...

I'm also happy abaout RTFMs, maybe I missed something - these are my first
steps with bluetooth.

I'm running a vanilla 2.6.11.11 kernel with all those bluetooth drivers
compiled as modules. (Further systems details can be found at the end of
this mail.) The bluetooth USB stick is recognized and driven by the ohci
driver, so it's probably no ehci issue...

These are the symptoms:

***
# btsco -v 00:07:A4:05:2E:14
btsco v0.4c
Device is 2:0
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied
CoriCelesti:/usr/src#
***

This happens no matter if I run it as root or my normal user. (which is in
group dialup, all the /dev/rfcomm1 belong to group dialup) The btsco is a
CVS checkout from yesterday.

The bluetooth dongle:

***
kernel: usb 1-7: new full speed USB device using ohci_hcd and address 10
***

***
CoriCelesti:/usr/src# hciconfig -a
hci0:   Type: USB
        BD Address: 00:09:DD:10:62:ED ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:300 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'CoriCelesti-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x639 LMP Ver: 1.1 (0x1) LMP Subver:
0x639
        Manufacturer: Cambridge Silicon Radio (10)

CoriCelesti:/usr/src#
***

Device scan (headset in pairing mode):

***
gunter@CoriCelesti:~$ hcitool scan
Scanning ...
        00:07:A4:05:2E:14       JABRA BT200
gunter@CoriCelesti:~$
***

Info fails:

*** (as gunter)
gunter@CoriCelesti:~$ hcitool info 00:07:A4:05:2E:14
Requesting information ...
Can't create connection: Operation not permitted
gunter@CoriCelesti:~$
*** (as root)
CoriCelesti:/usr/src# hcitool info 00:07:A4:05:2E:14
Requesting information ...
Can't create connection: Input/output error
CoriCelesti:/usr/src#
***

I already tried to delete /etc/bluetooth/pin and to write the default pin
into it, to no avail.

strace says btsco fails during a connect call:

***
connect(4, {sa_family=AF_BLUETOOTH, sa_data="\1\0\24
\5\244\7\0\0\0\0\0\0\0"}, 10) = -1 EACCES (Permission denied)
close(4)                                = 0
write(2, "Error: ", 7Error: )                  = 7
write(2, "Failed to connect to SDP server:"..., 70Failed to connect to SDP
server: Permission denied
***

Are there any obvious mistakes or does anyone have any hints? As I said I'm
new to this whole bluetooth technology so maybe I'm missing something
really obvious... :-/

I really appreciate any help!

Greetings,

  Gunter



System:
Athlon64 3000+ at Asus A8N SLI Board, nVidia NForce4 Chipset

Distribution:
Debian SID, 'Pure64' platform
custom-compiled 2.6.11.11 vanilla kernel

-- 
"There is a considerable overlap in intelligence between the smarter 
perl scripts and the dumber users."        -- Wolfgang Rupprecht
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
