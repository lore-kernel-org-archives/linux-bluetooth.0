Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 15 May 2007 22:22:11 +0200
References: <5b9417770705141014w20611f52v50526f928501803c@mail.gmail.com>
	<200705150200.43977.bluez-devel@huitl.de>
In-Reply-To: <200705150200.43977.bluez-devel@huitl.de>
MIME-Version: 1.0
Message-Id: <200705152222.11641.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] skype and bluetooth
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Okay after some debugging I know what the problem is.

On Dienstag, 15. Mai 2007, Robert Huitl wrote:
> 1) Skype tries to use a sample format that is not supported at all or

Skype uses the sample format SND_PCM_FORMAT_S16_LE which is supported by the 
pcm_sco plugin, but it also requests a sampling rate of 48 KHz, which is not.

Having patched alsa-lib to trace the calls to snd_pcm_hw_params_set_rate*(), I 
get the following output when I try to initiate a call:

DEBUG: snd_pcm_hw_params_set_rate_near(48000)
DEBUG: snd_pcm_hw_params_set_rate(48000)
[pause]
DEBUG: snd_pcm_hw_params_set_rate(48000)
[error message appears]

When I change SCO_RATE in pcm_sco.c from 8000 to 48000 and set the headset as 
the input device only, Skype goes past the "problem with audio" message (the 
recorded sound is garbage, of course).

So to conclude,
1.) 48 kHz is, to say the least, a rather high value for sampling from a 
microphone. This is probably not intended by Skype and might just very well 
be a bug as it's an alpha version.

2.) Offering more sampling rates than 8 kHz would be nice to have, but I'm not 
familiar with the design philosophies around ALSA. It's probably not a good 
idea to implement resampling in each and every sound plugin like pcm_sco. 
Does ALSA have some resampling facilities that can be plugged in between an 
application and a plugin? Maybe some magic lines in .asoundrc?

Regards,
  Robert

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
