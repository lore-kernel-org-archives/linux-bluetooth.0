Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 11:20:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not detecting errors on small files
Message-ID: <20100930082034.GA9301@jh-x301>
References: <1285834199-20500-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285834199-20500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 30, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Make use of gw_obex_xfer_close instead of gw_obex_xfer_flush since the
> former not only flushes the remaining data but also wait for the response
> catching errors that gw_obex_xfer_flush doesn't.
> ---
>  client/transfer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks for the patch. It has been pushed upstream.

Johan
