Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429691997-6469-1-git-send-email-luiz.dentz@gmail.com>
References: <1429691997-6469-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2015 14:12:41 -0700
Message-ID: <CAHrH25RSkbd5D4gGppKgWp_VK4Ped1mZLHYvVdHQbZbSBhsJow@mail.gmail.com>
Subject: Re: [PATCH BlueZ] unit/test-gdbus-client: Fix hanging if D-Bus fails
 to launch
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Wed, Apr 22, 2015 at 1:39 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case D-Bus fails to launch make the test fails so it does not hang
> other tests.
> ---
>  unit/test-gdbus-client.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
> index 5a4b974..7e16d16 100644
> --- a/unit/test-gdbus-client.c
> +++ b/unit/test-gdbus-client.c
> @@ -72,6 +72,7 @@ static struct context *create_context(void)
>                 }
>
>                 g_free(context);
> +               tester_test_failed();
>                 return NULL;
>         }
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Verified and pushed.

Thanks,
Arman
