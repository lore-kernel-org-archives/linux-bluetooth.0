Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4ShytEnUq-U+cK9i+qjHoyMUK0DChEb9FExGdDEOpX1SA@mail.gmail.com>
References: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com>
	<25587ECB-CBF8-4E5C-9E86-63CACCFD1A0D@holtmann.org>
	<CANq1E4ShytEnUq-U+cK9i+qjHoyMUK0DChEb9FExGdDEOpX1SA@mail.gmail.com>
Date: Sun, 14 Sep 2014 19:41:50 +0200
Message-ID: <CANq1E4QdKVCVVk6o=dP9vqsVP7fAe6ROhoMcw_y0Pp+oi5O0zA@mail.gmail.com>
Subject: Re: [PATCH] core: fix unbound watchdog-notify for timeouts <2s
From: David Herrmann <dh.herrmann@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Michael Biebl <mbiebl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Sat, Sep 13, 2014 at 9:11 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> I get the feeling that if > 2s, then we should use g_timeout_add_seconds to get the advantage of being woken up with all other timeouts in our daemon. And when it is <= 2s, then we better use a high precision g_timeout_add.
>
> This sounds actually good. I will do that in v2.

Ok, glib only supports millisecond precision, so whatever we do, there
will be a WATCHDOG_USEC range that we cannot react to properly. Ok, to
be honest, if WATCHDOG_USEC is below 1ms, we're screwed anyway, so
maybe we should just keep our current behavior.. I mean there is
nothing sane to do for use if users specify such low watchdog ranges.
At some point, we have to resort to either run watchdogs without a
timeout or bail out and tells users to stop using such low values.
Whether this is at 1s or at 1ms doesn't matter much, does it?

So I think we can just keep the current behavior.

Thanks
David
