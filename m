Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Lars Steinke <sf@lsweb.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050404194542.GA7640@lsweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] btsco - headset profile activated but no sco packets transmitted ???
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
Date: Mon, 4 Apr 2005 21:45:42 +0200

Hi there,

while running btsco I can successfully change my mixersettings via 
the headset, so I assume the connection has been established just fine:

root@sigma:~/src/btsco# ./btsco -v 00:07:A4:95:41:76 2
btsco v0.4
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 2 connected
recieved AT+BRSF=24
recieved AT+VGS=03
Sending up speaker change 3
recieved AT+VGS=07
Sending up speaker change 7
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=15
Sending up speaker change 15
speaker volume: 15 mic volume: 1
driver is in use
connected SCO channel
Done setting sco fd

But I can neither hear sound nor record anything via the Jabra BT110
headset using BlueZ 20050328 with kernel 2.6.11:

aplay -D plughw:Headset test.wav
Playing Sparc Audio 'test.wav' : Mu-Law, Rate 8000 Hz, Mono

I just hear a raise in static when playback commences (even though mixer
levels are maxed in alsamixer!)...

snd-bt-sco revision 1.6 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm

root@sigma:~# hcitool con
Connections:
        < SCO 00:07:A4:95:41:76 handle 44 state 1 lm SLAVE
        < ACL 00:07:A4:95:41:76 handle 41 state 1 lm MASTER
root@sigma:~# hciconfig hci0
hci0:   Type: USB
        BD Address: 00:02:72:80:A5:D3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:9966 acl:207 sco:0 events:535 errors:0
        TX bytes:6279 acl:191 sco:0 commands:195 errors:0

root@sigma:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:80:A5:D3 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.14
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

Audio works fine with that headset and dongle using the Widcomm stack
1.4 under Windoze ;(...

Regards,
Lars


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
