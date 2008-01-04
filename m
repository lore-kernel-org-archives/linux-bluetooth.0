Return-Path: <cyrus@holtmann.org>
From: Colin Murphy <lists@spudulike.me.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Fri, 4 Jan 2008 06:09:05 +0000
References: <200801012109.19744.lists@spudulike.me.uk>
	<loom.20080103T040638-726@post.gmane.org>
	<d89ddf300801022052i2fb09d53m203f5946455d406a@mail.gmail.com>
In-Reply-To: <d89ddf300801022052i2fb09d53m203f5946455d406a@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200801040609.05681.lists@spudulike.me.uk>
Subject: Re: [Bluez-users] Stereo audio headset - half a second of audio,
	8 seconds of silence, then disconnection.
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

On Wednesday 02 January 2008 05:03:16 Brad Midgley wrote:

> this could be the scatternet problem we've been working over.
>
> what does  hcitool con show during the audio playing?
>
In the 2 second gap before I get any sound after hitting the play button I 
get:-
colin@colin-desktop:~$ hcitool con
Connections:
        < ACL 00:0A:94:A0:35:A5 handle 0 state 5 lm MASTER

About half a second before I get my brief half second audio burst this changes 
to:-
colin@colin-desktop:~$ hcitool con
Connections:
        < ACL 00:0A:94:A0:35:A5 handle 12 state 1 lm MASTER

and continues with the same response, even though the audio has now died, for 
another 8 seconds, after which is goes back to:-
colin@colin-desktop:~$ hcitool con
Connections:
colin@colin-desktop:~$ 
    

> What other bluetooth devices are you using?

There are Bluetooth empowered phones near by, but their bluetooth activity is 
turned off, mainly to save the phones battery power.

> is the headset trying to connect to a phone at the same time?

The headsets, I have two different types, both stereo headphones, have all 
been paired with the phones, and proved to be working with them, but they 
have not been connected to the phones during these tests.

> do you know which bluetooth adapter your pc uses?

I can only tell you it is manufactured by Broadcom and is a Bluetooth 2.0 + 
EDR, according to the "My Devices > Information" panel in the Blueman gui 
utility.  How do I get better information?

Removing 'rswitch' from hcid.conf made no difference, even after 
an '/etc/init.rc/bluetooth restart'.

On Thursday 03 January 2008 04:52:07 Brad Midgley wrote in reply to Paul 
Rushworth's message :

>  Does the gstreamer plugin route do the same thing? iirc:
>
> gst-launch filesrc location=song.mp3 ! mad ! audioconvert ! sbcenc !
> a2dpsink device=00:12:0E:09:CF:9E
>

For me, I've had success with this :-

colin@colin-desktop:~$ gst-launch filesrc location=Gently6.mp3 ! mad ! 
audioconvert ! sbcenc ! a2dpsink device=00:0A:94:A0:35:A5
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock

And continued playing audio to me until I got bored, after about 10 minutes 
later, and I hit '<CTRL> - C':-

Caught interrupt -- handling interrupt.
Interrupt: Setting pipeline to PAUSED ...
Execution ended after 624620447000 ns.
Setting pipeline to PAUSED ...
Setting pipeline to READY ...
Setting pipeline to NULL ...
FREEING pipeline ...
colin@colin-desktop:~$

It might be interesting to note that during this playback I was able to get:-

colin@colin-desktop:~$ hcitool con
Connections:
        < ACL 00:0A:94:A0:35:A5 handle 12 state 1 lm MASTER AUTH ENCRYPT 
SECURE 
colin@colin-desktop:~$ 

I'll throw in another piece of the puzzle to.  Just before I started replying 
to your email I noticed that there was a Ubuntu update to be done for the 
Bluez stuff, which I took advantage of.  Once installed, I started up XMMS, 
re-configured it to use the bluetooth device and hit the play button, and had 
it playing for 6 minutes, all the way to the end of the track. Unfortunately, 
when I tried to select a second track I found myself back with the old 
problem, half a second of sound output and 8 seconds, to the second, of 
silence, before XMMS resets the track.


-- 
Colin@spudulike.me.uk
Gotta' go, things to be, people to do, stuff to, err, stuff.




-- 
Colin@spudulike.me.uk
Gotta' go, things to be, people to do, stuff to, err, stuff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
