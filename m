Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F7EEB3
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119039; cv=pass; b=OA8euaNSYaM29udRRKLPIWr1dPZFqGM2BeGNlOJ+R/cMHzQ/R0PU6s+hbHSW2wlLZ1C+mnRrX+nGkT0i7gg64ukjpKc8Kc25QWORchpviBrXtzowlZ8lb15vZWAGxyZFVG87wHzzqfnUJYyeS2DKx/UMryDRRk7sgX/tIR9GIO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119039; c=relaxed/simple;
	bh=NQA8YVZnlds1ifHX0qqPVji4GQH1Vg6SYAr2c3mzlVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urxND8YgaOZQWoqgM2hUEp8VRnrZNy+OCHDyj5anDVo6awsaPrj9H1JOzMGYPfja3Yz+Vam35sgy6UKMlrpHkeHGGbWctJXmMZKUpeNKD1Al5hVrMRd86JU0rPQaMoQWT5Y7JHkW9kaoWmspDLkwM1XoD8oOolq7EwyZ/ktXvGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoNjv5bv; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoNjv5bv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e8fa1b8d6so49225957b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786119036; cv=none;
        d=google.com; s=arc-20260327;
        b=gva5wC5us02QAHzqK1cBPdfR86UiraSY+BbTAWQPPWO/bGniduoU/2sFemwnwC20bn
         /w4vwQpsqC9INmHk7iIIJTYy2FJbhftKJWaOrXkUltDYin+PwFne6EKC6kr8SkpuelQI
         aE3oEE3/KDwWbgV2lLhcRuiqZEL9veqiDb2DIg1vUW3Lz6e95wu0JQZMwxA/QkYX97wz
         lyRWtwrxbn9qLuuP4HjmjgJOg9NjM5U/W5IpgPswVypmrMVX6qV4KRLjTWYor+xDYaHC
         zQ8PnYCCQUcv0wUptg+5XKrnktr1Ihl7zc/zxHgCjkwp6QrDLvGj7vjLAHnPk0KXqRZ/
         Ut3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPe2T4C9FGoAfSm2OSn/uy+LGFjAoZJob/kwp689UMw=;
        fh=ZAgl1hhsb0kgmaaT+EPkamWHSWmmRxn147ITepk9JR4=;
        b=FSIi2dbp3uE/wCyQXsxGl2ltZBe9O5t7B/RoD61E3ydL/Dbe/PQfIcguBQuQ2D3U6J
         SXaHPzRtgLE6fFP2fW6sKsg7EDxp55awFHb7J7wCpsikAuLXggC+/iCkL4DieDoweSjn
         Paymotxe+AH/3KQDIitVnzmAihfr7zl6BLeIILV9FtTCv/xJtphpsWBBP9fQFGDAhEdy
         PVw45Aqw4pG62Bu7KmCx23yRCGEUGFF2IyeZRBzGDYPcduI0V01buNdStf4I6t43nKmT
         4SOiHlbvIRsPoVjh0eyDjtQJ8256L/FQcfxuye4SjlUtxbgThAxS7ZMqZ28vdbEXxoXi
         Fnjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119036; x=1786723836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPe2T4C9FGoAfSm2OSn/uy+LGFjAoZJob/kwp689UMw=;
        b=JoNjv5bvBxLzJLoz2tFFdtF82DQWlh6Z6ew1uMAXfYM5b5JxPjhCKp5UoyDAoQg/Xa
         0/68sADKA+ieU6GdXkizgiGiOVqvDt1VVULaP79z3Kjv1bSGew2dAhM2xWd1xQJkgmTO
         kQlVMCjpdGqriOHq0aGBTj8ayYv34ay0BvS8xNgpv+6p6zsx5kvQ4BKU/KbRrTm2mX9K
         0M4y+x6SKzJ8hLMDx1r0SumtVD3DByrF+iFrmpc/djUVBBDE58JYDyuhBh5Yh+z4ftZD
         SRXbpZP+Ku3hmJBhi6gmmUSrenMZ2LIC6BqIUzY46bba4Gl9u7uQpz4QsQjcF0clEnAd
         gTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119036; x=1786723836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPe2T4C9FGoAfSm2OSn/uy+LGFjAoZJob/kwp689UMw=;
        b=WuEZCg5FYABDB6jP+hOZTb6j5isnyI9+AEPtrrLFV3Dh0UOdLP41KbNs/qoJZp3EdR
         Ejc2z9lrlKAi3at/dT5Jcp2ePev8TaJUloK6EJfM7IfkcdVOqNtYnSfLSpKdRxlo56Nb
         afc1oh1QL6pvP0DFbmBNxxEo3QCt1TD5qBczvgk2jN879SMomwcerwpi2cr+j373lZmh
         OjmMKBg9wHeHAtW+pd38k/uHcd/IpRwHQzBzcAysLHXYGlUk6eVoB637L1MC1lWZ0AY8
         kcWxqy8puCWhWGV0j6ykxLpcuF+aADJhT2KVJZYDfJooiqjq3oJjGIY6D3wibqmydDZ7
         eX9w==
X-Forwarded-Encrypted: i=1; AHgh+RpHkrWXvMRp+6acGMSUD/HxPSrUxGyGEUKHO3k362vh9wSb4QA0TTlEg2cTe8Ki7G1e+ZGNocM1QhD1QFzPW4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBt8sKaR9RN4LJh6K2WpDJb61O1+ZZi6hzBEa0/q/ZEf43ZDR
	XQlW/tbxHZoaQGp9ABcxke40LYWYduvMNQloojJcc03anqpxLnW1s+EqP7y1bkHq67i5GP1b/t/
	5oFUtivpI8mrbpMxEdJ0LD7JbUobYZ1Y=
X-Gm-Gg: AR+sD11nCweKCg3HS4OX6D7vQpxAVEVPHJ29orTYQEBixxAN6rM5/csUQInbuAdyutd
	bB87JpLw7LLswcBsuKjrx6NY/y9Ew3gbRDkJ+akgkUKOIatWYbso9BUIys0un5R24F0YR9EkOXL
	TiyK0MzqBl0/IKQBmCaVAIhp0s2KtOcFLD8kyVh0DTLByGmKoJ3d5I3fPhrJ/cekUA4mb3dJAok
	8tMitH0e6zZLKLYS1zbWaA00LGJMUDMUKXMNSoBcjj3qznYBhgVmhjFfJt4IiI5Qnn/DhR3dY1M
	YBUpbxToIvCtzR0UiD13FAAunQTy40toCU48VmS+Vh4vsqCV5WnOSgxOLKlaOyg2c56VPNopVW1
	mGgGAFD1EEQA025iXAsy7F4zZiL1WrvY=
X-Received: by 2002:a05:690c:6512:b0:81e:deab:43af with SMTP id
 00721157ae682-8201f0c1456mr166289867b3.4.1786119035967; Fri, 07 Aug 2026
 09:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FD5D03449312D17C+20260806-btmtksdio-deadlock-fix-v1-1-3a2d4392d117@uniontech.com>
In-Reply-To: <FD5D03449312D17C+20260806-btmtksdio-deadlock-fix-v1-1-3a2d4392d117@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Aug 2026 12:10:23 -0400
X-Gm-Features: AUfX_mwnlvEBqaHq9pVkwxhN2lM7dsClJAMMw8cY-68R6f3NS5GmuPRzCsMKyAE
Message-ID: <CABBYNZK1VKSthhfEi_BRJSX90W_c3sAqCSdsFm3Z6wXYDcWaVA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix deadlock in close and reset paths
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ZhaoJinming,

On Thu, Aug 6, 2026 at 2:36=E2=80=AFAM ZhaoJinming <zhaojinming@uniontech.c=
om> wrote:
>
> btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
> bdev->txrx_work while holding the sdio host lock, which is also acquired
> by btmtksdio_txrx_work().  If txrx_work is queued when close/reset runs,
> a worker thread may start it after the host lock is taken and block in
> sdio_claim_host(), while cancel_work_sync() waits for the work to
> finish.  The host lock is only released after cancel_work_sync()
> returns, so both sides wait forever, deadlocking close/reset.
>
> Fix this by releasing the sdio host lock before calling
> cancel_work_sync(), then re-acquiring it afterwards.  The interrupt is
> already disabled (sdio_release_irq() in close, C_INT_EN_CLR in reset)
> before the work is cancelled, so no new work can be scheduled and
> cancel_work_sync() fully quiesces txrx_work before the device is torn
> down.  This mirrors the pattern already used by btmtksdio_flush(),
> which cancels the work without holding the host lock.
>
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
> btmtksdio_close() and btmtksdio_reset() call cancel_work_sync() on
> bdev->txrx_work while holding the sdio host lock that
> btmtksdio_txrx_work() also acquires. If txrx_work is queued at that
> point, a worker thread can start it and block in sdio_claim_host(),
> while cancel_work_sync() waits for the work to finish and the host lock
> is only released afterwards - a deadlock.
>
> This series releases the host lock around cancel_work_sync() so the work
> can always complete, mirroring the pattern already used by
> btmtksdio_flush().
> ---
>
> ---
>  drivers/bluetooth/btmtksdio.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index c6f80c419e901e71b21e550449250a5a6755d100..879d580226d25ad398105a158=
de1545dace33718 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -746,8 +746,16 @@ static int btmtksdio_close(struct hci_dev *hdev)
>
>         sdio_release_irq(bdev->func);
>
> +       /* No new work can be scheduled after sdio_release_irq(), so canc=
el the
> +        * work outside the sdio host lock. btmtksdio_txrx_work() also cl=
aims
> +        * the host, so canceling it while holding the lock would deadloc=
k.
> +        */
> +       sdio_release_host(bdev->func);
> +
>         cancel_work_sync(&bdev->txrx_work);
>
> +       sdio_claim_host(bdev->func);
> +
>         btmtksdio_fw_pmctrl(bdev);
>
>         clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
> @@ -1293,8 +1301,18 @@ static void btmtksdio_reset(struct hci_dev *hdev)
>
>         sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
>         skb_queue_purge(&bdev->txq);
> +
> +       /* With the interrupt disabled, the SDIO IRQ handler can no longe=
r
> +        * schedule txrx_work. Cancel the work outside the sdio host lock=
;
> +        * btmtksdio_txrx_work() also claims the host, so canceling it wh=
ile
> +        * holding the lock would deadlock.
> +        */
> +       sdio_release_host(bdev->func);
> +
>         cancel_work_sync(&bdev->txrx_work);
>
> +       sdio_claim_host(bdev->func);
> +
>         gpiod_set_value_cansleep(bdev->reset, 1);
>         msleep(100);
>         gpiod_set_value_cansleep(bdev->reset, 0);
>
> ---
> base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
> change-id: 20260806-btmtksdio-deadlock-fix-f9421f1a7879
>
> Best regards,
> --
> ZhaoJinming <zhaojinming@uniontech.com>

Sashiko found a problem:

https://sashiko.dev/#/patchset/FD5D03449312D17C%2B20260806-btmtksdio-deadlo=
ck-fix-v1-1-3a2d4392d117%40uniontech.com

--=20
Luiz Augusto von Dentz
