Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A78D40.7070209@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
In-Reply-To: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
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
Date: Mon, 19 Dec 2005 21:49:04 -0700

Nigel

> A2DP with the bluetooth-alsa project doesn't work with the Blueant
> stereo headphones, and by looking at this page it appears that it might
> be because these headphones don't support AVDTP
> (http://www.robertwebbe.nl/extendedA2DP.html) Is this possible?

if I remember my alphabet soup correctly, avdtp is a fundamental part of
a2dp.

> couldn't get avdtp_discover
> Sent the Stream End Point Discovery Command

i'm not sure why it can't read this information back. perhaps the
headset for some reason does not report any supported codecs?

i've improved the debug output somewhat. you could try it again.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
