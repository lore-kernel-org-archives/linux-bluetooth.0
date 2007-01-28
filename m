Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 28 Jan 2007 20:30:13 +0100
References: <200701150326.46855.bluez-devel@huitl.de>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
MIME-Version: 1.0
Message-Id: <200701282030.14289.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
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

Hi again,

On Wednesday 17 January 2007 08:03, Frederic Dalleau wrote:
>  I was wondering about alsa plugins :
> xmms relies on alsa timing to play, so in the plugin, there is a sleep()
> call, this will wait a little bit until it is time to retievre new data.
> But it seems some players (like mplayer) wants to do their own timing or at
> least don't want to sleep. They need to use that time to do some decoding
> instead. If you sleep too long, the decoding will be defered and the sound
> or movie will be broken.
>
> Is there a rule to distinguish? Or some magic value to sleep?

I had a look at MPlayer to see what it's doing. It sleeps whenever needed, and 
it finds out how long to sleep by looking at the PCM status. I posted the 
following message to alsa-devel, but unfortunately so far nobody answered. 
Maybe someone on this list knows an answer.

Robert

----------  Forwarded Message  ----------

Subject: snd_pcm_status_get_avail() and external I/O plugins
Date: Thursday 18 January 2007 14:51
From: Robert Huitl <alsa-devel@huitl.de>
To: alsa-devel@lists.sourceforge.net

Hello,

I have some trouble to get mplayer working with an external pcm I/O plugin
(a2dp from bluez). The problem is that mplayer needs to know how much space
is left in the ring buffer:

  snd_pcm_status(alsa_handler, status)
  ret = snd_pcm_status_get_avail(status) * bytes_per_sample;

Now with the ALSA kernel driver, ret will vary, depending on how much data
 was written to the device, and how much time passed.

However, with the I/O plugin, snd_pcm_status_get_avail() always returns the
maximum value (causing mplayer to think that all samples have been played). I
can't find a callback function for the status in snd_pcm_ioplug_callback_t
where I could adjust the avail value.

I'd appreciate any hints.

Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
