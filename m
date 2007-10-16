Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W133C5EC8978F7D66F2C33CC09C0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 16 Oct 2007 09:45:59 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Headset :SCO connection timed out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0636445776=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0636445776==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit



Hi All:

Sorry to post this again and again,but it seems that the last 2 posts i sent from
that gmail address turned out to be some strange code.(Probably because
of the rich text format)

Right now,I'm doing a project aiming to enable the bluez audio feature
on linux 2.6.18 based on a s3c2410 embeded development board.We are
trying to enable the SCO headset and A2DP audio feature.I'm using
bluez-libs-3.20 and bluez-utils-3.20 and ALSA audio drivers.I've also
applied the 2 patches:"sco-flow-control-4.2 patch" and another kernel
patch "patch-2.6.18-mh8" downloaded from bluez.org . I'm using a
bluetooth adapter called "STLC2500C" based on UART interface.It has a
serial-USB converter on it so it would be connected to my board
through USB.In linux, it would be the device:/dev/ttyUSB0.
The trouble is , i've tried many different ways to play audio via SCO
headset(aplay -D headset /1.wav,hstest play /1.wav 00:0D:3C:EB:53:F0
1....etc),it always result in an "Can't connect SCO audio channel:
Connection timed out" failure.The pairing procedure is okey.
Here are some detailed information:

First,these are the commands i put in the /etc/init.d/rcS
initialization procedures:
hciattach ttyUSB0 any
hciconfig hci0 up
rm -f /var/run/messagebus.pid
dbus-daemon --system --fork
hcid -n -d -f /etc/bluetooth/hcid.conf &
sdpd -n &
a2dpd -n &
hcitool scan
hciconfig -a
sdptool add A2SRC
sdptool add A2SNK
sdptool add AVRTG
sdptool add hs
sdptool add hf
headsetd -n &
hciconfig hci0 voice 0x0060

#hciconfig hci0 revision£º
hci0: Type: UART
BD Address: 00:80:E1:00:00:00 ACL MTU: 1021:7 SCO MTU: 0:0

STLC2500 R4.2 12102005 12:40:14 ZAV100012
HW Id= V440BAA
(My SCO MTU is 0:0,is this okey?)

#aplay -D headset /1.wav
Can't connect SCO audio channel: Connection timed out

# hstest play /1.wav 00:0D:3C:EB:53:F0 1
Voice setting: 0x0060
RFCOMM channel connected
Can't connect SCO audio channel: Connection timed out

(I've also tried btsco,aplay -D plughw:Headset /1.wav,.....etc. the
failures are the same)

#hcitool con
Connections:
< SCO 00:0D:3C:EB:53:F0 handle 0 state 5 lm SLAVE
< ACL 00:0D:3C:EB:53:F0 handle 1 state 1 lm SLAVE ENCRYPT

(it seems the SCO link is incomplete.state=5,not 1.)

I read the headset profile spec:
http://www.bluetooth.com/NR/rdonlyres/5C0DEE05-84CD-4D79-BD52-7ECA283430A0/981/HSP_SPEC_V11.pdf
and on it says that "
The audio gateway controls the SCO link establishment and release." So
i thought maybe i should pay attention to the "Audio Gateway".

Later i found something.I checked out the website "
http://wiki.bluez.org/wiki/Audio" and found that the
/bluez-utils-3.20/audio/gateway.c implements the
org.bluez.audio.gateway interface.But when i looked into the
gateway.c, there's nothing in there.And /bluez-
utils-3.20/audio-api.txt also says that the audio gateway service is
not yet implemented in the current bluez. Is that true? If it is so
,does this means that there's no way we can enable the SCO/A2DP audio
connection to the headset right now?

I'm really confused cause i read about an
article:http://bluetooth-alsa.sourceforge.net/build.html ,which
teaches the reader how to enable bluez audio without mentioning
anything about the org.bluez.audio.gateway implementation.

So is this "audio gateway " necessary for SCO link establishment? Or
there's anything else going wrong ?




Thanks

_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE


--===============0636445776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0636445776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0636445776==--
