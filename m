Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <471730B2.3030606@free.fr>
Date: Thu, 18 Oct 2007 12:08:50 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
In-Reply-To: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils
	-	fix-a2dp-buffer-constraints
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

Hello Kai,

Please find below some comments.

> On 12 Oct 2007, Kai Vehmanen wrote: 
>> Here're couple of patches (against CVS HEAD) that solve the 
>> problems for me (for instance pulseaudio starts working with 
>> the plugin, less CPU usage with other apps). If you think 
> [...]
>> This first modifies the buffering constraints as exposed by 
>> the A2DP ALSA plugin:
>>  - increased max overall buffer size to 16384 bytes (~93msecs
>>    of CD quality audio, so a reasonable max size)
> 
> hmm, looking at this more deeply, I realized this doesn't quite 
> work. I originally thought there is a real ringbuffer (imitating 
> the usual audio hardware ringbuffer) between the worker
> thread and the application, but this appears not to be the
> case. 

No this is not the case. :-)
I implemented it that way so that not to add another buffering layer.
As per ALSA semantic, the buffer is found in the remote device, but we 
have no way of knowing how big it is. :-(

Current code seems to gather samples-to-be-sent in a buffer,
> and when a threshold (a2dp->codesize or cfg.pkt_len) is reached,
> a packet is then sent right away. So in other words, application
> cannot really prefill more data than one packet worth, and most of 
> the allocated buffer space gets never used.

Well, application can prefill more data, the data gets send immediately 
to the headset, and buffering will happen at headset side. The issue is 
if the buffer size as seen by the application is bigger than the real 
headset buffer size, and the application waits for the buffer to be 
almost empty before to refill it, then audio cuts might happen. :-(

> 
> So I guess this specific patch should be dropped (it might fix
> some issues, but at least the assumptions I used to pick the 
> values are wrong ;)). 

Even if your assumptions were wrong, this part of the code is still very 
much work in progress, and didn't receive any tuning at all.
So Johan tested your patch, didn't noticed any regression, so we decided 
to apply it anyway. :-)


The other patch should still be valid.
> 
> What I intended with the patch was that you could...:
>   - prefill N*a2dp_codesize (less than buffersize) worth of 
>     PCM frames
>   - trigger playback 
>       -> oldest queued a2dp_codesize worth of samples is encoded 
>         and sent
>   - application is woken up every M*a2dp_codesize
>       - in case application is occasionally late, the worker
>         thread would still be encoding and sending packets
>         at a steady rate using the buffered samples
> 	- with M>1, application can reduce the amount of wakeups
>         needed, but will increase the playout latency (but
>         note: the HW thread still needs to wake up for every 
>         a2dp_codesize)
>   - an XRUN occurs only if application is stalled for 
>     duration of N*a2dp_codesize
>         

That is basically another alternative implementation. For now i'm still 
not convinced this is the right way to go ;-). This will work but add 
another layer of buffering thus a much increased latency :-(


> But yeah, that would seem to be a much bigger task to implement

Yes indeed :-)
  (and
> something you may have already discussed earlier).

Well, yes and no. a2dpd implementation was written the way you though we 
were working. Audio service ALSA plugin is written another way, that is 
known to work. However we didn't tune the implementation to improve its
behaviours regarding the number of application wakeups it generates, nor 
the buffer sizes or period sizes :-(
I think you were the first one to run those kind of tests, that's why 
i'm still interested in you giving us the details of your tests setup :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
