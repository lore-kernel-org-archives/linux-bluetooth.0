Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C73DE422
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843588; cv=pass; b=iZ3Az6YOWkHXQR6G9KKB9pajRbAWCirByFu3W1kx2WC39h3SrajqqbzgH88hbEy3BYuGLZIFH7AV4WnLswOuYe03LbVDVrLxn5zdHUo7rn86KGRMgAV3sNZu7cRdjnHin+JubbBRyBtDzEqe+CfTGzTS4mZlCUPR3sfTYvzjHI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843588; c=relaxed/simple;
	bh=XOwwrLgZFOGGmskpUaWz6HVn/KWe0h0lAqT7NstjqDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WH2qUCkJIyreRGFwOOFy/pqcVq+bjuz+Rugwo+SQuJHR1Vnv9/Z3ra/Frgr22A8bh9HC539XWIfBwRGwiNhmCywoXpRdaHaAUkaXusVCkqK3wBVX6UZzvkApCF1EUz12IWsYWSKfjG3sT/SgpOXTHn4iNH3VGpEL1FOy2IuAUHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBH2Hy6A; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBH2Hy6A"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9ecd7216cso708776a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843585; cv=none;
        d=google.com; s=arc-20260327;
        b=iOkIdB3xAaXlpxXyCxZ4u5n1kBxn2p/29ambBonkBH7eTTUMjx6SvIqRQdosNwQrzc
         a/4v/huZA+vQIB0Dl/D8RT1Kb8xoSv7s/AJMWZbL7hIEVBTwy1p8lLDUKlYpJ03Yjehf
         WYDL7l7n2QlzaUKtE+7gkgwjP/14A7/uCVfe5ss633U/FUHJVUlJmIETSR9+z0xM2N+1
         jIVgq+d8TPhoOuNAW2haWhWH9Y7pFCREy1SbzAjSXgpVL1vhlx3Aifk3CII4KASfPxpH
         RohemWOL8rt9PuAXfSlPxYMuw4ya4rE4yQRkyWHK1JsLdMqW9xkn4FER/Xx5wFaEZOHP
         A/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oE54+rx3E28RNN81m89+aO2BvQkOWgie8l/8oIwgbIY=;
        fh=OFYYGJVLlnUb6P+Jg5KM4KJKQwAospMSJBnnBul51zM=;
        b=UAxHscbGwPMx951NBIGupE/gKRV3/GJRX5isVTOti354YnIU8SHEJvdD5Rj4tQnlRz
         TW8cQ0s20yNZ2bYjJfNXOaRVoLKcmv5HJEXYLT9ZB3drGFt5ulQqQqcdk5/ibhkmrLQ/
         g6WL3UL0kE7HPWLIANqesBNywp5B9rxQK/2sdSfG3kV0Z1XSVprpZCqfuf6TABZboB7Q
         zCtApWny29W/yEoB//C75JCov8qvm/0o/EQSwgV0NwhI83Xm5UxZ1nuyLCgpqdg/jQaR
         ceO1tQviq3Sn4Ve2L6Bfa584X8Nz1L4knUtPVpc70jXaiFubr3NZYpPbvHBQ/IiZcahQ
         yQ4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843585; x=1783448385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE54+rx3E28RNN81m89+aO2BvQkOWgie8l/8oIwgbIY=;
        b=dBH2Hy6AUAUFZaO1kupzlsHKmB2NFD/MC2ciu94QZ0hKHZwy8wKPbLbBWyjHeAarhe
         myK5zG2hr9h2SaReNU9iVd85sLtkEIvaKyDmezMvAzkxiN29uLRLPmH8V6m0Np5AUbY9
         yu8LFde1J/oz+mnwcByWZdylWik+Qnf0FS/CcnrfV4vbxY3CvX5CheVa3RZ1WUECrSdX
         TgMn8G02QHuIYPM3qf3nQeStmsLb4D78x1xavmlBozObv7ss72LV6tQ+ht9pV2UllxNM
         mGwI0YrrNzXfSTeOlYE0evxHUkHOEEi9axWYAQVKREAe3F0vnKwj879Pu8U8BjSzKNsx
         93hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843585; x=1783448385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oE54+rx3E28RNN81m89+aO2BvQkOWgie8l/8oIwgbIY=;
        b=U0sXFLF4vC9WEb+3ULf1aNWoOLMdQW1tVSKIzAF9pwUWCNx+9/rCrJnFZ9xOpWq2UM
         FJaS/8Ttf4CU9kRT8HSqC/yWIPousAVTF0aC3Cd+uvGlvrZGBd2bkgS1WmEkJ0Otgbhd
         f/aoTL8LVA7KI9aBsMYsehAHhAHnk18AfUyI49gldA+QZzRBU2kGKiIRe0ZCpuSRT6tE
         ueFOSU+kJxeSMrCwYqhNfngTdfYeyEQOGxVOKEQZdEdzcyXzpuNKOcBwb7cUssMn/oGg
         pFc2Lrlay4Uc3CA3P/mXBlIz12uxLh2ikll6pHySAMoJFKkUbkdAJkUDBSHkWxh10mVF
         3Lkw==
X-Forwarded-Encrypted: i=1; AFNElJ+EwmrfNPM9kucYEosoM1uuplcflYvZ8cs/4xJHRna2evgRo7YgBsOrPtsOcz+nEgfi1EjJN/lqCQqWl3xJQZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziN739Mahk+v+CNc/sEDl8Vq3RUrrCY3p/BUjYeXDVwkl37uGW
	euIUlpmubaXiEjAxl5PNcuGRN6ceOwnaoj6tkeTcN1ByycePma+NGPiVXbY9fpmmLJHfDuJNHn+
	RrBOpOFRoOODvH8zHC4kiIcu9EGWkoVO7/rI5AVDUVQ==
X-Gm-Gg: AfdE7cmo/sRJtOheC2kDLJsI7xVcqistfkiKxBmqWduMCIc10Z/ZQvuKVFWhAXiOnZR
	2HOfbhvVP4nSVqIRNA5O9QBeW89WA35T/ne1ifTy+r6JlhuwDfVxaC7zgJMvdPBdZsTvIUJBN1T
	/Nnl3+NRfM7VDF/4EcbyrtXRRQ3lE1LKcz+C9HHatmtXgpIBsLlSyNr11Gx1dP/M26qhAIFQh9Y
	q/X346nOOFs+oeInjBW5zdiGxnHtZJtsCyi+50mxUiPDn4Hrss99cArrkKOnmexUSOsyLJ0FTv7
	oGMsAgiwSPtbSSTkZcLRcByCKHUL2YLUqyNDBkh8SNFrAQQrB51oHd56
X-Received: by 2002:a05:6808:8957:b0:489:6bf3:2d54 with SMTP id
 5614622812f47-495eafc3fd5mr3895556b6e.37.1782843585139; Tue, 30 Jun 2026
 11:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630123539.668776-1-chris.lu@mediatek.com> <20260630123539.668776-2-chris.lu@mediatek.com>
In-Reply-To: <20260630123539.668776-2-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Jun 2026 14:19:33 -0400
X-Gm-Features: AVVi8CckfBlQXS-AvJ4P_5PwELwNv10OM6MlJ2Jz8lbFBi_--zDr5zCfTIMBNcY
Message-ID: <CABBYNZLho7-McDKpFC+AtotGyy7S=SXP-mT30MWBQ8p44oB-1g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Bluetooth: btmtk: Replace magic numbers with WMT
 packet flag enum
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Jun 30, 2026 at 8:35=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> Add BTMTK_WMT_PKT_* enum to represent WMT download packet sequence flags,
> improving code readability. Replace magic numbers (1, 2, 3) in
> btmtk_setup_firmware_79xx() with descriptive enum values:
>
> - BTMTK_WMT_PKT_START (1): First packet of a sequence
> - BTMTK_WMT_PKT_CONTINUE (2): Continuation packet
> - BTMTK_WMT_PKT_END (3): Final packet of a sequence
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/bluetooth/btmtk.c | 6 +++---
>  drivers/bluetooth/btmtk.h | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..21c08ee1cdbf 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -230,12 +230,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev,=
 const char *fwname,
>                         while (dl_size > 0) {
>                                 dlen =3D min_t(int, 250, dl_size);
>                                 if (first_block =3D=3D 1) {
> -                                       flag =3D 1;
> +                                       flag =3D BTMTK_WMT_PKT_START;
>                                         first_block =3D 0;
>                                 } else if (dl_size - dlen <=3D 0) {
> -                                       flag =3D 3;
> +                                       flag =3D BTMTK_WMT_PKT_END;
>                                 } else {
> -                                       flag =3D 2;
> +                                       flag =3D BTMTK_WMT_PKT_CONTINUE;
>                                 }
>
>                                 wmt_params.flag =3D flag;
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..51c18dde0a80 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -66,6 +66,12 @@ enum {
>         BTMTK_WMT_ON_PROGRESS,
>  };
>
> +enum {
> +       BTMTK_WMT_PKT_START =3D 1,
> +       BTMTK_WMT_PKT_CONTINUE =3D 2,
> +       BTMTK_WMT_PKT_END =3D 3,
> +};
> +
>  struct btmtk_wmt_hdr {
>         u8      dir;
>         u8      op;
> --
> 2.45.2

sashiko has quite a few comments for these changes:

https://sashiko.dev/#/patchset/20260630123539.668776-1-chris.lu%40mediatek.=
com

--=20
Luiz Augusto von Dentz
