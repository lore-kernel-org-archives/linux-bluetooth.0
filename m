Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2015 10:31:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatt: Fix NULL pointer dereference
Message-ID: <20150517073158.GB27593@t440s.P-661HNU-F1>
References: <1431699421-21186-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431699421-21186-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, May 15, 2015, Andrei Emeltchenko wrote:
> Safely return in case of error.
> ---
>  peripheral/gatt.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
