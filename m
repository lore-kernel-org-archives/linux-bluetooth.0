Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Marty Vona <vona@mit.edu>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <17692.1030.64904.774688@altoids.csail.mit.edu>
References: <17692.1030.64904.774688@altoids.csail.mit.edu>
Date: Fri, 29 Sep 2006 13:50:40 +0200
Message-Id: <1159530640.6131.31.camel@localhost>
Mime-Version: 1.0
Cc: carrick@csail.csail.mit.edu
Subject: Re: [Bluez-devel] possible regression under rf interference
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marsette,

> [while the issue described below does relate to some fedora core versioning, we feel that it is also appropriate to ask for advice here in the bluez community as the core problem, or at least a better understanding of what's going on, is very likely of a technical bluetooth nature]
> 
> [if you prefer to skip the lengthly problem description, you can grep directly for the QUESTIONS section]
> 
> We've got a robot here (*) which runs a bluetooth interface.  The robot has a little bluetooth v2 module on it (a BlueRadios C40).  It communicates with a PC running Linux and a bluetooth USB dongle (**).  We use a basic "rfcomm connect" to setup a /dev/rfcommX port, and talk to the robot serially over that.  Nice.  Well, it was nice.
> 
> Up until around early July of this year, everything was working well.  The PC had fedora core 4.  Then we upgraded the pc to FC5 and we started to get a very challenging problem.  It goes like this:
> 
> 1) we power up the robot and do the "rfcomm connect" as usual.  Everything is happy, the robot is communicating
> 
> 2) we can talk to the robot over the bluetooth link apparrently normally, until
> 
> 3) we tell the robot to turn on one of its motors.  Based on some oscilloscope measurements, we have strong evidence that this can cause some amount of RF noise reaching up into the GHz range.  Note carefully: before fc5, and even now when we substitue an RS232 bluetooth interface for the usb dongle (see below), the bluetooth protocoll error correction is apparrently sufficient to tolerate this noise without significant delays.
> 
> 4) the motor goes on and the robot continues to communicate, usually, for about 1 to 10 seconds more.  It then "hiccups", i.e., there is a delay in communication for greater than 1.0 second.
> 
> 5) for safety, we really can't tolerate comm delays that long, so the robot's on-board software shuts the motor down
> 
> 6) it appears that the bluetooth link does not actually die, as we can always continue communicating with the robot (i.e. using the same previous rfcomm connection) after the motor stops
> 
> Obviously, we are trying to isolate the particular versions of things in which the above fault occurs and those in which it doesnt.  This is proving more difficult than expected (we unfortunately do not have a simple version snapshot of the setup which was working pre-fc5, doh).  We tried reverting to the kernel which we believe was in effect at the time everything was working (2.6.16-1.2069_FC4-i686), and to the most recent FC4 bluetooth rpms (which *should* have been in effect on our machine at that time...):
> 
> bluez-pin-0.24-2.i386.rpm
> bluez-libs-2.15-1.i386.rpm
> bluez-utils-2.15-7.i386.rpm
> bluez-hcidump-1.18-1.i386.rpm
> 
> Frustratingly, the problem seemed to persist.  Perhaps our original (working) fc4 setup was not fully up-to-date, and so was using even older bluez rpms.  Most likely the kernel version was as above though.  Or perhaps reverting the RPMS did not actually revert some /etc/ config files which had been updated by the FC5 rpms.  Or maybe we made a mistake in attemping the reversion (which took the better part of a day for reasons we're sure you don't want to even hear about).
> 
> For completeness, here are the versions of things under FC5 where the timeouts definitely do occur:
> 
> kernel 2.6.17-1.2187_FC5-i686
> 
> bluez-pin-0.30-2.i386.rpm
> bluez-libs-2.25-1.i386.rpm     
> bluez-utils-2.25-4.i386.rpm
> bluez-hcidump-1.30-1.i386.rpm  
> gnome-bluetooth-0.7.0-2.i386.rpm
> gnome-bluetooth-libs-0.7.0-2.i386.rpm
> libbtctl-0.6.0-5.i386.rpm
> 
> We have entertained the possibility that the issue is being caused by some other lossage which just happened to coincide with the fc5 update.  However, that does not seem to be the case:
> 
> a) if, instead of the USB dongle, we use an RS232 bluetooth interface on the pc (also based on the BlueRadios C40), everything works fine, even now
> 
> b) we have tried different USB dongles from different manufacturers with the same effects
> 
> c) we have even tried different linux workstations entirely, and still gotten the comm timeout when using a bluetooth USB dongle and bluez 
> 
> Finally, we realize that delays over 1.0s may actually be within-spec for bluetooth comms (we have not read the specs).  However note that the delays were never observed before the fc5 update, and also note that they are not observed even now if we avoid using the bluez software stack and instead use an RS232 bluetooth module.
> 
> QUESTIONS
> 
> 1) are long timeouts under RF interference possibly a known current regression?  does anyone regularly test bluez under significant RF inferference?

we don't have to. The dongles are tested and BlueZ only access them over
HCI. There is no way to interfere with the RF in a wrong way without
using nasty vendor specific tricks (which we don't).

> 2) does bluez (and if so, in what codepath) even deal with things like error detection and correction, packet retransmission, tx power management, rf interference, link quality monitoring, etc?  Or are things like that handled by firmware in the usb dongle?

This is all handled in the firmware of the chip. BlueZ doesn't have to
worry about it.

> 3) are we possibly barking up the wrong tree?  Can anyone think of any other possible cause which fits the above symptoms?

The USB bus can be different. They USB subsystem changes a lot from
kernel version to kernel version.

> 4) is the issue likely in the bluez kernel code, the bluez user space code, or something else entirely?

I don't expect this to be BlueZ's fault at all.

> 5) what else could we do to try to debug this?  we did an hcidump of a "bad" session, but our untrained eye didn't see anything suspicious in it.  Can we somehow tell the bluez {kernel,userspace} code to be more verbose about what's going on?

You can tell the kernel code to *_DEBUG and then recompile, but you
won't see anything different than you see with hcidump. The kernel is
not doing any magic behind your back.

> 6) what should we read to educate ourselves about what is going on here so we can better diagnose an issue like this?

Try checking your USB hardware and the kernel support for USB. If you
don't use SCO channels you can load the hci_usb with isoc=0 parameter to
avoid isoc transfers on the USB bus.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
