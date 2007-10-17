Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 17 Oct 2007 19:31:25 +0300
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -
	fix-a2dp-buffer-constraints
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

On 12 Oct 2007, Kai Vehmanen wrote: 
>Here're couple of patches (against CVS HEAD) that solve the 
>problems for me (for instance pulseaudio starts working with 
>the plugin, less CPU usage with other apps). If you think 
[...]
>This first modifies the buffering constraints as exposed by 
>the A2DP ALSA plugin:
>  - increased max overall buffer size to 16384 bytes (~93msecs
>    of CD quality audio, so a reasonable max size)

hmm, looking at this more deeply, I realized this doesn't quite 
work. I originally thought there is a real ringbuffer (imitating 
the usual audio hardware ringbuffer) between the worker
thread and the application, but this appears not to be the
case. Current code seems to gather samples-to-be-sent in a buffer,
and when a threshold (a2dp->codesize or cfg.pkt_len) is reached,
a packet is then sent right away. So in other words, application
cannot really prefill more data than one packet worth, and most of 
the allocated buffer space gets never used.

So I guess this specific patch should be dropped (it might fix
some issues, but at least the assumptions I used to pick the 
values are wrong ;)). The other patch should still be valid.

What I intended with the patch was that you could...:
  - prefill N*a2dp_codesize (less than buffersize) worth of 
    PCM frames
  - trigger playback 
      -> oldest queued a2dp_codesize worth of samples is encoded 
        and sent
  - application is woken up every M*a2dp_codesize
      - in case application is occasionally late, the worker
        thread would still be encoding and sending packets
        at a steady rate using the buffered samples
	- with M>1, application can reduce the amount of wakeups
        needed, but will increase the playout latency (but
        note: the HW thread still needs to wake up for every 
        a2dp_codesize)
  - an XRUN occurs only if application is stalled for 
    duration of N*a2dp_codesize
        
But yeah, that would seem to be a much bigger task to implement (and
something you may have already discussed earlier).

br,
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
