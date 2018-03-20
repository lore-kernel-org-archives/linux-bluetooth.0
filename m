Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1521522581-13036-1-git-send-email-avichal.a@samsung.com>
References: <CGME20180320051001epcas1p3945a3b9beb4f980540c77f487f0c8d80@epcas1p3.samsung.com>
 <1521522581-13036-1-git-send-email-avichal.a@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Mar 2018 10:44:32 +0200
Message-ID: <CABBYNZ+apdoe4eUVAFM0-KWs71Cf=CVdYp8KdxWg8qaWDZwJWw@mail.gmail.com>
Subject: Re: [PATCH v3 BlueZ 1/2] doc/gatt-api.txt: Add support for Included Service
To: Avichal Agarwal <avichal.a@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Avichal,

On Tue, Mar 20, 2018 at 7:09 AM, Avichal Agarwal <avichal.a@samsung.com> wrote:
> included service support implemented at server side
>
> ---
>  doc/gatt-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index ccf3a8b..9579381 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -45,7 +45,7 @@ Properties    string UUID [read-only]
>                         belongs to. Only present on services from remote
>                         devices.
>
> -               array{object} Includes [read-only]: Not implemented
> +               array{object} Includes [read-only]
>
>                         Array of object paths representing the included
>                         services of this service.
> --
> 2.7.4

Applied, thanks. Note that I did substantial changes to fix the coding
style and remove some debugs that made no sense for the final code.
Btw, it would be really cool if you can add Includes support to
bluetoothctl.

-- 
Luiz Augusto von Dentz
