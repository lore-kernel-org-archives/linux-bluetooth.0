Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D025B30E
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583123; cv=none; b=TdqZOylxl4vot7unpJXEDHKu4ZMP91K1sLM3bDcVpSj9+elCd4YmbPO/56vHqdH0HhcDGr3znOqw29hIycpheaNy/m/tFBwBskNNLiH5A3UcmRxT7Qf/8cVR8jlcKJPJHvz1cmjuuYTbcECsy9usqvjd18blp4JWXkZ2bS7qFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583123; c=relaxed/simple;
	bh=7PJY2YeK76dAsBL/bmEK/vTit7wq7QtmkqkNx7ZXhRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK8LIildDKU2wWt7Rl6LIGtbRbGKAi+IpQBN2cE4p8NhKE3G4LTIF8Envgxf/PvizPFTEjcxr13W4gs4sUcgus+IdVRHNtk/sheuTwJW3jW4+RwCrQcP9uPBz/BX90ktxUHu/OhTWeJAfg5TtuxB+9TDxVmNaYcT/ktW0kzANMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HFRGEl1f; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HFRGEl1f"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f76454f69so120619e87.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756583119; x=1757187919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gssC/gz3u630Wq65SUJR5i/WL9rKPFdkF3tJgt+Pb8M=;
        b=HFRGEl1fv20JAHqcug/lQDIgy26HzpkA+kBe6X1rogZ1Il/iGW7SvkUBbQpaDy9xs+
         aU4iV2q5skHjHb27XRI8nGtgJv+uW/sg99SMHlWeyc49lCTEymyTiBH33Edwn9kVskgY
         gt+iYg3JcRXTKoMGSTjKpUWxnI82NNYAKybCOr65Qpd+mbQTT7kn77DlaZk+yb4vEl3k
         rGFm/NNN8FM+OKnXcqZdOVSW2o1Uddrj+F5QANdXholQYLTnwroJtXs/lH+3m25M1Otp
         0uGYNO/WMwwOTvbWFkGn7AW9A7Lw5jgrK6xyf4l58yFup5lSqvqdOkFpDdeFFFiMWWYk
         miGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583119; x=1757187919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gssC/gz3u630Wq65SUJR5i/WL9rKPFdkF3tJgt+Pb8M=;
        b=u1wL/Qa4vi42PmYHMlmAuF+pcoc19J3/Rc78YOFuAqYc8dI2rpPPf2eNxErlSKN5mn
         ufh2ZuAgiHZqj6N2Ou45wFwcW/B9BZ1ynyVLpSTaWwZ8TxQ8Lz8bkt8gTd+LxUpj33EP
         3vADuirHhOCEqQOj2diwfxkrQR/VzWNqLSl6GIkw68hu7oDR5HRBaOJcRhlQc+LVGF0m
         6tNKTCQJL+1Avq8aFhZkGBXmHTrnOWkkXfgQ3S8WGmtW/tB7dkue0DnyVJkWq7yaiaLb
         8FtSukk8lBjALks0h3S8l4XQiyuzrR4eb+OO/QYjxH5pU6SwJ3uNKUsEadTRWD8apvMi
         9LKA==
X-Gm-Message-State: AOJu0Yx4nglnT2W2CTmde9XHMbv5RiqZcNyeYdR3U+KPxDexKEDzDFwX
	XFY+Xv9pGn2WObzUDIX1FaQEOb9uwqVhu4pTpPqc0Ru57W4oxfJ1x9B6kxHHfXssKtCKyBVA1WA
	1HU9IUTwP8b4AnsMVIFTU8gN9fIE1IeC6Y8ZP7N00zFFhO4xVESoL
X-Gm-Gg: ASbGncvvWiyRAz1YD4ONSNf2uQMe/z5TkVqEbxNszhhJIqihpG1w1f7o8YGMgWuBQFz
	OyBmnI44XzVRX6dzfa4JSyLi5DA7oVRCpu6rtbUtMkSW+/J9mNEuWUwnLpWXnhJJeMCcXYatBsd
	qsjpDYGyENNufpptrVQxQ8n+/ynbj80SothPcjcDgM1R6DDpGlfPQayWud1CSiE3VnCNVPe/+M3
	GYGYnc5DyZvLxdGVaLBU/Fi0DvBPynsNLEcIQbA8btVXJgx2w==
X-Google-Smtp-Source: AGHT+IHswnLkvHZDR+FiZJY/oMTE/NXeB21qfxjbVBeTuv1nwJmE0qqiA/Y+Cc4levwnMb2k3syv6Q1agdY2laID2eY=
X-Received: by 2002:a05:6512:691:b0:55f:56db:7648 with SMTP id
 2adb3069b0e04-55f708b6be9mr692075e87.19.1756583118685; Sat, 30 Aug 2025
 12:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
 <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com> <16a21382-4984-4250-a770-ea39ddeedd3b@quicinc.com>
In-Reply-To: <16a21382-4984-4250-a770-ea39ddeedd3b@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 30 Aug 2025 21:45:07 +0200
X-Gm-Features: Ac12FXzCZSIJw1cAwWtNg5kpRBZzyJoVTf8XQVUxvzss23sMDuJS1kyLNTvzifc
Message-ID: <CAMRc=MfQwScuE8RKYYKq7neMc+tzBsKKBP0d+ovvNYnC604gLA@mail.gmail.com>
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:49=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.co=
m> wrote:
>
> Hi,iBart
>
> On 7/2/2025 6:23 PM, brgl@bgdev.pl wrote:
> > On Mon, 9 Jun 2025 18:55:00 +0800, Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
> >>
> >> Some modules have BT_EN enabled via a hardware pull-up,
> >> meaning it is not defined in the DTS and is not controlled
> >> through the power sequence. In such cases, fall through
> >> to follow the legacy flow.
> >>
> >
> > Thanks Stephan for bringing this to my attention.
> >
> > Shuai: you have not Cc'ed arm-msm or even linux-kernel and so didn't gi=
ve us
> > any chance to object. I will separately send a MAINTAINERS change to ad=
d
> > arm-msm as the mailing list for this driver.
> >
> > What is the problem you're seeing? The bt-enable GPIO is optional in th=
e power
> > sequencing driver and if it's not there, then there should be no differ=
ence in
> > how this driver works. What are the offending platforms?
> >
> >> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 13 ++++++++++---
> >>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index a2dc39c00..976ec88a0 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -2392,10 +2392,17 @@ static int qca_serdev_probe(struct serdev_devi=
ce *serdev)
> >>               */
> >>                      qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->dev,
> >>                                                                 "bluet=
ooth");
> >> -                    if (IS_ERR(qcadev->bt_power->pwrseq))
> >> -                            return PTR_ERR(qcadev->bt_power->pwrseq);
> >>
> >> -                    break;
> >> +                    /*
> >> +                     * Some modules have BT_EN enabled via a hardware=
 pull-up,
> >> +                     * meaning it is not defined in the DTS and is no=
t controlled
> >> +                     * through the power sequence. In such cases, fal=
l through
> >> +                     * to follow the legacy flow.
> >> +                     */
> >> +                    if (IS_ERR(qcadev->bt_power->pwrseq))
> >> +                            qcadev->bt_power->pwrseq =3D NULL;
> >> +                    else
> >> +                            break;
> >
> > This is wrong. It just effectively ignores all errors - even -EPROBE_DE=
FER.
> > This patch should be reverted as - depending on the run-time ordering o=
f driver
> > probing - it will surely break existing platforms.
> >
>
> I'm very sorry=E2=80=94due to my oversight, I forgot to update it.
>

Yeah and I was on vacation. Meanwhile this code is still wrong in mainline.=
 :(

> The updated strategy is as follows:
> Handle nodev separately, while other errors will still be returned.
>
> case:xxx
> ....
> ....
> if (IS_ERR(qcadev->bt_power->pwrseq)) {
>     switch (PTR_ERR(qcadev->bt_power->pwrseq)) {
>     case -ENODEV:
>         qcadev->bt_power->pwrseq =3D NULL;
>         break;
>     default:
>         return PTR_ERR(qcadev->bt_power->pwrseq);

In what circumstances would we get ENODEV here?

And you surely don't need an if AND a switch.

>     }
> }
> fallthtough;
> case:xxx
>
> >>              }
> >>              fallthrough;
> >>      case QCA_WCN3950:
> >> --
> >> 2.34.1
> >
> > Bart
>
> BR,
> Shuai
>

Bart
