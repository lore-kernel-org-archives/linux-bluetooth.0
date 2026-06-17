Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D019DF55
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657807; cv=none; b=RmIzBs74a/5J+7WokuBCejAFOv+t230vmdMtz/14uqGNU4Bgl/Q1lfkprtf/LANDp2sPI6C+mBqNndkX1XUwLU96gIN5U8xOra03tMuMp440AcjKxn3bP8hGWmDGXdp+e4BORN8lzEwWmwq1yblHBFew3vtdWP7lPubnDl6p6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657807; c=relaxed/simple;
	bh=p8L07ppQ2fG1grO6fPDIlT/WJJMlnGXkNH4iKG034oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdO/zMpwDAjeawSgKZ3P/J7hKVoANmkDt1pOOXcIUg/J+XPXlmG+1CdPn8l8tvcisnXrpXQ52raRrIm5lzAeAQfqvnLpUNEvp+xL6DSTTEewHob6c9M4Dkk0mdiEvrlxMGWVb5CiO873I9jEaBBPfvNZDpSiR0XU0g8LMg3PV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjK2uID/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjK2uID/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00691F00AC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781657804;
	bh=LrsbCJurtBL+CteEOzn5l5Hh4zAzpSug07wS9GG8znY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BjK2uID/sv/OnPsaa+R9u3+QPDHQnLdh1Ux9BFsUeoiK7FV5Eex0ZeH8abjpoRo9K
	 M+/aL/WmhwhAbzNl1cXoJjoQJq9Y+zHPrt57BJXpE6xLxuujPqBHojd0jG7lq9cjnl
	 440uoREV3sR7jQq0gkd5Tcu+Mxx0liZfcuSdeionJk4XjdMRvPwq+P+x4LsaYnDrh9
	 1y/cslLBpmxEAcG5v2Vfa+w8Amcu7KYIGLshvnroMb9u5vLhhJbJaqXUtn506mbShr
	 0S3OJLrCB+Jn02duxJiITn4GPDTuItdh/dtD35mfsfh8O4c99mToSscJVocAmtODA4
	 Py13bU3fqOYCw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3966388b388so4101421fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 17:56:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8XL0n1rWldbo0+S+hsQBxmO9FsXhFtfR10h7xuIIWPTOCLDjGw/HmojSWXvQX0zeoYSnTcspqFF7cfyIUvwhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkbk7l/7wSqDG2XRtN9g/7lYlXvwWJUpAVweZHGH6ENKSQ59sA
	9PXNJZFGQr/ScCFAAbTfcw5kt5GD6WpM2trRaaJT6jE30BuTXjenYeDsSlP4NHzeyODPTl+BIFE
	F1MMl1ilEUy+MRiYdFKWy0l/X8qa1G1k=
X-Received: by 2002:a2e:bc10:0:b0:38e:96c4:9244 with SMTP id
 38308e7fff4ca-3996a04c609mr2491451fa.9.1781657803142; Tue, 16 Jun 2026
 17:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616111224.152140-1-senozhatsky@chromium.org> <20260616111224.152140-4-senozhatsky@chromium.org>
In-Reply-To: <20260616111224.152140-4-senozhatsky@chromium.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 16 Jun 2026 19:56:31 -0500
X-Gmail-Original-Message-ID: <CAGp9LzqT4knwk9hONu43cGDr005Phs3xw6T+YexXa3X6JEBOpA@mail.gmail.com>
X-Gm-Features: AVVi8CdiIxEmti2SA6GEHnRDGJT8WXA1KiLzwBTTnsex_dP2qM2eKK-VJ13FtyE
Message-ID: <CAGp9LzqT4knwk9hONu43cGDr005Phs3xw6T+YexXa3X6JEBOpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: btmtksdio: call cancel_work_sync()
 outside of host lock scope
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 16, 2026 at 6:15=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> cancel_work_sync() should be called outside of host lock scope
> in order to avoid circular locking scenario:
>
> CPU0                                    CPU1
>                                         close()/reset()
>                                         sdio_claim_host()
> txrx_work
>   sdio_claim_host() // sleeps
>                                         cancel_work_sync() // sleeps
>
> In addition, when txrx_work() runs concurrently with close()/reset()
> it better not to re-enable interrupts by testing for BTMTKSDIO_FUNC_ENABL=
ED
> and not BTMTKSDIO_HW_RESET_ACTIVE before C_INT_EN_SET write.  However,
> btmtksdio_close() clears the BTMTKSDIO_FUNC_ENABLED too late (after
> cancel_work_sync() call).  Move BTMTKSDIO_FUNC_ENABLED bit-clear earlier
> so that txrx_work can see concurrent close().
>
> Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to wo=
rk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/bluetooth/btmtksdio.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index d8c8d2857527..207d04cc2282 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -625,7 +625,9 @@ static void btmtksdio_txrx_work(struct work_struct *w=
ork)
>         } while (int_status && time_is_after_jiffies(txrx_timeout));
>
>         /* Enable interrupt */
> -       if (bdev->func->irq_handler)
> +       if (bdev->func->irq_handler &&
> +           test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state) &&
> +           !test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
>                 sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NUL=
L);
>
>         sdio_release_host(bdev->func);
> @@ -741,6 +743,8 @@ static int btmtksdio_close(struct hci_dev *hdev)
>         if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
>                 return 0;
>
> +       clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
> +
>         sdio_claim_host(bdev->func);
>
>         /* Disable interrupt */
> @@ -748,11 +752,12 @@ static int btmtksdio_close(struct hci_dev *hdev)
>
>         sdio_release_irq(bdev->func);
>
> +       sdio_release_host(bdev->func);
>         cancel_work_sync(&bdev->txrx_work);
> +       sdio_claim_host(bdev->func);
>
>         btmtksdio_fw_pmctrl(bdev);
>
> -       clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
>         sdio_disable_func(bdev->func);
>
>         sdio_release_host(bdev->func);
> @@ -1295,7 +1300,10 @@ static void btmtksdio_reset(struct hci_dev *hdev)
>
>         sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
>         skb_queue_purge(&bdev->txq);
> +
> +       sdio_release_host(bdev->func);
>         cancel_work_sync(&bdev->txrx_work);
> +       sdio_claim_host(bdev->func);
>
>         gpiod_set_value_cansleep(bdev->reset, 1);
>         msleep(100);

The patch looks good to me. Inspired by your patch,
do you think should we add another patch to keep txrx_work out of the
reset window by rejecting TX during reset,
ignoring reset-time interrupts, and making queued workers exit early?

Some code like:

--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -567,6 +567,8 @@ static void btmtksdio_txrx_work(struct work_struct *wor=
k)
        pm_runtime_get_sync(bdev->dev);

        sdio_claim_host(bdev->func);
+       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
+               goto out;

        /* Disable interrupt */
        sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
@@ -628,6 +630,7 @@ static void btmtksdio_txrx_work(struct work_struct *wor=
k)
            !test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
                sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL)=
;

+out:
        sdio_release_host(bdev->func);

        pm_runtime_put_autosuspend(bdev->dev);
@@ -646,6 +649,9 @@ static void btmtksdio_interrupt(struct sdio_func *func)
        /* Disable interrupt */
        sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);

+       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
+               return;
+
        schedule_work(&bdev->txrx_work);
 }

@@ -1250,6 +1256,9 @@ static int btmtksdio_send_frame(struct hci_dev
*hdev, struct sk_buff *skb)
 {
        struct btmtksdio_dev *bdev =3D hci_get_drvdata(hdev);

+       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
+               return -EBUSY;
+
        switch (hci_skb_pkt_type(skb)) {
        case HCI_COMMAND_PKT:
                hdev->stat.cmd_tx++;

> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>
