Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Tolf <fredrik@dolda2000.com>
To: Brad Midgley <bmidgley@xmission.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <4233C663.80109@xmission.com>
References: <1110683934.5056.43.camel@pc7.dolda2000.com>
	 <4233C663.80109@xmission.com>
Content-Type: text/plain
Message-Id: <1110762698.5056.73.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [Patch] Some btsco modifications
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
Date: Mon, 14 Mar 2005 02:11:38 +0100

On Sat, 2005-03-12 at 21:49 -0700, Brad Midgley wrote:
> Fredrik,
> 
> These are all great ideas and I am hoping to make good use of what 
> you've done. I'd rather merge it and fix up coding style etc later.
> 
> Are you subscribed to bluez-devel? I'd like to have you join in to 
> discuss the patch.

I am now. ;-)
I didn't think that btsco would be discussed on the bluez-devel list, so
I had no idea where to subscribe. Had I known, I would have posted the
patch there in the first place.

I CCed the list now, and I would attach the patch again for the benefit
to anyone on the list that it may benefit, but I don't want to post a 20
kB message to a ML. Instead, I'm putting it on the web at
<http://www.dolda2000.com/~fredrik/patches/btsco.diff>. I hope that is
satisfactory.

Fredrik Tolf

> Thanks for trying to keep the upstream package relevant :)
> 
> Brad
> 
> Fredrik Tolf wrote:
> > Hi!
> > 
> > I've made some modifications to the btsco project that you're involved
> > in. I'm not sure if you're the one I should send patches to, but then
> > again, the project pages didn't really have much info on where to send
> > patches.
> > 
> > There are a couple of things I've done:
> >  * Instead of (dis)connecting with the headset button, the driver
> > notifies userspace when it is in use, and the userspace program connects
> > accordingly.
> >  * I added a getopt parsing to the userspace program and a "verbose
> > flag" for controlling whether the normal operational messages should be
> > printed.
> >  * Send SIGUSR1 to the userspace program to make the headset ring.
> >  * The userspace program now reads a config file, ~/.btscorc, which
> > contains alternating lines of regexes and shell commands. Everything
> > that the headset sends is matched against these regexes, and if a match
> > if found, the shell command is run (with any back references replaced).
> > This, of course, is primarily intended to "do stuff" with the headset
> > button(s). Send SIGHUP to re-read the config file.
> >  * Start the userspace program with -f to make it daemonize after
> > connecting to the headset.
> >  * I changed the userspace program main loop to only block on polls,
> > rather than sleeping for 1 second all the time. This makes for snappier
> > performance when, for example, a program opens the DSP so that the SCO
> > channel is connected.
> > 
> > I'm also working on a patch for GnomeMeeting to support ringing the
> > headset and getting answered by a headset keypress.
> > 
> > On the bad side, the coding is pretty unelegant in its places, and I've
> > completely violated your coding style. Also, backward compatibility for
> > userspace communication is broken since I had to extend the structure
> > for incorporating usage status. I haven't updated the btsco2 program
> > either.
> > 
> > So, use the patch if you want to, or just steal ideas, or just discard
> > it if you don't like it for any reason. I'll go on using it either
> > way. ;-)
> > 
> > Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
