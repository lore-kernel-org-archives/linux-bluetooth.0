Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Feb 2008 00:02:31 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802090347.m193lOJq023253@alumnus.caltech.edu>
Message-ID: <alpine.LNX.1.00.0802082340390.12621@nge2.ngu.pk>
References: <200802090347.m193lOJq023253@alumnus.caltech.edu>
MIME-Version: 1.0
Subject: Re: [Bluez-users] failed PIN Code Request
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


On Fri, 8 Feb 2008, Russell A. Bell wrote:

-> 	M. Holtmann:
-> 	'this is from an odd Debian installation.'
-> 	What is?  I use Slackware 12 and bluez 3.25.

You didn't quote the output he was likely refering to:

>>       20945 tty6     S      0:00 /usr/local/lib/bluetooth/add-passkey 00:13:17:DD:D0:86
>>
>> is in the process list.  Does this mean that add-passkey isn't
>> working?

> this is from an odd Debian installation.


"add-passkey" isn't a tool in bluez-utils 3.25. Where ever it came from, I 
think he meant not to use it. Years ago I used Slackware, and it never 
installed stuff in /usr/local. Unless it underwent a fundimental change (and 
that's hard to image if you know how Patrick is) that looks like a 3rd-party 
or user add-on.


> Using that is a bad thing. Kill all these processes and simply log into the 
> GNOME or KDE desktop and use their Bluetooth applet.


-> 	'Kill all these processes and simply log into the GNOME or KDE
-> desktop and use their Bluetooth applet.'
-> 	These require X, which I don't use except under duress.  I
-> just want to listen to files on my wireless headset.

Same here, X isn't mandatory, only if you use a graphical bluetooth tool in 
GNOME or KDE, which I don't. The bluez-utils command line tools work fine for 
me. There's two which I use for my headset. I posted a full description of it 
a few issues back, but the pass/PIN part consists of starting

passkey-agent --default <PIN> <bt address of remote device> &
auth-agent &

after sdpd & hcid are up, but before you try and use the headset. After that, 
turn on the headset. Many look for a audio service to pair with. Mine does. On 
the Jabra I use, there is a button on the side. Pressing it causes it to try 
to pair with the computer. At that time, passkey-agent and auth-agent answer, 
and output to the console that they did get a request. After a few seconds, 
you should see the headset with 'hcitool con '. If you don't send sound, it 
may disconnect after some time. If it does, pressing again re-starts the 
process. If yours doesn't have such a button/setup, you could try to pair from 
the other side, computer to device. I believe that's 'hcitool cc <address>' 
then 'hcitool auth <address>' but my headset doesn't seem to like to operate 
this way and wants to disconnect quickly due to not being used for sound.





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
