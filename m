Return-Path: <groeck@google.com>
MIME-Version: 1.0
In-Reply-To: <1490878364-2735-2-git-send-email-huxm@marvell.com>
References: <1490878364-2735-1-git-send-email-huxm@marvell.com> <1490878364-2735-2-git-send-email-huxm@marvell.com>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 30 Mar 2017 05:57:50 -0700
Message-ID: <CABXOdTeG0G0Fjww49U0fbyPzpo9czP21YoTdUwyQ+ar4A756cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: remove unnecessary wakeup
 interrupt number sanity check
To: Xinming Hu <huxm@marvell.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>,
	Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 30, 2017 at 5:52 AM, Xinming Hu <huxm@marvell.com> wrote:
> Sanity check of interrupt number in interrupt handler is unnecessary and
> confusion, remove it.
>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>

Do you possibly mean "Reported-by:" ?

> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 6166888..7a26961 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -62,12 +62,9 @@ static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
>  {
>         struct btmrvl_plt_wake_cfg *cfg = priv;
>
> -       if (cfg->irq_bt >= 0) {
> -               pr_info("%s: wake by bt", __func__);
> -               cfg->wake_by_bt = true;
> -               disable_irq_nosync(irq);
> -       }
> -
> +       pr_info("%s: wake by bt", __func__);
> +       cfg->wake_by_bt = true;
> +       disable_irq_nosync(irq);
>         return IRQ_HANDLED;
>  }
>
> --
> 1.8.1.4
>
