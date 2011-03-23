Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=R7kt2tFTpj_RBBbnoPBGNT90K0grshUSJNVnD@mail.gmail.com>
References: <AANLkTi=R7kt2tFTpj_RBBbnoPBGNT90K0grshUSJNVnD@mail.gmail.com>
Date: Wed, 23 Mar 2011 19:47:40 +0100
Message-ID: <AANLkTi=V2VHmO1R4wmo_D99X=pz4PdqBfJuTPOj8eN6s@mail.gmail.com>
Subject: Re: android: bluetoothd hung after bluetooth had been turned off
From: Vitaly Wool <vitalywool@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 22, 2011 at 8:11 PM, Vitaly Wool <vitalywool@gmail.com> wrote:
> Greetings,
>
> I'd got a nasty hang in my Android phone when I turned bluetooth off
> from the UI while the music was playing over bluetooth connection.

as a follow-up on this, it looks like the problem is fairly generic on
one hand but may be specific to Android, on the other.

bluetoothd defines its own signal handler for SIGTERM (sig_term())
which calls g_main_loop_quit(event_loop).

The latter will call g_main_context_wakeup_unlocked() which is exactly
the following:

   g_main_context_wakeup_unlocked (GMainContext *context)
   {
   #ifdef G_THREADS_ENABLED
     if (g_thread_supported() && context->poll_waiting)
       {
         context->poll_waiting = FALSE;
   #ifndef G_OS_WIN32
         write (context->wake_up_pipe[1], "A", 1);
   #else
         ReleaseSemaphore (context->wake_up_semaphore, 1, NULL);
   #endif
       }
   #endif

This is meant to make bluetoothd quit waiting on a poll() call in
g_main_context_poll() which is polling on the read descriptor of this
pipe along with all the other descriptors supplied by bluetoothd.
Unfortunately gthreads are not initialized in Android, moreover, this
part of glib code is not even compiled, so g_thread_supported()
returns false and this function is basically no-op in the Android
case.

So if there are no other events for the poll() to quit, we'll get
stuck in poll() forever because the write to wake_up_pipe will never
happen.

Still don't have a good enough idea on how to fix it in the right way though...

~Vitaly
