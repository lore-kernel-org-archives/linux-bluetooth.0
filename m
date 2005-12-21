Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A9B384.5040202@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>	 <43A78D40.7070209@xmission.com> <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
In-Reply-To: <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 21 Dec 2005 12:56:52 -0700

Nigel

Your headset is misbehaving. We are supposed to be able to discover the
stream endpoint id in the reply to the avdtp_discover request.

You could try adding code to work around this problem and guess at the
seid. The seid seems to always be 1 on my headsets.

Brad

> OK, new cvs version, I get this:
> mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play
> 00:0A:56:00:B5:91 -
> subbands = 8 blocks = 16 bitpool = 32
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
> ...
> MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo
> len=2048
> Header size=28
> Sample Rate:44100
> Channels:2
> Using address: 00:0A:56:00:B5:91
> Found A2DP Sink
> Found A2DP Sink at the destination
> Connected [imtu 672, omtu 672, flush_to 65535]
> Sent the Stream End Point Discovery Command
> couldn't get avdtp_discover (only 2 bytes read)
> 
> On 12/20/05, *Brad Midgley* <bmidgley@xmission.com
> <mailto:bmidgley@xmission.com>> wrote:
> 
>     Nigel
> 
>     > A2DP with the bluetooth-alsa project doesn't work with the Blueant
>     > stereo headphones, and by looking at this page it appears that it
>     might
>     > be because these headphones don't support AVDTP
>     > (http://www.robertwebbe.nl/extendedA2DP.html
>     <http://www.robertwebbe.nl/extendedA2DP.html>) Is this possible?
> 
>     if I remember my alphabet soup correctly, avdtp is a fundamental part of
>     a2dp.
> 
>     > couldn't get avdtp_discover
>     > Sent the Stream End Point Discovery Command
> 
>     i'm not sure why it can't read this information back. perhaps the
>     headset for some reason does not report any supported codecs?
> 
>     i've improved the debug output somewhat. you could try it again.
> 
>     brad
> 
> 
>     -------------------------------------------------------
>     This SF.net email is sponsored by: Splunk Inc. Do you grep through
>     log files
>     for problems?  Stop!  Download the new AJAX search engine that makes
>     searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>     http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>     <http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click>
>     _______________________________________________
>     Bluez-devel mailing list
>     Bluez-devel@lists.sourceforge.net
>     <mailto:Bluez-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
