Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42409B3B.1080906@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco and Nokia HDW-3 headset not working
References: <1111528750.12076.18.camel@localhost>
In-Reply-To: <1111528750.12076.18.camel@localhost>
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
Date: Tue, 22 Mar 2005 15:24:59 -0700

James

> athos root # sdptool search --bdaddr 00:03:89:67:8F:F7 0x1108

Do our docs still recommend this? The channel has been autodetected for 
some time.

> athos root # btsco 00:03:89:67:8F:F7 1
> Device is 2:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected

This is not the latest cvs version. It's silent unless you specify "-v" 
flag. Where did you get the kernel module and btsco daemon you are trying?

> I am running gentoo linux with the following kernel:
> athos root # uname -a
> Linux athos.porthosnet.com 2.6.9-gentoo-r14 #11 Fri Mar 4 18:30:23 Local
> time zone must be set--see zic manu x86_64 AMD Athlon(tm) 64 Processor
> 3400+ AuthenticAMD GNU/Linux

It would really be a lot easier to debug if you were using the most 
recent kernel release (we don't have enough resources to maintiain 
several versions for what is supposed to be a stable kernel series)

Make sure you are using the integrated alsa, not the standalone that is 
distributed separately. IIRC, this came up because gentoo uses the 
standalone alsa.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
