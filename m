Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4464C195.1020403@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
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
Date: Fri, 12 May 2006 11:10:45 -0600

Frederic

> 	I did not worry about gstreamer as I tried the gstreamer
> alsasink yesterday. This allow you to create a graph with either
> bluetooth output or alsa output without modifying your .asoundrc. Just
> modify the device field. One address only as set in filename.

It will work (probably not much worse than direct alsa). We end up with
a plugin api that is a least-common denominator of the two this way. I'd
rather eliminate the need for the extra layers. (btw, libalsa and
alsasink probably add over a megabyte together in libraries.)

regarding docs... alsalib is poorly documented (that's one of the
problems) but gstreamer does have good plugin docs.

http://gstreamer.freedesktop.org/data/doc/gstreamer/head/pwg/html/index.html

the gstreamer approach allows us to easily snap out the software sbc
codec for a dsp task if you have one available. the decision doesn't
even have to be made until runtime and the other layers like a2dp setup
don't need to be replaced or duplicated.

>> alsa plugins use an api that is too simple for complete 
>> headset support... also there have been complaints about 
>> libalsa not scaling down for embedded systems.
> 
> 	I'm new to alsa and gstreamer and I don't understand you yet.
> Can you point me to document you use? I just saw that volume control
> wasn't available with alsa-plugin if this is what you mean.

the link above goes into gstreamer and there's a good document for app
writers. it is complicated but I think it will serve the purpose well.

we may have to use "soft" volume control by manipulating the stream
before encoding it. there should be a plugin for this. i've tried to use
avrcp to control volume without any luck.

> 	However, I mainly worry about the following points :
> 	* I do not get 2 apps with a2dp output on the same address. As
> devices seems to manage only one socket, the second app will generally
> crash. Could we implement some sort of mixing or application selection
> (the foreground app or the first app started on an address, but with
> proper error handling for the others)?

we either need a sound server or we need a plugin that can use ipc so a
single instance is actually transferring data to the headset. i know
alsa can't do the latter but i'm not sure if gstreamer helps.

> 	* How to select whether the application will output on a2dp or
> speaker? Should this be application related or system related?

system. we need a way to change it while an app is outputing sound.

> 	* What you told me with gxine may vary depending the
> application. I believe one way to handle this is to maintain
> asynchronous connection to target sink. The api would just enqueue the
> audio packets into a common shared queue (per target). The connection
> simply close when there are no more audio packets.

yes. a sound server or mixer plugin via ipc could enforce this behavior.

> 	Did you change something since 0.42?

not yet

brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
