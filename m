Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391339801-587-12-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1391339801-587-12-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Sun, 2 Feb 2014 09:27:30 -0400
Message-ID: <CAJdJm_OCbUjZVEoNL1y7911zk3QgsQKmQjAJfQh15fhLeTGutA@mail.gmail.com>
Subject: Re: [PATCH 11/11] android/tester: Make bt_callbacks thread-safe
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sun, Feb 2, 2014 at 7:16 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> This patch adds wrappers for BT HAL callback which execute them in main
> thread instead of notification_handler() thread. Otherwise test
> execution is prone to race conditions since we do not provide any
> locking mechanism for tester.

In my opinion, this is becoming too messy. I'm getting races even
inside the emulator code: sometimes bthost->ncmd becomes zero before a
HCI command is sent by the emulated host because the Command Status /
Command Complete comes after the command is written to the socket, but
before bthost->ncmd is decremented.

Also try running android-tester under valgrind. At least for me, I get
a few failures that I don't have when running without valgrind (at
least one in HIDHost apparently due to if_bluetooth->enable() not
being called on test setup and thus the tests rely on finishing before
the controller is powered off by the kernel after initialization).

IMHO, the best approach would be to keep all HAL API usage in a
separate process, and keep android-tester single-threaded. Of course,
this could extra complexity for the required IPC between
android-tester and this new process...

Again, I'm not familiar with how HAL API works, all this is just based
on my failed attempt to make android-tester run reliably under
valgrind.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
