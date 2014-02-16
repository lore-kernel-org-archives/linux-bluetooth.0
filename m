Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>, BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 11/11] android/tester: Make bt_callbacks thread-safe
Date: Sun, 16 Feb 2014 22:04:05 +0100
Message-ID: <1607843.bDDYSRAnNN@leonov>
In-Reply-To: <EF441CC3-EFCF-4A2A-8ADF-D9F6FF262E4D@holtmann.org>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_OCbUjZVEoNL1y7911zk3QgsQKmQjAJfQh15fhLeTGutA@mail.gmail.com> <EF441CC3-EFCF-4A2A-8ADF-D9F6FF262E4D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Anderson,

On Sunday 02 of February 2014 08:55:49 Marcel Holtmann wrote:
> Hi Anderson,
> 
> >> This patch adds wrappers for BT HAL callback which execute them in main
> >> thread instead of notification_handler() thread. Otherwise test
> >> execution is prone to race conditions since we do not provide any
> >> locking mechanism for tester.
> > 
> > In my opinion, this is becoming too messy. I'm getting races even
> > inside the emulator code: sometimes bthost->ncmd becomes zero before a
> > HCI command is sent by the emulated host because the Command Status /
> > Command Complete comes after the command is written to the socket, but
> > before bthost->ncmd is decremented.
> > 
> > Also try running android-tester under valgrind. At least for me, I get
> > a few failures that I don't have when running without valgrind (at
> > least one in HIDHost apparently due to if_bluetooth->enable() not
> > being called on test setup and thus the tests rely on finishing before
> > the controller is powered off by the kernel after initialization).
> > 
> > IMHO, the best approach would be to keep all HAL API usage in a
> > separate process, and keep android-tester single-threaded. Of course,
> > this could extra complexity for the required IPC between
> > android-tester and this new process...
> > 
> > Again, I'm not familiar with how HAL API works, all this is just based
> > on my failed attempt to make android-tester run reliably under
> > valgrind.
> 
> I have to agree. We might better spawn processes for this. Our emulator code
> was never designed to be thread safe and never will be. We are just hiding
> the real problem here and it will break somewhere else later on.

I think using g_idle_add to have checks executes in right thread context 
pretty clear and easy to follow. Spawning processes will require dedicated IPC 
that will wrap either HAL or emulator and that will be quite complicated 
comparing to using g_idle_add. Jakub did some initial implementation for this 
and it adds ~800 sloc (and will be more in future...).

So I would go with using g_idle_add but refactor propose patch to emphasize 
that those are tests checks that execute in mainloop context, not HAL 
callbacks.

-- 
BR
Szymon Janc
