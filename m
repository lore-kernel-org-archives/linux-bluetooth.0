Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40E1E51A.3080106@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
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
Date: Tue, 29 Jun 2004 15:54:34 -0600

Hi

I get the same result when either using the bluetrek 1.0 headset or the 
jabra 200 (upgraded to handsfree profile) headset.

Can anyone confirm that snd-bt-sco still works with the hbh-60? The 
previous maintainer is not working on it any more unfortunately...

Brad

On  0, Lasse Jansen <l.jansen@gm...> wrote:
  > Hi all,
  > I have some problems with making my BT headset work. Bluetooth works, I
  > can e.g. exchange files with my T610. For the Headset I downloaded the
  > snd-bt-sco driver (http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/),
  > kernel-2.6.4 and alsa-1.0.3 as said in the README. Everything went fine,
  > when I run
  > | btsco-0.2/btsco 00:0D:FD:00:7B:CC 1
  > I hear a little background noise. When I increase/decrease the volume at
  > the headset, it will be printed on the screen, so there is a connection.
  >
  > But when I try to play a sound file, nothing happens. E.g.
  > | aplay -D plughw:Headset /usr/kde/3.2/share/sounds/KDE_Logout_new.wav
  > hangs in a loop. Xmms says "couldn"t open audio".
  > I have deactivated the "loopback" option in the mixer settings.
  >
  > Any ideas?

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
