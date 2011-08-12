Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 15:30:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Fix handling asynchronous plugin reads
Message-ID: <20110812123006.GB30885@dell>
References: <1313140003-21576-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313140003-21576-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Aug 12, 2011, Slawomir Bochenski wrote:
> Calling OBEX_ResumeRequest() from handle_async_io() may result in direct
> calling obex_event_cb() (this happens when obex_write_stream() will
> deliver not enough bytes to fully fill OpenOBEX TX packet). In this case
> set_io_watch will fail if handle_async_io() is called from
> obex_object_set_io_flags(), because the watch is already installed.
> Originally when code returns from OBEX_ResumeRequest(), handle_async_io()
> returns FALSE which makes obex_object_set_io_flags() remove this watch.
> 
> This patch adds variable for tracking whether subsequent calls suspended
> get request, causing obex_object_set_io_flags() remove the watch only
> when the request is not suspended.
> 
> Additionaly member 'streaming' of obex_session has been renamed to
> 'stream_open'.
> ---
>  src/obex-priv.h |    3 ++-
>  src/obex.c      |   14 +++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
