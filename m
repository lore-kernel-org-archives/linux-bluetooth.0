Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
References: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 8 Aug 2014 14:04:14 +0300
Message-ID: <CABBYNZJ5V4YMhjdjZ-ONpAejgmA1Tm1oPK6ebr+_AkSU=-r4Bg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] android/tester: Fix duplicate const
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 7, 2014 at 5:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/tester-main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 5a5cba4..3f0d46e 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -358,7 +358,7 @@ struct test_case {
>         const uint8_t emu_type;
>         const char *title;
>         const uint16_t step_num;
> -       const struct step const *step;
> +       const struct step *step;
>  };
>
>  /* Get, remove test cases API */
> --
> 1.9.3

Patches 1 and 2 pushed, patch 3 will be redesigned.


-- 
Luiz Augusto von Dentz
