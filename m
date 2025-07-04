Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFC1684A4
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638247; cv=none; b=BwfTqH4NCmetDMQt0VM4va/1Um8rXDRerdgXE57ok0JQq4+9WteeyBqk6BEstywV/Pmabq1jue8IbBDoQGp5egozLHBv//VOqYeJUMAzDKHi4Pop2ynF4I4dx5R6nULDEu89r7GBTMGOZhY70oSElZ2W2R+ULEnN+7X63dWKG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638247; c=relaxed/simple;
	bh=Dfdm5FF8p/asJkN1ovyZddX3kDpoK1lneJBs/q9zZ0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYzqRDmHQQRe06ohHC4THrheFFxZk9zqLHX37q+A5vUP6klrFWL8r4+WsV46Rl2ThR51XMyCma1Vs88g+k2xvKnTZAbHPI/F4lF2UGxuPNPaGZjhoRTcOdECF8tfnVh8U/7N/cxGwDjsEdJ56+E69SIGTzYh+R/EZbCgZX9GZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g5TF4ULI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g5TF4ULI"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5550dca1241so1045819e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751638243; x=1752243043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeefrPmGnWdHtnDIyQQORJzwQDhEvK5BWUbtIujSBKE=;
        b=g5TF4ULIPWsKGJ725UvFrzYnM+5NQgR8+14uBhByg5JJLmkENTAZDPgXPrk1AhF4j+
         1YBKuehhKugX5bjyRSa//uGp/CaLRqp1sm0uZjmY/WrlLXyv/dS32WIX57RJVyscYMaY
         w5/wuqZ2mVhY5aKA/R+BbAHe9QBzp8frzkpy/y46aSheWx0jGxa+/1GKWp8f51GlzzPO
         lNvMcgdGE9v1/0KS8e53Ll4LattWptgtxo0pSyrIuTG0X63ByTd4CZQPt+IqUGZqflB9
         kzvtNVxA/5EA37IJvIAV7d1JzRpIvCydwlIgYp+0tysoWcLE8yeWYyBV9YekTQpJWhvd
         EgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638243; x=1752243043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeefrPmGnWdHtnDIyQQORJzwQDhEvK5BWUbtIujSBKE=;
        b=aHIiG2F1xdOKPhoQKVyFudDrco4lJwVallZ6YK+UutCsSSzV+/gp9AojhTPcBcVqgh
         T8v/bPxPvBYIiH3Dii0uV1W2LkaPyvsmHQKeq9ogNRqamrRjKxyJqubOXe8w+HvUT0XX
         Vu/pXhP1DL40bZwjpVQTO4wif6nvECw2g1eNkHUSFq9fsbTAUwt8s435WhRCdNBut5bx
         dxFiXxl+xoqf5ENO7VY8+CeyJpBPnbwaDB4BWuFjJzfdc7yZG+tKoVD1D/KVx6Qqv3+i
         GgpgBav+GZvhWejpjg2H2ogrMZwrzwX5YfpUBfoDyxVr8tkBmVvTmnu2K63NmcWGISWD
         wMVQ==
X-Gm-Message-State: AOJu0Yzd60lc3nwC4NM33sHEO1VBygjdCUP7lrJ7YwTyCI+f0qxYB/Q+
	yTBSTu38zBtIa8xC7tSN/K9jx/9acVF4oS/fBbHExBAi7brr/uA/S8RQtNeO8m4NltPV2WHK2Di
	uA/qbwdLqQgQeH5lWU+COQSi7VapAuxol4ekfv9avig==
X-Gm-Gg: ASbGncvX3JdXyOXUYUPgsEwxq3ttMe/vboQZs/pJEP59PaJ6Uc3o/q2pyy3+2aXQZSS
	9lhCNYJ/vXC9YeUnmqcUomKwBzdnG4ia907bNmpIvt1CFGBS5kk5XbLRVMPhDfiqL34489tJhx3
	TdHR9i44ALJ7glMVsSURqJYzgXaYqKr/l09bYYdqtSTD9L6bAyA2ybtjE8QzYmoe6wUwbd0paXh
	JyZ4EBi6U7T
X-Google-Smtp-Source: AGHT+IFttge5OKG3D/KdxRmL489MukhcXwxXRuYcJv+J2ohUjxlJ6u9kAyZ9inU4ugVZ8+VI2nbCM9N5LTXSwKrOJRc=
X-Received: by 2002:a05:6512:3501:b0:553:35ca:5922 with SMTP id
 2adb3069b0e04-556f284ebf8mr814433e87.56.1751638242573; Fri, 04 Jul 2025
 07:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
 <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com> <2dec984c-c6c1-4139-9e64-314942aad091@quicinc.com>
In-Reply-To: <2dec984c-c6c1-4139-9e64-314942aad091@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Jul 2025 16:10:31 +0200
X-Gm-Features: Ac12FXylkxDUzj5EmTa8Amg6THTFdy6AaeWP5Qotq-tvNlZOYxO_Zz03qfk9QhA
Message-ID: <CAMRc=MdcZXJ6GY+0ATadHFV2HvTZvV5L0Hz95shkaiT3B0VL5A@mail.gmail.com>
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:30=E2=80=AFPM Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
>
>
>
> On 2025/7/2 18:23, brgl@bgdev.pl wrote:
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
>
> The observed issue is that the Bluetooth driver fails to load,
> and bluetoothctl shows the message: "Waiting to connect to bluetoothd..."
>
> The bt-enable GPIO is optional, but when the power sequence does
> not define "bluetooth", it results in an EPROBE_DEFER error,
> which causes the Bluetooth driver to be repeatedly reloaded.
>

We are talking about the bt-enable-gpios property of the pmu node,
right? What does it mean that the 'power sequence does not define
"bluetooth"'? Is the power sequencing provider not probing correctly?

> On the Lemans platform, which uses the BT M.2 interface, the bt_en signal
> is pulled up via hardware, so it does not need to be defined in the DTS.
>

Which lemans are we talking about?
arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi has the bt-enable-gpios
property. Unfortunately I cannot test it, because the board I have
remote access to has been reflashed and became sa8255p-ride instead.

Bartosz

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
> Thank you for your reminder. I will update the patch to add handling for
> errors and retain the handling for undefined cases.
>
> >>              }
> >>              fallthrough;
> >>      case QCA_WCN3950:
> >> --
> >> 2.34.1
> >
> > Bart
>
