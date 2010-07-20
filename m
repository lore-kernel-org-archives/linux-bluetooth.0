Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikcX6_SydJf4YRG3ym4Q0GVGQ26WpAh3Mm1uyyQ@mail.gmail.com>
References: <AANLkTikcX6_SydJf4YRG3ym4Q0GVGQ26WpAh3Mm1uyyQ@mail.gmail.com>
Date: Tue, 20 Jul 2010 14:16:36 +0300
Message-ID: <AANLkTilJNclAEoLpJnUDkHHiwpynoSpIXErJnYpHF6aF@mail.gmail.com>
Subject: Re: obex-client: doesn't allways closes socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vitja Makarov <vitja.makarov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 20, 2010 at 10:12 AM, Vitja Makarov <vitja.makarov@gmail.com> wrote:
> Hi!
>
> Recently I've found that obex client doesn't allways close socket, I
> was using obexd-0.29...
> Even more sometimes it closes same socket twice using
> g_io_channel_unref() and close()

I guess the real ones are gw_obex_close and close, so both end up
closing the same fd.

> When it comes to client/session.c:rfcomm_connect() with error,
> session->sock is not set and socket is not closed on
> session_shutdown()
> Don't know why g_io_channel_unref() isn't called for that socket..

Yep, there is no much point on storing the fd on session->sock in the
other hand the io that bt_io_connect gives is the one causing the
problem here, either we release this reference and then we have to set
not to close the fd or we just keep the io reference and store it on
session so we can actually cancel the connection attempt.


-- 
Luiz Augusto von Dentz
Computer Engineer
