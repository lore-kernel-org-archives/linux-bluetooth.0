Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AE6C85.90803@free.fr>
Date: Wed, 17 Jan 2007 19:35:49 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] RE : a2dpd and mplayer - any chance to get it
	working?
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

Hi Frederic, i think can help you for the second part:

>  I was wondering about alsa plugins :
> xmms relies on alsa timing to play, so in the plugin, there is a sleep() call, this will wait a little bit until it is time to retievre new data.
> But it seems some players (like mplayer) wants to do their own timing or at least don't want to sleep. They need to use that time to do some decoding instead. If you sleep too long, the decoding will be defered and the sound or movie will be broken.
> 
> Is there a rule to distinguish? Or some magic value to sleep?

The key idea is that ALSA applications expect ALSA to run on a hardware 
device that implements a ring buffer as a mean of transferring data from 
  ALSA to the device.
This ring buffer is divided into small chunks, called 'periods'.
ALSA API is expected to block the caller when the ring buffer is full, 
and unblock it when some room is freed. The size of the buffer, as well 
as the period size is up to the application to select so that it best 
fits its needs.

What you've done in the a2dp pcm plugin(if i understood well) is to 
throttle the application using sleep. But that does not emulate the ring 
buffer behaviour well enough, so it breaks MPlayer. :-(

Some more details can be found here : 
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Cheers,

Fabien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
