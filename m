Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445A116C.2060507@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C075@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C075@eumonex01.palmsource.com>
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
Date: Thu, 04 May 2006 08:36:28 -0600

Frederic

> I recently started to work with bluetooth-alsa (0.41) and a bluetake
> iPhono BT420 headset. I made it work using a2play, but not using
> alsa-plugins. I also tried the latest cvs without success.

stick with cvs for this stuff. the 0.41 release will not work (esp plugin).

> Has anyone made the plugin work? Also, as I will have time to work
> with bt-alsa, I would be pleased to help. What must/can be done? What
> area can I investigate in order to have a2dp working with alsa?

Sergey did help us get it working. I've got a csr adapter on my computer
and I'm testing with an iphono mini set. It's possible he and I are
using different versions of a2dp_transfer (a2dp_transfer2 works better
for me and that's the one cvs-head uses)

I had to put in a bunch of i/o retries that Sergey didn't so the
behavior can differ a lot from setup to setup. Alsa interrupts our
system calls so we have to be careful about calls that take time like
initially connecting to the set.

There is plenty to be done... you need to get it working first :)

seriously, alsa plugin needs bulletproofing (eg we need to watch error
messages from write() and think about how to handle them gracefully). I
also noticed that after choosing pcm.headset, gxine wouldn't even launch
when my headset was off.

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
