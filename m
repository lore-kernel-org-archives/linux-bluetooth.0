Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 17 Jan 2007 19:05:53 +0100
References: <200701150326.46855.bluez-devel@huitl.de>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
MIME-Version: 1.0
Message-Id: <200701171905.53515.bluez-devel@huitl.de>
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

On Wednesday 17 January 2007 08:03, Frederic Dalleau wrote:
> Robert,
> The sound is ok in mplayer! But the movie is a bit slow :D ...

Yes exactly :)
And then it prints that message about slow CPU, buggy sound drivers, etc.

> If you plugin is the pcm.!default, then you can workaround the problem by
> outputting audio to esound instead of alsa (see mplayer preferences). Not
> the best, but worked for me. +/- helped having perfect synchronisation with
> movie.

Nice. I will try this, but actually I'd rather not have another sound daemon 
(artsd is causing enough problems...)

> Brad,
>  I was wondering about alsa plugins :
> xmms relies on alsa timing to play, so in the plugin, there is a sleep()
> call, this will wait a little bit until it is time to retievre new data.
> But it seems some players (like mplayer) wants to do their own timing or at
> least don't want to sleep. They need to use that time to do some decoding
> instead. If you sleep too long, the decoding will be defered and the sound
> or movie will be broken.

You are talking about this code, aren't you?

static snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t * io, char *buf, 
int32_t datatoread)
[...]
  // The data are sent to the daemon that act as a proxy thus we double 
transfer delay to compensate latency
  a2dp_timer_notifyframe(&a2dp->TimerInfos);
  delay = a2dp_timer_sleep(&a2dp->TimerInfos, 4*A2DPTIMERPREDELAY);

Without really knowing what I was doing, I removed the a2dp_timer_sleep call. 
The result: mplayer plays the video as fast as possible (sound was broken, of 
course).

So maybe this delay is too long (however decreasing the delay did not improve 
things) or should not be there at all.

> Is there a rule to distinguish? Or some magic value to sleep?

I had a look at the io->nonblock variable and compared its value while playing 
with mplayer and play (part of sox), but it's 0 for both.

However, mplayer audio output devices implement a function
/* delay in seconds between first and last sample in buffer */
static float get_delay(void)

This function basically calls snd_pcm_delay(), which can be implemented in the 
a2dp io plugin. Mplayer calls this function quite frequently, maybe this is 
how it knows when to write new audio samples.

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
