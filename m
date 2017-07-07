Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1499353596-20988-1-git-send-email-s.syam@samsung.com>
References: <CGME20170706145900epcas5p3f02ab7299138d767b68c236bbb50c0ec@epcas5p3.samsung.com>
 <1499353596-20988-1-git-send-email-s.syam@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jul 2017 11:11:34 +0300
Message-ID: <CABBYNZKVNo6zHfJVTFD17Ae6hTk_1WO6mSa2OQCNm4qHPY=+6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] shared/gatt-server: Remove unwanted pointer validation
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Jul 6, 2017 at 6:06 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> Here the memory address pointed by the variable op is always valid.
> ---
>  src/shared/gatt-server.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 79e01c8..dc3bb8e 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -803,8 +803,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
>                                                         write_complete_cb, op))
>                 return;
>
> -       if (op)
> -               async_write_op_destroy(op);
> +       async_write_op_destroy(op);
>
>         ecode = BT_ATT_ERROR_UNLIKELY;
>
> --
> 1.7.9.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
