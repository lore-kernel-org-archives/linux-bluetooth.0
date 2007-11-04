Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <472DFD88.6060108@pagema.net>
Date: Sun, 04 Nov 2007 18:12:40 +0100
From: maho+bluez <maho+bluez@pagema.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1194192865.2823.20.camel@aero64.datenschrott.de>
In-Reply-To: <1194192865.2823.20.camel@aero64.datenschrott.de>
Subject: Re: [Bluez-users] headset via bluetooth-headset not fully working
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

David Elze wrote:
> Hey, 
>
> I'm running Debian unstable and want to do some VoIP stuff with my
> HBH-PV700 (Sony Ericsson) headset over a standard bluetooth dongle
> (usb).
>
> Pretty everything works as it should: 
> 1. I can pair the headset correctly (hcitool, gnome bluetooth 
>    manager and friends) [1]
> 2. I can start the headsetd via 'headsetd -n' to get its output
> 3. When I run 
>    'aplay -Dplug:headset /usr/share/sounds/alsa/Front_Center.wav'
>    the headsets does a beep, I can hear some silent noise (nothing
>    like the expected sound, only background noise that is slightly
>    louder than the headset normally is if there is no aplay involved)
>    but not the expected sound and headsetd says [2] whereas my 
>    .asoundrc looks like [3]
>   
[...]
What aplay -v -Dplug:headset /usr/share/sounds/alsa/Front_Center.wav says?

Doesn't it say that "Prorotocol not available (92)" ?

I have very similar problems (see
http://article.gmane.org/gmane.linux.bluez.user/12981), but no solution
yet, but my aplay gives that error #92.

I suspect that it's hardware issue, but I don't know if it's my headset
(moto h500), usb dongle (some broadcom), or something else?

regards

maHo



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
