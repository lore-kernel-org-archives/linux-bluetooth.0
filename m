Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jan 2014 10:09:52 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit/ringbuf: Fix memory leak
Message-ID: <20140127180952.GA7831@x220.p-661hnu-f1>
References: <1390811769-11861-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390811769-11861-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 27, 2014, Andrei Emeltchenko wrote:
> free allocated memory before exit
> ---
>  src/shared/ringbuf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
