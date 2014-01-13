Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jan 2014 10:42:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btproxy: Fix double close
Message-ID: <20140113084229.GC27885@x220.p-661hnu-f1>
References: <1389258082-10847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389258082-10847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 09, 2014, Andrei Emeltchenko wrote:
> setup_streams() already makes close()
> ---
>  tools/btproxy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied. Thanks.

Johan
