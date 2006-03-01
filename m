Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4405CCC7.4060407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sound skips on i.tech a2dp headset
References: <1141191114.22408.31.camel@localhost.localdomain>	 <44053CA9.4020206@xmission.com> <1141198221.22408.37.camel@localhost.localdomain>
In-Reply-To: <1141198221.22408.37.camel@localhost.localdomain>
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
Date: Wed, 01 Mar 2006 09:33:11 -0700

Scott

> Thanks the the info. Just a question or two... Are you saying that
> timing information actually makes it all the way out to the headset? I
> assumed it was just raw data, and the headset just tried to play it at
> the appropriate speed. (the headset could then vary a bit depending on
> how full the buffer was) 

In order to keep latency down, the headset should not be buffering much;
it just plays stuff when it arrives. Unfortunately, in the current
headsets, we get the effects of no buffer *and* significant latency. :(

> Also, yes, the idea of having the latency info fed back to the source
> had occurred to me as well. Is there any way at all to estimate the
> delay from the headset tho? or would it just have to be a value you tune
> manually? Also, do you know if gstreamer is able to do this kind of
> thing now?

I don't know if gstreamer will do this.

I think we'd have to keep a table of typical latencies based on the
identity of the set. Bluecore03-mm probably has the same latency across
every set that uses it for example.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
