Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <44053CA9.4020206@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sound skips on i.tech a2dp headset
References: <1141191114.22408.31.camel@localhost.localdomain>
In-Reply-To: <1141191114.22408.31.camel@localhost.localdomain>
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
Date: Tue, 28 Feb 2006 23:18:17 -0700

Scott

ironically, when the encoder was a little slower, i could do no wrong
when streaming to my itech. only after speeding it up did it become
essential to pace things better.

sure, you can try fine-tuning but i believe the real problem will be
solved by completing a plugin. gstreamer looks promising in this
arena... each chunk of data has timing info attached and i assume the
library provides additional help.

i'm hoping gstreamer can help on another timing issue... latency. maybe
by telling the system to build the appropriate delay into the video side
of multimedia. try watching video with a2dp audio and you'll quickly get
annoyed with the delay.

brad

> I've got the i.tech A2DP stereo headset clip-y thing. I've gotten a2play
> working, but the sound skips every several seconds while playing. I
> tried the -p flag, and that helped a whole lot, bringing the
> time-between-skips up to over a minute, but it still happens, and it's
> still annoying.
> 
> Looking at how things work, I get the idea that the sender just blasts
> out data with no way to check on the buffer of the receiver. Could it
> just be that the i.tech headset doesn't handle something right? Or is
> this likely a timing issue on the computer? Should I just start tossing
> in other numbers, like 43995 or 44005? Any other clues?


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
