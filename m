Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C875BA.90204@free.fr>
References: <46C875BA.90204@free.fr>
Date: Sun, 19 Aug 2007 21:15:16 +0200
Message-Id: <1187550916.11068.51.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
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

Hi Fabien,

> Following recent mailing list discussions, i decided to implement some 
> of the ideas that have been suggested recently. :-)
> 
> So i heavily modified the A2DP streaming part of the pcm plugin
> 
> The user-visible features of this patch:
>    * much reduced latency (You should love this one Frederic)
>    * supports headsets that are unable to throttle the data flow and
>      that play too fast or drop packets or whatever (Marcel, could you
>      please confirm that fixes the issues you had with some headsets ?).
> 
> This patch is fairly intrusive, and removes some code that i judjed 
> useless now, like the bandwidth measurement stuff, and has greatly 
> simplifyed transfer loop for avdtp (see comments in the code for the 
> justifications)
> 
> It brings in a thread that has for only reponsibility to increment the 
> so called hardware pointer (which doesn't point to anything in our 
> case), and notify the application trough writing in a pipe that some 
> room is available (virtual room again), so that it could send more data.
> 
> The attached file details the tests i've run to check i didn't break 
> anything. All is conclusive except playing with XMMS that goes underrun 
> for a reason i haven spotted yet. Apart from that aplay, mplayer, 
> gstreamer are fine.
> 
> I'm looking forward for any questions you have on the patch.

I tested the patch with my Logitech headphone and it makes beep work
fine. Using xmms has serious problems. This keeps happening:

** WARNING **: alsa_write_audio(): write error: Resource temporarily unavailable

However I do have blanks with beep, too. It can also crash:

beep-media-player: pcm_bluetooth.c:386: a2dp_playback_hw_thread:
Assertion `ret == 1' failed.

This is triggered by a song end where the stream is still open, but beep
fails to enhance to the next track.

Using usleep() seems not precise enough to me. Also we might not wanna
use a pipe. Some other notification mechanism might be better. I don't
really know what solution is best here.

When using mplayer to watch a movie, I have sound blanks from time to
time and it also crashed:

mplayer: pcm_bluetooth.c:386: a2dp_playback_hw_thread: Assertion `ret == 1' failed.

MPlayer interrupted by signal 6 in module: sleep_timer

However it is a huge improvement and a big step in the right direction.
I know that Luiz was working on a similar patch. Try to get on #bluez on
freenode.org so the future work can be coordinated.

Besides that, please fix the coding style. I am serious about that. I am
picky about whitespace placements, but you already knew that:

Every "if" is following by a whitespace like "if (". No exceptions.

Also stuff like this is not acceptable:

pfd[0].fd = ((struct bluetooth_data *)io->private_data)->stream_fd;

If I have to twist my mind too much to understand why this code is
correct it is too complex. Do something like this:

struct bluetooth_data *data = io->private_data;
pfd[0].fd = data->stream_fd;

Don't invert the result of a function call:

ret = -pthread_create(&a2dp_data->hw_thread, 

However thought this is a good idea is wrong. This is big hole for
overlooking sign errors. Don't do it. Do this instead:

return -ret

And while we are at it. Don't initiate variables with a value:

int ret = 0;

This is only needed in a few rare cases and will hide errors in the code
flow that otherwise gcc might have caught.

And instead of "ret" use "err" which I prefer.

The assert() statements are nice for development, but we can't have them
in the final version. We have to survive as much errors as possible and
better play nothing than crash.

The "for(;;) {" statement are better replaced with "while (1) {".

For the "volatile snd_pcm_sframes_t hw_ptr;". Do you think that is
enough and we not better use a lock or a mutex?

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
