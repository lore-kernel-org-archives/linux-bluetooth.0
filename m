Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4402B5A3.9000509@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] headset playback problem suse 10.0
References: <200602262022.41205.edgar.neukirchner@chello.at>
In-Reply-To: <200602262022.41205.edgar.neukirchner@chello.at>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Feb 2006 01:17:39 -0700

Edgar

Are you trying it with the experimental kernel patch on
http://bluetooth-alsa.sf.net for broadcom adapters?

Brad

> I have installed and configured bluetooth-alsa without getting any errors. But 
> when trying to play a test.wav file with aplay, there was no sound at all - 
> only a slight increase of the noise floor in the headset (Jabra BT330). 
> Obviously there was some communication going between bluetooth dongle and 
> headset, as the blinking frequency of the LED on the headset changed.
> 
> When I issued the command cat test.wav > /dev/dsp1 as root there was an output 
> error message in the terminal and in the logfile the following:
> 
>  kernel: ALSA sound/core/pcm_lib.c:2126: playback write error (DMA or IRQ 
> trouble?)
> kernel: ALSA sound/core/pcm_native.c:1451: playback drain error (DMA or IRQ 
> trouble?)
> 
> I use the latest snd_bt_sco module from cvs with suse 10.0 and kernel 
> 2.6.13-15.8-default. Headset is Jabra BT330, bluetooth usb dongle is 
> CCBT2035BDGP23-2 from Broadcom
> 
> Who can help?
> 
> Thanks,
> Edgar
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
