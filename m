Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 21 Mar 2007 20:18:35 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070322031835.GJ7472@alcor.net>
References: <20070311203223.GP8187@alcor.net>
	<20070311205548.GQ8187@alcor.net> <45F58229.50403@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45F58229.50403@redhat.com>
Subject: Re: [Bluez-users] Plantronics 510 headset: playback partially works,
	but not recording
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Mon, Mar 12, 2007 at 12:39:05PM -0400, Alan Conway wrote:
> Matt Zimmerman wrote:
> > I found an example which used aplay -B 1000000, and that fixes the
> > stuttering.  Still no luck yet on recording.
> I'm trying to get a similar setup to work, here's my previos post with 
> my status so far, would love to hear of any breakthroughs you make:

Thanks for sharing your experience.

> Trying to use a plantronics 510s with skype.
> 
> Update on my attempts, I've established the setup that almost works. By 
> almost works I mean:
> - aplay, arecord -D headset work, quality is fine for telephone use.

Interesting, so recording works for you?  I wonder what's different about
your setup.

> - aoss skype almost works: I can hear the test call clearly, I can 
> record a message but when it is played back my voice is garbled beyond 
> recognition.

I've no idea about this; I'm wanting to use Ekiga which has native ALSA
support.

> == NOTES
> 
> The instructions at http://bluetooth-alsa.sourceforge.net/build.html did 
> *not* work for me. The plugz version of the plugin requires a different 
> .asoundrc (based on plugz/asound.conf) but aplay -D headset gave me:
> 
> [aconway@scooter plugz]$ aplay -D headset /usr/share/sounds/startup3.wav
> Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little 
> Endian, Rate 44100 Hz, Stereo
> aplay: set_params:909: Channels count non available

I believe I got the same when I tried to play a stereo stream for a test.
Since then, I've just been using mono files for testing, which works fine.

> 	# This is the size of the buffer used to queue Voice packets. Value must be between 
> 	# 2 and 334 (~ 1 second). Default value is 2 buffers, which works well most of the
>         # time, and has the advantage of giving us an ultra low delay
> 	@args.MAX_PERIODS {		
> 		type integer
> 		default 334
> 	}

Haven't experimented with this; will see if it makes a difference.

-- 
 - mdz

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
