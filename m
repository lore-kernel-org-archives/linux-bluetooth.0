Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CF469D
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433021; cv=none; b=K0WIott8RcxR594wlvEfJlKzghY9onPvijceiCdc8ssz+e2lNQ2TQ8ooU5RdlqjDvPcZg89NyNi08PzNWV6h5E61Avbx5YDWFylVBY8bnp80ybn18ep1PSD1JkVRB4jSDKdJlJJ/Ee07KHXvgvhgauVtDh1UEUpmcCWy/PkKaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433021; c=relaxed/simple;
	bh=kUeKDWJ9oMycKQY4wf0hFNpRJ3TyFGreBWVYtPVOQl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKQq+BenG2aFBAeX3Hz/EXbh9tPc/X+0ReU0tNCVy5Ug8nJn6/azWOB0XfVnRaq4Y/rfAYcEIa8ZGGnzi1vXB/GYPQj/MNLS1rHlbM9PioRl68I2xSg0g+Ij1/aGwQIstjdEodkDbvFVcqcdMaNf66oObcx1Yvpbe6F3kyTXrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D16l8Ma1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D16l8Ma1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-546267ed92fso5686997e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740433018; x=1741037818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rY5A1A2dEJikvyf8MoQ+QccOnioEm8nENtXzHRklW4=;
        b=D16l8Ma105OJvgUsTrgYTXO50cwcSyHKfQQ2c5H46IyakmVA4dCtlV0qkGvxGmzu4y
         mF3jV9C1Y/CFuBx/j12V6rc46XYN9HHkractAouJXYu7uHJn918Ilu2NJ3FM+bqwuXXs
         y0BgMeIVfdPNftTjkp+U2LAhHIV0qQ3eXj89kD1xmUGxOgkeWPPMGhIZIhy77isln8Zy
         DSPZZlREtO2I/41ZA0XCcAIxA4qmUrZx40Fm4fGXXx+jxK43rWpmtgB6tbsAkmGyMNrB
         X6XhH7KD3gHLuCXOKs+Ayo2XsDdIkjjqC4Xfq6UEu91zn0a1d+gNLNUUC2DmMUF9FYr+
         E5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433018; x=1741037818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rY5A1A2dEJikvyf8MoQ+QccOnioEm8nENtXzHRklW4=;
        b=GpEhyceAIe+/F9tnGeE/iQwra/MKCS4S9XeFJcv3RndAaWeIsDP1PNmPGjJhFAev17
         mAsuuxwTkTkkrAPHzal3l5Ggx5h8zCckoUrory63NVvz8hyLzKtJIDA9x8SAm/iiLg3q
         gcOcqGrFJdUHFbNAw9gKaduh3vjmVUtr9wBtuTknOj6qRx34PklZGaYlyKvB5FTw/tDs
         /Rypgwg7+6GZAdTRNxKskTuvVc5nG92pO+BQAFTR5EwXrXkREj0vJ4qXsz6qrqLxzNUq
         TizipEl/wV3AYQDmy+qkY56VvO+KSSooL9O7jVvh4/BicNQWJOtf0s4EXsc0uIBQ7jln
         PeNA==
X-Gm-Message-State: AOJu0Yxoj1bbb1xgTfPIZbEBjbJ7r4RWVTBQv+j24rLBIN6woY9HCdBu
	iYht6aL/S0XvsSUt/2k4s6KRF6PYkp03bbHrDh43mES+upLMrIjo2PIjJ5wRRCSrZ6w/DmTplWs
	keFOKHJnvWKxxS0ZkpKhRb60EMzo=
X-Gm-Gg: ASbGncvWb5+aD6KhKN21gGNu2zNoTGp0dmCdEkhd0M8nJ2d2iSzb6yP/0lOU659cQ8M
	7sjx5NRL0ZQr7l9bv0uXh6bmmQ/QhRI/EVQzgnAdFJvnaYTL2FBfhR5Y1eylwRXm81+4xHqYkF3
	cETIKSsA==
X-Google-Smtp-Source: AGHT+IFiQcbY9nxVol5QPhjQA28c3Gse9XV9RoJ8ozXWJlLhP3yN1K0HsZyhaa32X1+yiErjlx8KZFz968D4A1MWm0A=
X-Received: by 2002:a05:6512:3988:b0:545:58e:e543 with SMTP id
 2adb3069b0e04-548510cfb50mr160651e87.21.1740433017851; Mon, 24 Feb 2025
 13:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com> <20250224205439.18672-2-nishiyama.pedro@gmail.com>
In-Reply-To: <20250224205439.18672-2-nishiyama.pedro@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Feb 2025 16:36:45 -0500
X-Gm-Features: AWEUYZlWm2stbkUfiX8z2-5FnRE5pf_7U1r9CKa1mSpH6fzYskm5ARVU2AsPCrQ
Message-ID: <CABBYNZKLPh48LqZjYboJ=6wEvRvdaEqu7Aykb5a_ONF1t0GCOw@mail.gmail.com>
Subject: Re: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Mon, Feb 24, 2025 at 3:54=E2=80=AFPM Pedro Nishiyama
<nishiyama.pedro@gmail.com> wrote:
>
> This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.
>
> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> ---
>  include/net/bluetooth/hci.h | 16 ++++++++++++++++
>  net/bluetooth/hci_sync.c    |  6 ++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d809f..b99818df8ee7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -354,6 +354,22 @@ enum {
>          * during the hdev->setup vendor callback.
>          */
>         HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
> +
> +       /* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command =
is
> +        * skipped. This is required for a subset of the CSR controller c=
lones
> +        * which erroneously claim to support it.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_READ_VOICE_SETTING,

Lets split this in 2 parts, one for voice setting and another for page
scan type.

> +       /* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command=
 is
> +        * skipped. This is required for a subset of the CSR controller c=
lones
> +        * which erroneously claim to support it.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
>  };
>
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index dd770ef5ec36..e76012956020 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_dev =
*hdev)
>  /* Read Voice Setting */
>  static int hci_read_voice_setting_sync(struct hci_dev *hdev)
>  {
> +       if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks))
> +               return 0;

While at it I'd add the checking for the bit as well, that said
perhaps we need to disable SCO link if voice settings cannot be read,
is the controller able to create SCO connections?

>         return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
>                                      0, NULL, HCI_CMD_TIMEOUT);
>  }
> @@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struct hci_=
dev *hdev)
>         if (!(hdev->commands[13] & 0x01))
>                 return 0;
>
> +       if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks)=
)
> +               return 0;
> +
>         return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
>                                      0, NULL, HCI_CMD_TIMEOUT);
>  }
> --
> 2.48.1
>


--=20
Luiz Augusto von Dentz
