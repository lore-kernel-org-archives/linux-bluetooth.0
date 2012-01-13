Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326464270-20110-1-git-send-email-s.syam@samsung.com>
References: <1326464270-20110-1-git-send-email-s.syam@samsung.com>
Date: Fri, 13 Jan 2012 18:35:23 +0200
Message-ID: <CABBYNZKd1wWb4k=25KZ8PQ7MUc4ozYRJ21iU3t1k23ovKk6u9Q@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Remove unused code in pbap
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Fri, Jan 13, 2012 at 4:17 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> ---
>  client/pbap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/client/pbap.c b/client/pbap.c
> index 9e9eb05..73d496a 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -364,7 +364,6 @@ static void read_return_apparam(struct obc_session *session,
>  {
>        struct obc_transfer *transfer = obc_session_get_transfer(session);
>        struct obc_transfer_params params;
> -       unsigned char *buf;
>        size_t size = 0;
>
>        *phone_book_size = 0;
> @@ -404,7 +403,6 @@ static void read_return_apparam(struct obc_session *session,
>                                        hdr->tag, hdr->len);
>                }
>
> -               buf += APPARAM_HDR_SIZE + hdr->len;
>                size -= APPARAM_HDR_SIZE + hdr->len;
>        }
>  }
> --
> 1.7.4.1

Actually this is still wrong since hdr pointer is never updated it is
only processing the first header, I was just fixing it today while
doing some other cleanups , apparently we never got any problem
because the responses normally only contain one hdr/parameter.

-- 
Luiz Augusto von Dentz
