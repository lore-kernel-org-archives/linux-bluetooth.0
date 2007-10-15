Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Kai Vehmanen" <kai.vehmanen@nokia.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
References: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
	<4711FB4D.2010609@free.fr>
Date: Mon, 15 Oct 2007 13:54:13 +0300
Message-ID: <000601c80f19$b92b2270$0f9db70a@NOE.Nokia.com>
MIME-Version: 1.0
In-Reply-To: <4711FB4D.2010609@free.fr>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -fix-a2dp-buffer-constraints
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

Hi,

On 14 Oct 2007,  Fabien Chevalier wrote:
>Could you provide some details on the problems you 
>experienced, as well the hardware platform you experienced them on ?

I've been testing with a low spec GNU/Debian desktop, and the problem has 
been too high CPU load leading to a continuous stream of XRUNs in 
the pcm_bluetooth.c code (i.e. no audio output at all). With the patch, 
on the same exact system, playback is flawless. And the problem only
occurs with apps that always poll/select before writing to the device (i.e.
not aplay). Relaxing the buffering constraints allows apps to feed audio 
to A2DP with less context switches and less system calls (bigger buffer
fragments at a time basicly).

>> -	/* supported block size */
>> +	/* supported block sizes:
>> +	 *   - lower limit is A2DP codec size
>> +	 *   - total buffer size is the upper limit (with two periods) */
>>  	err = snd_pcm_ioplug_set_param_minmax(io,
SND_PCM_IOPLUG_HW_PERIOD_BYTES,
[...]
>> +	/* supported buffer sizes */
>> +	err = snd_pcm_ioplug_set_param_minmax(io,
SND_PCM_IOPLUG_HW_BUFFER_BYTES,
>> +					      MIN_BUFFER_SIZE,
MAX_BUFFER_SIZE);
>>  	if (err < 0)
>>  		return err;
>
>
>This part of the code is useless, you don't need to set 
>SND_PCM_IOPLUG_HW_BUFFER_BYTES if you set 
>SND_PCM_IOPLUG_HW_PERIODS, you just have to choose one of the 
>two alternatives :-)

But if we'd drop setting mimax for BUFFER_BYTES, the application could 
request for 64 periods of size 'MAX_BUFFER_SIZE / 2' -> 524288 bytes.
Of course we could fix this by limiting the max period size, but then 
the application couldn't use a buffering setup of two max-sized periods
(good for robust playback). If we'd limit the max count of periods, 
application couldn't choose a buffering setup of lots of small 
buffer fragments (good for robust recording with minimal latency).

So defining a minmax range for all three params gives more
flexibility without requiring any added logic to the plugin
code.

-- 
first.surname@nokia.com (Kai Vehmanen)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
