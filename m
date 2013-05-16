Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwgkWe+A5rbEnhgNxc5Va9TQt_-Pp04c5rP18nO2FF9f2A@mail.gmail.com>
References: <CAGd9gwgKMt21TnGLJ09+gAkP-=Jn9mfoAThiBuqup_vTyCshuw@mail.gmail.com>
	<CAGd9gwgkWe+A5rbEnhgNxc5Va9TQt_-Pp04c5rP18nO2FF9f2A@mail.gmail.com>
Date: Thu, 16 May 2013 14:02:50 +0300
Message-ID: <CABBYNZLz=nP5fouBQw0oUYe_L4SOX3jPoQtkATYGispvs8dh_w@mail.gmail.com>
Subject: Re: a2dp.c: finalize_config(setup) can destroy setup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: keybuk <keybuk@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 16, 2013 at 7:06 AM, Alex Deymo <deymo@chromium.org> wrote:
> Hello,
>
> I just found this invalid read where finalize_config(setup); is
> actually destroying the setup pointer passed there. The log attached
> below is running with valgrind on bluez 5.5 (with a tiny patch to
> src/log.{c|h} to have the debug file:line:function on error() as you
> may see on the logs)
>
> The code around the open_cfm (a2dp.c:730) is:
> finalize_config(setup);
>
> if (!setup->start || !err)
>         return;

> and the invalid must be the "setup->start". The debug log shows that
> setup_free was called just before and if I'm not missing something, it
> must come from finalize_setup()... but not sure why.

Yep, this is actually a regression introduced by:
commit 99c6f5221800a48e8ce0b1e070e97d1c26a0f90b
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Feb 19 12:54:55 2013 +0200

    A2DP: Mark start flag if resume happen while in configured state

    If SEP is in configured state that means OPEN is about to happen so just
    mark start flag and send START once OPEN completes.

As we don't have a start flag, perhaps because the endpoint don't
try/delay the Acquire, the setup is free by finalize_config because
there is no other operation pending.

> The steps to run into this (although there may be some timing
> involved) are simply scan, pair, trust and connect the device with
> bluetoothctl. Device is a Bose SoundLink model 404600.

Looks like there are some new devices that should try to get a hold,
anyway this problem should be fixed ASAP so what about the following
patch:

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 215f4db..c6973ae 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -723,16 +723,12 @@ static void open_cfm(struct avdtp *session,
struct avdtp_local_sep *sep,
        if (err) {
                setup->stream = NULL;
                setup->err = err;
+               if (setup->start)
+                       finalize_resume(setup);
        }

        finalize_config(setup);

-       if (!setup->start || !err)
-               return;
-
-       setup->start = FALSE;
-       finalize_resume(setup);
-
        return;
 }
