Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20051219132730.790t05fms68kkck8@webmail.rabas.info>
From: stefan@rabas.info
To: bluez-devel@lists.sourceforge.net
Cc: can't@rabas.info, get@rabas.info, a2dp@rabas.info, to@rabas.info,
        work@rabas.info
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: [Bluez-devel] (no subject)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 19 Dec 2005 13:27:30 +0100

hello

I have a problem getting my a2dp connection onto my headset to work on my linux
machine.
But the sco connection works (I didn't test the mic sofar).

I searched the internet for a hint how to solve this matter, but didn't find
anything.
So I think this is the appropriate spot to post my problem.

  Sorry if I'm wrong.

I'm running Debian Sarge with a newly compiled kernel 2.6.14.3.
I got the whole bluetooth subsystem (except debugging I think) coded into the
kernel,
along with the ALSA system.
Following packages are installed:

bluez-utils    2.15-1.1
alsa-base      1.0.8-7
alsa-utils     1.0.8-4

The bluetooth-alsa version is the 0.4 from the cvs. It compiled without any
error,
along with the kernel snd-bt-sco module.

To test the sco connection I did the following:

-load snd-bt-sco
-pair headset with computer ('hcitool cc <btaddr>' with auth and encrypt enabled
in
 hcid.conf, as I think a2dp requires both)
-'btsco <btaddr>'
-play audio using xmms with appropriate alsa-device

After aborting btsco, but leaving the headset still paired I tryed to play audio
via
the command provided on the official bluetooth-alsa site:

 >debian:/usr/src/btsco-0.4# hcitool con
 >Connections:
 >        < ACL 00:13:1B:00:50:32 handle 46 state 1 lm SLAVE AUTH ENCRYPT
 >debian:/usr/src/btsco-0.4# mpg123 --au - smooth.mp3 | ./a2play
00:13:1B:00:50:32
 >High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
 >Version 0.59r (1999/Jun/15). Written and copyrights by Michael Hipp.
 ...(I Cut out part of the mpg123 output)
 >Playing MPEG stream from smooth.mp3 ...
 >Junk at the beginning 49443303
 >MPEG 1.0 layer III, 192 kbit/s, 44100 Hz joint-stereo
 >out of sync (0x2e)
 >couldn't read header on -

At next I tryed the seccond command provided on the site:

 >debian:/usr/src/btsco-0.4# mpg123 --au - smooth.mp3 | sbc/sbcenc |
./sbc/rcplay 00:13:1B:00:50:32
 >High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
 ...
 >Playing MPEG stream from smooth.mp3 ...
 >Junk at the beginning 49443303
 >MPEG 1.0 layer III, 192 kbit/s, 44100 Hz joint-stereo
 >Can't get channel number: Success

I'm focussing on the "out of sync" error message now.
The usage of a2play tells me that I'm able to define the input file directly.
So I did:

 >mpg123 --au - smooth.mp3 > smooth.au
Now I got the song in sun audio format.

I tried the following next:

 >debian:/usr/src/btsco-0.4# ./a2play 00:13:1B:00:50:32 smooth.au
 >out of sync (0x2e)
 >couldn't read header on smooth.au

Next up was a different audio format, and hey, the errorcode changed:

 >debian:/usr/src/btsco-0.4# ./a2play 00:13:1B:00:50:32 smooth.mp3
 >out of sync (0x49)
 >couldn't read header on smooth.mp3

So there must be something wrong with the audioformat, I guess.
I seriously don't know which one works or should work.

The headset istself is called "Cyber Headphone".
At least it shows up that way when i do 'hcitool scan'
The headset itself works fine with the a2dp connection running winXP and a
Toshiba stack.

Thanks for the help.

Stefan Rabas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
