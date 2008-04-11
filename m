Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Apr 2008 09:32:54 +0200
From: martin f krafft <madduck@madduck.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080411073254.GB23249@lapse.madduck.net>
MIME-Version: 1.0
Subject: [Bluez-devel] SCO patch works on (Debian) 2.6.24 (was: Updated SCO
	flow control	patch: 2.6.23)
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fabien Chevalier <fabchevalier <at> free.fr> writes:
> As for sco-flowcontrol-v4.4.diff, which is against 2.6.22-mh3, i didn't 
> manage to test it due to broken sco behaviour. 

Hi,

I have just compiled a Debian 2.6.24 with the v4.4 patch: it applied
and compiled cleanly.

And it works most of the time with my BT500v headset (sco)! Thank
you for that.

Is there any ETA on when this patch will make it into the kernel
mainline?

Unfortunately, sometimes I see the

  Critical: Opening ALSA driver failed:
  snd_pcm_hw_params_set_rate(8287) failed: Invalid argument

log output from twinkle and then I can't hear anything from the
other side and I am not sure they can hear me.

At other times, the headset just disconnects before my softphone
even tries to set up the call with:

  headsetd[25077]: Changing state: Zombie-->Streaming
  headsetd[25077]: Appli closed socket
  headsetd[25077]: Changing state: Streaming-->Zombie
  headsetd[25077]: Nobody uses SCO channel anymore, closing it.
  headsetd[25077]: Changing state: Zombie-->Connected

and then the application will sit forever saying it's "Trying".

If you have any suggestions, I'd love to hear them.
I will write back if I find out more...

-- 
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
 
"by accepting this brick through your window, you accept it as is
 and agree to my disclaimer of all warranties, express or implied,
 as well as disclaimers of all liability, direct, indirect,
 consequential or incidental, that may arise from the installation
 of this brick into your building."                 -- seen on irc
 
spamtraps: madduck.bogus@madduck.net

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
