Return-Path: <cyrus@holtmann.org>
Message-Id: <9038C689-4CCE-403B-8F7A-F3C3C98C877A@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48F79CEC.2020803@slackdot.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Fri, 17 Oct 2008 00:54:40 +0300
References: <48F79CEC.2020803@slackdot.org>
Subject: Re: [Bluez-devel] bluez audio questions
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

Hi,

On Oct 16, 2008, at 22:58, deker wrote:
> So, per Brad's advice I've been following the audio HOWTO at
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices

Unfortunately the wiki hasn't been updated for 4.x. The instructions  
there only apply for 3.x. Any help updating it for 4.x is appreciated  
(the only reason that hasn't happened is lack of time).

> I seem to either not be getting something, or bluez has changed it's
> dbus interface for audio dramatically. Looking at the HOWTO, it would
> appear that I have to active the audio service before I can send audio
> to a device. Great, no problem. Ok, one
> problem...org.bluez.Manager.ActivateService doesn't seem to exist.
> Looking at the dbus API spec in the 4.13 source tarball doesn't list  
> it,
> and looking at dbus with D-Feet I see what matches the API listed in  
> the
> docs. Is there some new method for service activation I'm missing?

If you're interested about the differences between 3.x and 4.x I'm  
sure you'll find discussion about it in the mailing list archives  
(probably linux-bluetooth though since that's the official one these  
days) and iirc Marcel even wrote an article about it in the bluez blog  
(www.bluez.org).
The API reference documentation itself is available in the doc  
subdirectory of bluez.

> Any help is appreciated. I really don't feel like this should be  
> rocket
> surgery, I guess I just haven't found the bluez-audio Rosetta Stone  
> yet...

Setting up a headset with 4.x should in theory be much simpler than  
with 3.x. First you need to pair the headset, discover its services  
and create a D-Bus object for it. This is all done with just one  
operation in 4.x, which is by calling the CreatePairedDevice method.  
You can either use some GUI like bluetooth-wizard from bluez-gnome to  
do this or if you're just using the command line you could use the  
simple-agent python script from the test subdirectory:
./simple-agent hci0 <headset address>
It'll ask you for the pin on stdin.

After this first step you should be able to use your headset the same  
way as you did with 3.x. E.g. with alsa have your .asoundrc set up and  
configure your favorite alsa application to the entry in it.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
