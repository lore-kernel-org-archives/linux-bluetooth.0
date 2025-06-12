Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F560770FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734173; cv=none; b=cIlaAu4EXvG7aBKcLrmoXGuy1cfRvK6kNSekQgWKqkyuUF27JXZdWxsuQmaJA0cW5yVkfEdQNpUKBeAPuZjBgYTTosPKc8xuUS1LmpJP41TND/6AncyyRFTLib7qphKEBVolaQRhD0xcaHNlxcPZz6TslIzKbLCGTm8ht4p1i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734173; c=relaxed/simple;
	bh=jcA17agKRkTnu6605Q4CJ/hUSsAizO8+BLJ8KnX23po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHDt+h5HSbmZKG39GChlresM/iGAg0BnHMY/qsiKmIMKwY4ejvlmXiHif4WgD0pcLL+wdENquruTU3tMPPJcKY28Bn0/Ek1nATtck1VqVfaUY2KTJZ+HAC0b+kkKfQsqa6Oees99mLbJ8L8cUkYHHkEZ9eXHlHzgJe5KTG8z8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSwlGRa/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSwlGRa/"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32ae3e94e57so8808641fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749734170; x=1750338970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ai5g1RdRxrS95GSsMUyGOb32v4kzD7ueihESqrkbmY=;
        b=OSwlGRa/4IcYuUPHRRgNOv0XBLSjIaBi6p+V7WP1HUo3AMftTYzsWO/Hv6fGIwU2z1
         E8Mow6z9P7+VZIa/SsIelUy+E2kmgxz2Z7Cx4hKLV+wR8zv0YqolNYOK6/1fe0w0GuVz
         ffz0GJiyshkxExLe0WD0/sJmiiqYqMW9B+ITLdIUjdHiRhbqDH86yZ8LAgnN66ZzTkzv
         k8MCnwnH+cK3Rme0x3rOmutqqFHIc+NYfJeVq0J8mDGp5XsU0KUyPq6n72aeu6sQOdRb
         rpXqZrXyidXvnQ856lmskxOs5HlyiB4Cuh4wVTHuBMZR9tGDwFx8EmhEIQKch+Xl0W6a
         OOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734170; x=1750338970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ai5g1RdRxrS95GSsMUyGOb32v4kzD7ueihESqrkbmY=;
        b=RTi/KQ4Yx07R4SfqcT8ocLxZhLCh0x89qAg6vXQUJXXxCx/pRfuCqOs0FklCzbCj90
         a0yhlLWgs+4gX+yxI9iSzY8gjHedLfJ/1P/oWlSzh2N+vg+EXsNybaJl5tAAMOhsFntu
         Ctwu8w8mQa/b5RL6GrKnCPxzemhMDQBkuIOJcIilQCJ72CyPPteP4dhstLdwUKxsOeIM
         AMrVSqGeS3p+o+Bd+aFQri2FgR0U4DZrN3cNpbobHY9bfq8ga0W7NQmyrdiFGvEVXd2W
         g9FUmByZD7Z+/d9e9MNiTJWkBXPpJXTjieDZVZOuFtX7nJaKc+KBRhTrB3bLqNobIV5v
         BZLg==
X-Gm-Message-State: AOJu0YyrdGR8bGWpe9D1BoHgvfECNXtyjs95CMKE9OSJP4Ty3EsADIu5
	njQ70jq8nNwpx4oLB/0WjboOd4XdAUzEL+nPhfWO5gC2SFxzC4cBcAycOGbHuwVg3GQ8Kl6tZ8U
	o37JuG2kDOP608LurW4L1NMtrsjU4HEp/Tw33BJY=
X-Gm-Gg: ASbGncvlmzKQjzM+OWhq1Zz7VttYQbE6q+mMj5XmGrHFUz4YrT/Q5bxhnWcGc4Y/dXU
	+Pd1+yf9oKME3f2Yt5ttKyaEJaWVbZMDMD5q0CnPB2mWSjjT4kpOMge2VE17unZXoXzZMadcxHP
	kJnptY2h7WBFuhKrGfuit31FpsG7XZ6erduXhrbmZ6oKWvlx7l2+iR
X-Google-Smtp-Source: AGHT+IG4ZV8Uw29jmi5+2hsLWhoSBZO/A1kf1ugf8fTTVW3LqTMx/h9U4HI+LmLOhZ7WCjsm01QD8aJvMTCdEkbc99c=
X-Received: by 2002:a2e:b88e:0:b0:32a:8ae2:a8c8 with SMTP id
 38308e7fff4ca-32b3a732e5bmr4053261fa.2.1749734169900; Thu, 12 Jun 2025
 06:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609105553.3756688-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250609105553.3756688-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jun 2025 09:15:57 -0400
X-Gm-Features: AX0GCFvhY6zn6Q0sYvnAw29DPBk01RPrtUWT5yncZoosZNi23Vra0FnDlOZNwWQ
Message-ID: <CABBYNZLVB5QC_EeLC=j8sZkSdQQTNxGuAt23EavHB3LPJuH1gw@mail.gmail.com>
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is
 pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Mon, Jun 9, 2025 at 6:57=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
>
> If the SoC always enables the bt_en pin via hardware and the driver
> cannot control the bt_en pin of the SoC chip, then during SSR,
> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> This leads to a reset command timeout failure.
>
> To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
> after the coredump collection is complete.
> Also, add msleep delay to wait for controller to complete SSR.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a2dc39c00..1c3df6e30 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,22 @@ static void qca_hw_error(struct hci_dev *hdev, u8 =
code)
>         }
>
>         clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
> +
> +       /*If the SoC always enables the bt_en pin via hardware and the dr=
iver
> +       * cannot control the bt_en pin of the SoC chip, then during SSR,
> +       * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be clear=
ed.
> +       * This leads to a reset command timeout failure.
> +       *
> +       * To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED b=
its
> +       * after the coredump collection is complete.
> +       * Also, add msleep delay to wait for controller to complete SSR.
> +       */
> +       if(!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +               clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +               clear_bit(QCA_IBS_DISABLED,&qca->flags);
> +               qca->tx_ibs_state =3D HCI_IBS_TX_AWAKE;
> +               msleep(50);
> +       }
>  }

WARNING: Block comments should align the * on each line
#11: FILE: drivers/bluetooth/hci_qca.c:1658:
+    /*If the SoC always enables the bt_en pin via hardware and the driver
+    * cannot control the bt_en pin of the SoC chip, then during SSR,

ERROR: space required before the open parenthesis '('
#19: FILE: drivers/bluetooth/hci_qca.c:1666:
+    if(!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

ERROR: space required after that ',' (ctx:VxO)
#21: FILE: drivers/bluetooth/hci_qca.c:1668:
+        clear_bit(QCA_IBS_DISABLED,&qca->flags);
                                   ^

ERROR: space required before that '&' (ctx:OxV)
#21: FILE: drivers/bluetooth/hci_qca.c:1668:
+        clear_bit(QCA_IBS_DISABLED,&qca->flags);
                                    ^


>  static void qca_reset(struct hci_dev *hdev)
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
