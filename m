Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418637547-20848-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418637547-20848-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 15 Dec 2014 13:06:27 +0200
Message-ID: <CABBYNZJ0zuRc9+cW=sz-vEyxHYiWH4XLJ=VJpwE-2ZNg5mjJzg@mail.gmail.com>
Subject: Re: [PATCH 1/5] attrib/gatt: Fix minor coding style
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Dec 15, 2014 at 11:59 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  attrib/gattrib.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 7fe7647..3ce6748 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -224,7 +224,6 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
>         free(buf);
>  }
>
> -
>  static void attrib_callback_notify(uint8_t opcode, const void *pdu,
>                                         uint16_t length, void *user_data)
>  {
> --
> 1.8.4

Applied just this one, lets see what directions we should go with the
rest of the set.


-- 
Luiz Augusto von Dentz
