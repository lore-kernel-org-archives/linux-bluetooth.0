Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Lukas <christoph.lukas@gmx.net>
To: bluez-users@lists.sourceforge.net
Date: Mon, 19 Jun 2006 21:56:06 +0200
Message-Id: <1150746967.5012.13.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] Slow connection to Motorola H500 Headset
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

I am trying to use my Motorola Headset H500 as a bluetooth audio
device. 

Audio transfer is working perfectly in both directions, the only minor
annoyance is that it takes several seconds for every connection to be
established. 
This makes it difficult to use the headset as an audio device for VoIP
as there is a gap of up to 5 seconds between pressing 'accept call' and
an established audio connection. 

These connection delays also happen with using a simple:

aplay -D plughw:Headset soundfile.wav

I am running Ubuntu Dapper with kernel 2.6.15, bluez-utils 2.24,
snd-bt-sco 1.11 and btsco v0.42.

btsco -v <addr> shows:

btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 2 connected
Using interface hci0
recieved AT+BRSF=26
speaker volume: 7 mic volume: 1
i/o needed: connecting sco...
   <several seconds here>
connected SCO channel
Done setting sco fd
recieved AT+VGS=07
Sending up speaker change 7
speaker volume: 7 mic volume: 1
driver is not in use
disconnected SCO channel


and hcidump -t shows:

1150745951.394107 < HCI Command: Add SCO Connection (0x01|0x0007) plen 4
1150745951.399620 > HCI Event: Command Status (0x0f) plen 4
1150745956.366798 > HCI Event: Connect Complete (0x03) plen 11
1150745956.389809 > SCO data: handle 41 dlen 48
1150745956.389813 > SCO data: handle 41 dlen 48
1150745956.389818 > SCO data: handle 41 dlen 48
1150745956.389888 < SCO data: handle 41 dlen 48
1150745956.389912 < SCO data: handle 41 dlen 48
1150745956.389930 < SCO data: handle 41 dlen 48


Can I do anything to avoid these delays?

Thanks for any hints.

Regards,
Christoph




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
