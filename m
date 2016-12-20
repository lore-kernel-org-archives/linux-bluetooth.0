Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161220141039.5981-1-luiz.dentz@gmail.com>
References: <20161220141039.5981-1-luiz.dentz@gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 20 Dec 2016 16:29:34 +0100
Message-ID: <CAAEJBhKDx3p60aW9HrDUZJmOkURxGg_JJhqwv0ggNBCX0+KeDA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/test-runner: Add Bluetooth config options
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 20 December 2016 at 15:10, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> List the build options for Bluetooth necessary to run testers.
> ---
>  doc/test-runner.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/doc/test-runner.txt b/doc/test-runner.txt
> index 72e17ce..5ed5af9 100644
> --- a/doc/test-runner.txt
> +++ b/doc/test-runner.txt
> @@ -32,6 +32,23 @@ minimal options for a successful boot.
>         CONFIG_DEVTMPFS=y
>         CONFIG_DEBUG_FS=y
>
> +For Bluetooth functionality:
> +
> +       CONFIG_BT=y
> +       CONFIG_BT_BREDR=y
> +       CONFIG_BT_RFCOMM=y
> +       CONFIG_BT_LE=y

I'd add other options (BNEP, HIDP etc) too.
AFAIR those are needed by other testers eg android-tester and bnep-tester.

> +
> +       CONFIG_BT_HCIVHCI=y
> +
> +       CONFIG_CRYPTO_CMAC=y
> +       CONFIG_CRYPTO_USER_API=y
> +       CONFIG_CRYPTO_USER_API_HASH=y
> +       CONFIG_CRYPTO_USER_API_SKCIPHER=y
> +
> +       CONFIG_UNIX=y
> +
> +
>  These options should be installed as .config in the kernel source directory
>  followed by this command.
>
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
pozdrawiam
Szymon K. Janc
