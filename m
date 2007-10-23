Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 23 Oct 2007 17:12:51 +0300
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803882911@esebe104.NOE.Nokia.com>
In-Reply-To: <471730B2.3030606@free.fr>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
	<471730B2.3030606@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils-fix-a2dp-buffer-constraints
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

Hi Fabian, Luiz, and others,

On 18 Oct 2007,  Fabien Chevalier wrote:
>>>  - increased max overall buffer size to 16384 bytes (~93msecs
>> 
>> hmm, looking at this more deeply, I realized this doesn't quite work.

>> I originally thought there is a real ringbuffer (imitating the usual 
>> audio hardware ringbuffer) between the worker thread and the 
>> application, but this appears not to be the case.
>
>No this is not the case. :-)
>I implemented it that way so that not to add another buffering layer.
>As per ALSA semantic, the buffer is found in the remote 
>device, but we have no way of knowing how big it is. :-(

ok, this indeed affects the buffering constraints we should
expose to the client (and my original buffer-constraints patch
should be reverted).

One drawback of this design is that the timing of packet transmission 
is not totally controlled by the plugin. Instead, whenever the
application
decides to write to the ALSA device, a packet might be sent. If
the overall buffer-size is not constrained, application can send
bursts of data, which will lead to burts of RTP packets sent to 
headset, which will probably confuse it. Of course, if the bursts
stay within the limits of headset's receive buffer, we are ok, but
that's seems somewhat fragile as we don't the buffer size.

To force application _not_ to do this, the plugin can put a strict
limit on buffer size and period count (-> application cannot write
bursts of data to the plugin, but instead it will have to sleep until
the sufficient amount of time has elapsed). But as a consequency, the
timing
requirements become really strict for the application, which will
lead to XRUNs on loaded systems (and POSIX realtime scheduling might
not help as that might mess interactions with the worker and the
application thread).

Plus the following, quite common design in ALSA apps, doesn't 
work as expected:
  - preload X frames of audio to the plugin
  - ... do something else (that takes time)
  - use snd_pcm_start() to trigger playback
... as the headset might start playback already before snd_pcm_start().

But I do agree that it makes sense to avoid adding another
layer of buffering in the plugin.

Hmm, one compromise solution might be to use the existing buffer
setup, but use the worker thread to actually send the packets (at
intervals 
defined by the system timer, not by the application calls to
the plugin). If we set the buffer constraint to match the number
of bytes needed by the SBC encoder per packet, and allow use of
multiple periods, we'd 1) have no duplicated buffering, 2) timing
would be more regular, 3) application would have slightly more
relaxed timing requirements (hopefully leading to less XRUNs).
Comments?

>Well, application can prefill more data, the data gets send 
>immediately to the headset, and buffering will happen at 
>headset side. The issue is if the buffer size as seen by the 
>application is bigger than the real headset buffer size, and 
>the application waits for the buffer to be almost empty before 
>to refill it, then audio cuts might happen. :-(

Yeps, I guess that's precisely the risk with sending bursts of 
packets. OTOH, I guess it's not so clear cut. I guess some headsets 
may require an initial burst before they start playback.

>Well, yes and no. a2dpd implementation was written the way you 
>though we were working. Audio service ALSA plugin is written 
>another way, that is known to work. However we didn't tune the 
>implementation to improve its behaviours regarding the number 
>of application wakeups it generates, nor the buffer sizes or 

Aa, ok, thanks, this is good to know.

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
