Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sound skips on i.tech a2dp headset
From: Scott Gilliland <Scott.Gilliland@gatech.edu>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44053CA9.4020206@xmission.com>
References: <1141191114.22408.31.camel@localhost.localdomain>
	 <44053CA9.4020206@xmission.com>
Content-Type: text/plain
Message-Id: <1141198221.22408.37.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 01 Mar 2006 02:30:21 -0500

Brad,

Thanks the the info. Just a question or two... Are you saying that
timing information actually makes it all the way out to the headset? I
assumed it was just raw data, and the headset just tried to play it at
the appropriate speed. (the headset could then vary a bit depending on
how full the buffer was) 

Also, yes, the idea of having the latency info fed back to the source
had occurred to me as well. Is there any way at all to estimate the
delay from the headset tho? or would it just have to be a value you tune
manually? Also, do you know if gstreamer is able to do this kind of
thing now?

Thanks again,
Scott

On Tue, 2006-02-28 at 23:18 -0700, Brad Midgley wrote:
> Scott
> 
> ironically, when the encoder was a little slower, i could do no wrong
> when streaming to my itech. only after speeding it up did it become
> essential to pace things better.
> 
> sure, you can try fine-tuning but i believe the real problem will be
> solved by completing a plugin. gstreamer looks promising in this
> arena... each chunk of data has timing info attached and i assume the
> library provides additional help.
> 
> i'm hoping gstreamer can help on another timing issue... latency. maybe
> by telling the system to build the appropriate delay into the video side
> of multimedia. try watching video with a2dp audio and you'll quickly get
> annoyed with the delay.
> 
> brad




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
