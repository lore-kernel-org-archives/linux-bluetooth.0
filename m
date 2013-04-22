Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365809318-17775-1-git-send-email-deymo@chromium.org>
References: <1365809318-17775-1-git-send-email-deymo@chromium.org>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 22 Apr 2013 10:51:22 -0700
Message-ID: <CAGd9gwh8uhkjRsAqCRfCwbssRfCuEiONtwKe6AuP6jHyyVXPvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Autopair plugin, with some extensions.
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, keybuk <keybuk@chromium.org>,
	Alex Deymo <deymo@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 12, 2013 at 4:28 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hi,
>
> This patch set includes a few changes mentioned in the mailing list
> and a new functionality for dumb keyboards (last 2 commits).
>
> "count" changed to "attempt". I agree that "attempt" is a better name.
> With this change, attempt is now started at 1, so the first attempt of
> a given plugin will be called with attempt==1. This also changes the
> variable type to an unsinged version since it is not supposed to store
> a negative number.
>
> Added a timer to measure the pairing duration of the last attempt. This
> is a great information to the autopair plugin to identify the cause of a
> pairing failure. If a keyboard rejects the provided pincode in very short
> time (less than 500ms) it means that the provided random pincode wasn't
> the right code and is likelly that any random pincode will be rejected.
> It turns out that those keyboards have a fixed pincode of "0000".
>
> Please take another look.

Ping?
