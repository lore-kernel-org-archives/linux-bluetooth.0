Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 May 2015 10:45:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATHv2] adapter: Fix memory leak
Message-ID: <20150518074532.GA18361@t440s.lan>
References: <20150517073124.GA27593@t440s.P-661HNU-F1>
 <1431933192-18203-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431933192-18203-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, May 18, 2015, Andrei Emeltchenko wrote:
> In case of error with dbus stuff free allocated memory and set filter
> to NULL.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Johan
