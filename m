Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C9E152.1060701@free.fr>
Date: Mon, 20 Aug 2007 20:45:38 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C875BA.90204@free.fr> <1187550916.11068.51.camel@violet>
In-Reply-To: <1187550916.11068.51.camel@violet>
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


Hi Marcel,

please find below some comments.

> 
> I tested the patch with my Logitech headphone and it makes beep work
> fine. Using xmms has serious problems. This keeps happening:
> 
> ** WARNING **: alsa_write_audio(): write error: Resource temporarily unavailable

Interesting... that didn't happen to me !

> 
> However I do have blanks with beep, too. It can also crash:

Looks like the same issue XMMS has, where underrun can occasionally happen.

> 
> beep-media-player: pcm_bluetooth.c:386: a2dp_playback_hw_thread:
> Assertion `ret == 1' failed.
> 
> This is triggered by a song end where the stream is still open, but beep
> fails to enhance to the next track.

That basically means beep forgots to close the stream in a timely maneer 
after those kind of issues. I should SNDERR() something rather than 
assert on this one however...

> 
> Using usleep() seems not precise enough to me. 
Well considering that you definetely *don't need* any kind of precise 
timing for streaming in general, and a2dp in particular, usleep is an 
order of magnitude too precise already. In fact 10 ms granularity would 
be more than enough.

Also we might not wanna
> use a pipe. Some other notification mechanism might be better. I don't
> really know what solution is best here.

Well, it has to be conveyed using a file descriptor due to ALSA using 
poll() to be notifyed of hardware wakeup.
So unless anybody has a better idea, i consider a pipe as the best way 
to go ;-)

> 
> When using mplayer to watch a movie, I have sound blanks from time to
> time and it also crashed:
> 
> mplayer: pcm_bluetooth.c:386: a2dp_playback_hw_thread: Assertion `ret == 1' failed.

Could you be more precise ? Which kind of codec ? For how long did you 
play ?

> MPlayer interrupted by signal 6 in module: sleep_timer
> 
> However it is a huge improvement and a big step in the right direction.
> I know that Luiz was working on a similar patch. Try to get on #bluez on
> freenode.org so the future work can be coordinated.

Will try, however ML is easier for me as when i work on bluez stuff i 
usually only have an old RTC line :-(

> 
> Besides that, please fix the coding style. I am serious about that. I am
> picky about whitespace placements, but you already knew that:
> 
> Every "if" is following by a whitespace like "if (". No exceptions.

Hmmm... is this rule only for if's are is it valid for any kind of 
reserved key word ??

> 
> Also stuff like this is not acceptable:
> 
> pfd[0].fd = ((struct bluetooth_data *)io->private_data)->stream_fd;
> 
> If I have to twist my mind too much to understand why this code is
> correct it is too complex. Do something like this:
> 
> struct bluetooth_data *data = io->private_data;
> pfd[0].fd = data->stream_fd;

As you wish...

> 
> Don't invert the result of a function call:
> 
> ret = -pthread_create(&a2dp_data->hw_thread, 
> 
> However thought this is a good idea is wrong. This is big hole for
> overlooking sign errors. Don't do it. Do this instead:
> 
> return -ret

You're right that wasn't the smartest piece of code i wrote recently
  :-)
> 
> And while we are at it. Don't initiate variables with a value:
> 
> int ret = 0;
> 
> This is only needed in a few rare cases and will hide errors in the code
> flow that otherwise gcc might have caught.

Hmmm... I'm quite surprised : good programming practices tend to 
recommend to always initialize variables, unless this is obvious enough 
that the variable gets initialized right after declaration : could you 
bring more arguments under the hood ? I'm far from being conviced...

> 
> And instead of "ret" use "err" which I prefer.

Makes sense as it is an error code anyway...

> 
> The assert() statements are nice for development, but we can't have them
> in the final version. 

We have to prevent asserts to be executed on final version, that doesn't 
mean we have to remove them from the code however.
The correct way to use asserts is to have them enabled only when 
configuring using --enable-debug
If it's not currently the case on bluez-utils i suggest we patch its 
build process... and keep the asserts :-)


> We have to survive as much errors as possible and
> better play nothing than crash.

Agree.


> 
> The "for(;;) {" statement are better replaced with "while (1) {".
> 
> For the "volatile snd_pcm_sframes_t hw_ptr;". Do you think that is
> enough and we not better use a lock or a mutex?

That's enough for my case, where i have a single writer. Volatile is 
just to prevent the compiler to optimize away by keeping a variable in 
registers while it's value in main memory is changed by another thread.

Regards,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
