Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jan 2008 06:24:30 +0100 (CET)
From: Leszek Koltunski <leszek@3miasto.net.pl>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080108043952.K43726@3miasto.net.pl>
MIME-Version: 1.0
Subject: [Bluez-users] problems with bluez-utils audio: arecord, mplayer
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


Hello everybody,

recently I installed bluez-utils 3.22 with the thought I'd set up it for 
my Motorola HT820 headset.

I took the sources from Debian testing, applied patch 
'bluez-utils_debian.debdiff' as given in

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=453066

,copied files 'audio.conf' and 'audio.service' to /etc/bluetooth ( as it 
is recommended in the bugreport above ) and compiled everything.

My .asoundrc:

pcm.headset_hw {
    type bluetooth
    device BTADDR
    }

ctl.headset {
    type bluetooth
    device BTADDR
    }

pcm.headset {
    type plug
    slave.pcm "headset_hw"
    }


The result:

- aplay, audacious can send decent-quality sound to my headset with no 
problems
- totem can play a movie and send its sound to the headset with no 
problems
- 'arecord -D headset -f S16_LE foo.wav' FAILS to record anything ( 
produces a 44 byte long 'foo.wav' with just the WAV header , but otherwise 
does not spit out any errors )
- mplayer can play sound alone, but playing sound and video at the same 
time results in a choppy sound. This effect has been described before 
here:

http://sourceforge.net/mailarchive/forum.php?thread_name=9a119b3c0711230758v7fa8a53eub2532227762542bd%40mail.gmail.com&forum_name=bluez-users

I can add one observation: I've seen movies which play good sound 
initially, but at the moment when I resize the video alsa says 'broken 
pipe' and the sound becomes choppy.


**********************************************************************

Questions:

- how can I debug the problem with 'arecord' ?
- why totem can play movies with no problems, but mplayer can not?



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
