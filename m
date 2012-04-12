Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334065112-14966-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334065112-14966-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 12 Apr 2012 14:08:55 +0300
Message-ID: <CABBYNZL+=4=LLYKyatUtKOpTuo2ERttHOozW-smTtuN-0GJ4CQ@mail.gmail.com>
Subject: Re: [PATCH obexd v1 04/11] client: fix progress report before field update
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Apr 10, 2012 at 4:38 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The progress report in put_xfer_progress was done before the
> corresponding field was updated.
> ---
>  client/transfer.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 3b4f8f2..b558d84 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -494,10 +494,10 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
>        if (size <= 0)
>                return size;
>
> -       transfer_notify_progress(transfer);
> -
>        transfer->transferred += size;
>
> +       transfer_notify_progress(transfer);
> +
>        return size;
>  }
>
> --
> 1.7.7.6

git blame indicates this has been there in the past but it was changed
by this commit:

commit e1891acc03a22cc59f0dfb29869243f3ca81e716
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Oct 3 18:43:16 2011 +0300

    Fix possible crash when indicating progress

    The amount of transferred bytes should only be updated after it has
    been sent.

It may not crash anymore, but the change is still logically correct
since the data has yet to be sent.

-- 
Luiz Augusto von Dentz
