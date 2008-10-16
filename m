Return-Path: <cyrus@holtmann.org>
Message-ID: <48F79CEC.2020803@slackdot.org>
Date: Thu, 16 Oct 2008 15:58:36 -0400
From: deker <deker@slackdot.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] bluez audio questions
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net


So, per Brad's advice I've been following the audio HOWTO at 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

I seem to either not be getting something, or bluez has changed it's 
dbus interface for audio dramatically. Looking at the HOWTO, it would 
appear that I have to active the audio service before I can send audio 
to a device. Great, no problem. Ok, one 
problem...org.bluez.Manager.ActivateService doesn't seem to exist. 
Looking at the dbus API spec in the 4.13 source tarball doesn't list it, 
and looking at dbus with D-Feet I see what matches the API listed in the 
docs. Is there some new method for service activation I'm missing?

Any help is appreciated. I really don't feel like this should be rocket 
surgery, I guess I just haven't found the bluez-audio Rosetta Stone yet...

Thanks again,

-d

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
