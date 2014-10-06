Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412593085-12618-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412593085-12618-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 6 Oct 2014 14:21:31 +0200
Message-ID: <CAN_7+Yaps1ZA97wYjSE+vpieF=64x7fY__nC+d-VtCb6NDSzPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/hfp: Improve next_field() function
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 6, 2014 at 12:58 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> In HF Client case we might have "-" separator between hf data. For
> example +CIND: ("signal",(0-5))
> With this patch next_field() is able to skip "-" as well.
> ---
>  src/shared/hfp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index efc981f..bc091b5 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -221,7 +221,8 @@ done:
>
>  static void next_field(struct hfp_gw_result *result)
>  {
> -       if (result->data[result->offset] == ',')
> +       if (result->data[result->offset] == ',' ||
> +                                       result->data[result->offset] == '-')

Actually this might brake parsing some AT commands.  Ignore this patch.

\Lukasz
>                 result->offset++;
>  }
>
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
