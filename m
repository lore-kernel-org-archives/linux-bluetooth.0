Return-Path: <cyrus@holtmann.org>
From: Jens-Erik Hansen <Jens-E.Hansen@gis.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Thu, 28 Feb 2008 17:29:42 +0100
References: <200802252010.34296.Jens-E.Hansen@gis.de>
	<20080226080414.U82399@3miasto.net.pl>
In-Reply-To: <20080226080414.U82399@3miasto.net.pl>
MIME-Version: 1.0
Message-Id: <200802281729.42989.Jens-E.Hansen@gis.de>
Subject: Re: [Bluez-users] rattling noise with bluefritz 2.0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

Am Dienstag 26 Februar 2008 schrieb Leszek Koltunski:
> Eh? You using a bluetooth headset and bluez-audio to make calls with
> Twinkle/Ekiga/Skype? Please post a guide how did you do this !


sorry for the long delay, I was a bit busy the last few days.
Apparently I'm not a bluez/alsa specialist, anyway here is what I have done:

To get a bluetooth headset work with Twinkle/Ekiga/Skype I enhanced
my .asoundrc at first.
In several documents I read that you can use a pcm of type bluetooth but that
never worked for me so I have to use type sco (see pcm.headset).
I had to reduce the volume of the headset mic to eliminate echo problems. Because
I found no working solution to control the mic volume with alsamixer, even softvol
doesn't help, I had to do it with a pcm of type plug (see pcm.headset-route-in).
To finetune the headset speaker volume I inserted the pcm-headset-route-out section
in my .asoundrc. 

I wasn't able to find a solution for dmixing/dsnooping the headset, is it possible?

After pairing the headset with the bt dongle I used the alsa device headset-route-out
for speaker and the device headset-route-in for microphone in twinkle and skype.

To get ekiga working with this alsa devices please follow
http://forums.droplinegnome.org/viewtopic.php?t=5538&sid=ca7c1f8a8b259c2bf3a9fc6a42ba573c
If you use a debian sid distribution you can find the needed patches in
/usr/share/doc/bluetooth-alsa/patches too.

Hope this helps.
Greeting
Jens



my .asoundrc
------------

pcm.headset-route-in {
        type plug
        slave {
                pcm "headset"
                format S16_LE
        }
        ttable {
                0 {0 0.4}
                1 {0 0.4}
        }
}

pcm.headset-route-out{
        type plug
        slave {
                pcm "headset"
                format S16_LE
        }
        ttable {
                0 {0 0.7}
                1 {0 0.7}
        }
}

pcm.headset {
        @args [BDADDR TIMEOUT]
        @args.BDADDR {
                type string
                # Enter address of your headset here
                default "xx:xx:xx:xx:xx:xx"
        }
        @args.TIMEOUT {
                type integer
                default 6000
        }

        type        sco
        bdaddr      $BDADDR
        timeout     $TIMEOUT
}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
