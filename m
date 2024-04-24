Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB61598ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954855; cv=none; b=fkWqLyyI7dSIkmQrCj/yfbuZFhLYXajsIiHTEyX8KFWO71TVlXxLuxVcbQdotKup8zeomWuImq/BzHyRfTbm4qvIK8qqbY/10FoXtBxLBwgqArlymk5EHxLLpMMeTDKo1FtZCZ1ZTEcT89I+XGpBMl+H4c6XEMCjfTAVCziuqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954855; c=relaxed/simple;
	bh=QslWPthNCxNrHHURQlPTjTLCkTBnRmLIUXZux2KXX5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJDPfwdKjxnVW0+cFbMUv4A9djflWtn4RHSzmkdirLpNiemQDJ6Lfh+xU2YuZ+ptYa27cveI9f0UinV0VP5/2/V1LBWLl3MTzswN6yYNIn0uL0HLs+v6YthtC4sMvb/sDt7TAMC4ia49KSRZrtmy82nGH2ArlUQs/B5IfdlOUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoZju6w4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoZju6w4"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so6195413276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713954853; x=1714559653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tWqpnhAkKxffabgFehcfygGKTeKUYkh6WO1uD3T9Cp0=;
        b=xoZju6w4Q0LbwFp+iDc9tY+LxExgWwfW9T6lIEGSLAFC8I+8QHVM+tPLNHYNb4zy/9
         9S2BP+g9soWmLBR0IgzeyEyPVFrjOg4VqKcmsRt8Go/eCuCucvBzJECd63EUh6XHC8Po
         0B8Ds2yybsnA2f2q2InMDEbBkSkzr+/aFBz1ldN88Vbt0t90NgYjc2GPt8JEnAL2ce1C
         5kY88wWTVLV8mgK0Zu/NO4KjcI/b+pHH1MhEpGEDXMBL05qqZA/oiJz1nhIt7vMpS3oC
         DzdDn+VpjY4fVLG7WxXzzoOk2h7Ju0r2vYiI58vXQcfI8dTDwCoKUetrXk/Knp1LHy2G
         4uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713954853; x=1714559653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWqpnhAkKxffabgFehcfygGKTeKUYkh6WO1uD3T9Cp0=;
        b=rS7Zir75P/qsgAdVSI/abw2MlYQUbvuhw1IKODooNGB5e5pFxeF+2bWLPzCnU0VQx5
         xfRmulDi0UOaUuhcsqDBf8kiezV5NKc9B3R50SVs/RHBjwk2dyMkd9NHXH3iMYY++HyX
         KL35OWhFZtukrvURO5aSYRoLmxVLGJlS+wpo0ljOkfqA8yZ4FXQgjnveyDkL8QYNJMun
         gAMXsvp898U9f872K6BBnOeTnEa4EMSAWKnd2zRhREvlDRfrQ9O++TwM2fJJSEDi70Es
         8tATDhpt4h3hRmPJ6o/owCqZOrwO4+h/3+nFRPoG8CrRZ1BglP2a9OAHKLXnXpJ2RIsp
         xgxw==
X-Forwarded-Encrypted: i=1; AJvYcCVfH1+/glYxL7XaOID/uXDBz7c7kHiJ0uL3KDYubaGyTSJ2Js0oB0IOqIX4TXRr7jQbayVsXf64FCNKWkztWRQ53n0Oc9mjQdX8FVW7e7ej
X-Gm-Message-State: AOJu0Yw8DX4ionLznrwZJUWpqFXifi9af9ILus+kwFvs6F9ereKduDou
	6oUj4sVSZakvaIlvjSuXfA9CEBr/FnTdoMUcDcjxu0kZDHZzXO7r8AgSsYJOZkXxsUpAk+6JbtB
	RKSZL5c3k7iWwMJxHus+VkrAaAfQ6FamYwsCIlA==
X-Google-Smtp-Source: AGHT+IGX6jReH7/d4zAo1Y8CAQHvuYg0zyqNAoNVHWG33GgQNr0dsKF6RFxaw6zKGJSK1X1o21/AJTYsnGB7DyKV1CY=
X-Received: by 2002:a25:840b:0:b0:de5:5823:d5b3 with SMTP id
 u11-20020a25840b000000b00de55823d5b3mr2135853ybk.26.1713954853204; Wed, 24
 Apr 2024 03:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
 <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org> <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
 <c1fc9c28-25df-4d41-9ae6-c5d079ea805d@penguintechs.org> <0db77c30-5be2-41b5-adf0-fb4436b9107b@quicinc.com>
 <c9bf22a3-2549-4cf1-898e-8a9adcd2f0f6@penguintechs.org> <d77455b2-4fb9-4ffc-acf9-c24b5a0f4a45@quicinc.com>
 <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
In-Reply-To: <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 12:34:02 +0200
Message-ID: <CACMJSeugN49baZiBhTYhb5rUKNkBwu5sVfzWkiJgs0sv9x9VsA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, luiz.dentz@gmail.com, 
	luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev, 
	kernel@quicinc.com, gregkh@linuxfoundation.org, stable@vge.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 11:40, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> On 4/24/2024 2:01 PM, quic_zijuhu wrote:
> > On 4/24/2024 1:49 PM, Wren Turkal wrote:
> >> On 4/23/24 10:46 PM, quic_zijuhu wrote:
> >>> On 4/24/2024 1:37 PM, Wren Turkal wrote:
> >>>> On 4/23/24 10:02 PM, quic_zijuhu wrote:
> >>>>> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
> >>>>>> On 24/04/2024 06:26, Zijun Hu wrote:
> >>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> >>>>>>> with gpiod_get_optional()") will cause below serious regression
> >>>>>>> issue:
> >>>>>>>
> >>>>>>> BT can't be enabled any more after below steps:
> >>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
> >>>>>>> if property enable-gpios is not configured within DT|ACPI for
> >>>>>>> QCA6390.
> >>>>>>>
> >>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for
> >>>>>>> this
> >>>>>>> case as shown by its below code applet and causes this serious issue.
> >>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> >>>>>>>                                                  GPIOD_OUT_LOW);
> >>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> >>>>>>> + if (IS_ERR(qcadev->bt_en)) {
> >>>>>>>         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> >>>>>>>      power_ctrl_enabled = false;
> >>>>>>>     }
> >>>>>>>
> >>>>>>> Fixed by reverting the mentioned commit for QCA6390.
> >>>>>>>
> >>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> >>>>>>> with gpiod_get_optional()")
> >>>>>>> Cc: stable@vge.kernel.org
> >>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
> >>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> >>>>>>> Link:
> >>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> >>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
> >>>>>>> ---
> >>>>>>> Changes:
> >>>>>>> V6 -> V7: Add stable tag
> >>>>>>
> >>>>>> Stop sending multiple pathchsets per day. I already asked you to first
> >>>>>> finish discussion and then send new version. You again start sending
> >>>>>> something while previous discussion is going.
> >>>>>> you concern is wrong and i am sure it don't block me sending new patch
> >>>>> sets to solve other issue. so i send this v7.
> >>>>>
> >>>>> i have give reply for Bartosz' patch.
> >>>>>
> >>>>> i hop you as DTS expert to notice my concern about DTS in the reply.
> >>>>
> >>>> Are you saying here (1) that you identified a problem in the DTs that
> >>>> you hope Krzysztof notices or (2) that you want Krzysztof to notice how
> >>>> your description of way that DT declares the gpio as required affects
> >>>> your proposed change. As a native American English speaker, I am finding
> >>>> your text hard to follow.
> >>>>
> >>> 1) is my purpose. i have given my concern about DTS for Bartosz' patch
> >>> and hope DTS expert notice the concern.
> >>>
> >>> my change don't have any such concern about DTS usage. that is why i
> >>> changed my fix from original reverting the whole wrong commit to now
> >>> focusing on QCA6390.
> >>
> >> Let me try to parse this. If #1 is the correct interpretation, does that
> >> mean that the DTs are wrong and need to be changed? Do you expect K to
> >> do that since he's the "DTS expert"?
> >>
> > for your 1) question, NO
> > for your 2) question, need DTS expert notice or suggest how to handle
> > case that a DTS property is marked as required but not be configed by user.
> >
> >>>> I think you are saying #2.
> >>>>
> >>>> I just want to make sure I am following the discussion here.
> >>>>
> >>>> wt
> >>>
> >>
> >
> Hi Krzysztof, bartosz.
>
> do you have any concern for this patch serials?
>

Yes, we have voiced a number of concerns. Please see the fifty
previous emails in several chaotic threads.

I will stop responding to you now, at least for some time. I
understand that there's a regression. I will work with Wren to address
it. Hopefully we can get it fixed soon. However I feel like I'm
wasting my time trying to get to you and I have more things on my
plate right now.

Thanks,
Bartosz
