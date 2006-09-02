Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F94742.5010805@strudel-hound.com>
Date: Sat, 02 Sep 2006 18:56:34 +1000
From: William Pettersson <enigma@strudel-hound.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] BTSCO - Alsa sound controls - Mute?
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

TLDR Summary:  BTSCO works fine, but I only have AGC (Automatic Gain 
Control) and Loopback options in alsamixer.  There's no way I can mute 
the microphone, which I want to do when I press the headset button.  Is 
this because my headset doesn't support muting, or are these extra 
features all software based?

Long story version.
So, I've gotten a bluetooth headset, it works fine.  I can talk and hear 
people fine over Skype.  What I want to do, however, is use it for 
things like Ventrilo and Teamspeak.  These programs are different in 
that you don't want everything you say to go through the mic.  People 
generally use a key to switch voice-transmit on and off.  What I wanted 
to was use the button on the headset to do this.  I can set the program 
to continuously transmit, and then just mute/unmute the microphone via 
alsa.  This works on regular headsets connected to my soundcard.  But 
alsamixer doesn't let me mute the microphone (and changing volume 
settings does nothing).  Is this because my headset doesn't support 
these features, or is all of this done in software.

BTSCO v0.42, using a Nextlink AX2 (review @ 
http://www.engadget.com/2005/11/07/nextlink-bluespoon-ax2-reviewed-4-5-stars/ 
and a google search lists many more reviews).

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
