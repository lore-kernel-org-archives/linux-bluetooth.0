Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] core: fix unbound watchdog-notify for timeouts <2s
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANq1E4QdKVCVVk6o=dP9vqsVP7fAe6ROhoMcw_y0Pp+oi5O0zA@mail.gmail.com>
Date: Sun, 14 Sep 2014 10:54:24 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Michael Biebl <mbiebl@gmail.com>
Message-Id: <CAA4C4BB-35EF-41A3-8403-D2A7DD8FE7B2@holtmann.org>
References: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com> <25587ECB-CBF8-4E5C-9E86-63CACCFD1A0D@holtmann.org> <CANq1E4ShytEnUq-U+cK9i+qjHoyMUK0DChEb9FExGdDEOpX1SA@mail.gmail.com> <CANq1E4QdKVCVVk6o=dP9vqsVP7fAe6ROhoMcw_y0Pp+oi5O0zA@mail.gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>>> I get the feeling that if > 2s, then we should use g_timeout_add_seconds to get the advantage of being woken up with all other timeouts in our daemon. And when it is <= 2s, then we better use a high precision g_timeout_add.
>> 
>> This sounds actually good. I will do that in v2.
> 
> Ok, glib only supports millisecond precision, so whatever we do, there
> will be a WATCHDOG_USEC range that we cannot react to properly. Ok, to
> be honest, if WATCHDOG_USEC is below 1ms, we're screwed anyway, so
> maybe we should just keep our current behavior.. I mean there is
> nothing sane to do for use if users specify such low watchdog ranges.
> At some point, we have to resort to either run watchdogs without a
> timeout or bail out and tells users to stop using such low values.
> Whether this is at 1s or at 1ms doesn't matter much, does it?

I am fine with just bailing out and terminating the daemon with an error exit code in case the watchdog timeout is < 2 seconds.

Regards

Marcel

