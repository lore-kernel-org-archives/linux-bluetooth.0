Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40EC42B0.10302@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <40E1E51A.3080106@xmission.com>
In-Reply-To: <40E1E51A.3080106@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Re: Headset with snd-bt-sco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 07 Jul 2004 12:36:32 -0600

Hi

A little more info on the problem... I'm also blogging in the hope it 
will help keep the problem moving along (http://flamebot.com/blog).

Is there any similar effort to do this from inside the bluez project?

I'm using 2.6.3-mh4 and the toshiba internal bluetooth (usb) adapter.

I have been trying unsuccessfully to get the bluetooth headset driver to 
work. I've tried three different headsets so far, the bluetrek 1.0, 
Jabra 200 (upgraded for Handsfree profile), and Ericsson HBH-60. With 
each one, I connect using a command like btsco 00:06:C5:02:C6:24 1 
(except it's channel 2 for the Ericsson). The headset connects and I can 
change the volume and hear the change in the static level but every 
attempt to send or receive audio e.g.

aplay -D plughw:Headset /usr/src/gnomemeeting-1.0.2/sounds/busytone.wav

or even

cat </dev/dsp0 >/dev/dsp1

blocks and eventually times out.

I looked at the kernel debug and what I see when trying to write to the 
device is...

snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 8000 size: 32768 count: 4096
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm

and after after a delay and around the time the failure is reported:

snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL

I would really like to see this work so I'm going to hack at it some 
more... next I'll try turning off preempt in the kernel...

Brad

 > I get the same result when either using the bluetrek 1.0 headset or 
the jabra 200 (upgraded to handsfree profile) headset.
 >
 > Can anyone confirm that snd-bt-sco still works with the hbh-60? The 
previous maintainer is not working on it any more unfortunately...
 >
 > Brad
 >
 > On  0, Lasse Jansen <l.jansen@gm...> wrote:
 >  > Hi all,
 >  > I have some problems with making my BT headset work. Bluetooth 
works, I
 >  > can e.g. exchange files with my T610. For the Headset I downloaded the
 >  > snd-bt-sco driver (http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/),
 >  > kernel-2.6.4 and alsa-1.0.3 as said in the README. Everything went 
fine,
 >  > when I run
 >  > | btsco-0.2/btsco 00:0D:FD:00:7B:CC 1
 >  > I hear a little background noise. When I increase/decrease the 
volume at
 >  > the headset, it will be printed on the screen, so there is a 
connection.
 >  >
 >  > But when I try to play a sound file, nothing happens. E.g.
 >  > | aplay -D plughw:Headset /usr/kde/3.2/share/sounds/KDE_Logout_new.wav
 >  > hangs in a loop. Xmms says "couldn"t open audio".
 >  > I have deactivated the "loopback" option in the mixer settings.
 >  >
 >  > Any ideas?
 >


-- 
Brad


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
