Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4241FBEE.9060408@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco and Nokia HDW-3 headset not working
References: <1111528750.12076.18.camel@localhost>	 <42409B3B.1080906@xmission.com> <f68b8ee1050323043862bc4c6d@mail.gmail.com> <1111619908.16128.6.camel@localhost>
In-Reply-To: <1111619908.16128.6.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Mar 2005 16:29:50 -0700

James

> Ok, I've just rebuilt using the latest cvs version. I am still having
> the same issue where I can connect to the headset, volume etc works, but
> no sound (eg from XMMS).

You're using the current kernel module too, right?

Try xmms with /dev/dsp1 as well as the alsa plughw:Headset output device.

I think I remember having troubles like this when my alsa configuration 
wasn't quite right, the alsa stuff wasn't run at bootup, or something 
like that. fwiw, my /etc/alsa/modutils/1.0 looks like:

# Example Configuration of ALSA 0.9 for Debian GNU/Linux

alias char-major-116 snd
alias char-major-14 soundcore

options snd major=116 cards_limit=2

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias snd-card-0 snd_intel8x0
alias snd-card-1 snd_bt_sco
#alias snd-card-2 snd-share
#alias snd-card-3 snd-virmidi

alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3

Brad


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
