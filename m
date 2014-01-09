Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 14:15:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared: Fix clearing of IO handlers
Message-ID: <20140109121532.GA9338@x220.p-661hnu-f1>
References: <1389263508-7073-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389263508-7073-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> If NULL callback is passed to io_set_read/write_handler don't add watch
> for it and just clear struct io memebers. This was resulting in
> write/read_callback being call in loop due to fd being never written
> or read.
> ---
>  src/shared/io-glib.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
