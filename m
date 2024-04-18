Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D249110A
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398513; cv=none; b=Y06VREmdouIA8ENjoprMI48/EWdrhBMXdmqqiMwE/daf7CPsF7jwf9PgMLxl5FzcnoI3jiSNrFjCuCer8LTeBCMsxnzdZ2HqwHoo0h3tupfZJu5XLF9vnuNiuqA8mQXF0RGiiAjZibCfr/qWTo12RkYtwxAlU45qy0KM8Z3pOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398513; c=relaxed/simple;
	bh=hv0i5dls5I2HJWfxhsl7AyEzBSxGTcyS11VnuriUitU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2nCZfHC3uegNx+hVA0GI9DJoqiB9hLEY0THAnoXYmU9NnvD/CY5jSgFLMlWtbI9E6CislM/57k003ePpYSSh+q2OvhH6RVEnD0LDHbEAc8vZeCe+sqBt4vLpSQL8Gi7fCVCVqMBmNiE3qZnv4/WGC7mR5e/q0nOd6CQZN5idc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZMuuQ1V; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZMuuQ1V"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ae4743d36so2508447b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713398510; x=1714003310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssyy3iyrZLKFVYNpnMZrmVJKaBMsftvHLuSx7t/j3sg=;
        b=uZMuuQ1VbK9Y4c/YGCLf7RT/HBSzS42M2Aw95Yf/x3RSGM321ZlBcBCgvGsUcGv3nY
         uxD+DyglMRkLXfYxi9N2g5mEZExi6EPRLRyA9WIcxbo0PZdESoTOECHRQjt6PLHMmE78
         e4BfSJt95yniYLz7GlkDmVFJ0NN4+9HyBJGKPL8+0wf0Q8Lg9vE6qITiFszEZG1V31ki
         1wKyDO8iZwo2S18hDmM6G2sHWWwhm9moaJMgnC5Ot67KkqmvJrRpfSJDsQcjSlqg7tlJ
         0Z480n8OdifU5fI4yr9fdY5C37fntXB+a57OPCanHIOtKEerbM9UjqQm00sBXl/sCts9
         0LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398510; x=1714003310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssyy3iyrZLKFVYNpnMZrmVJKaBMsftvHLuSx7t/j3sg=;
        b=lGLDgh/B23s6eedruyvW7N4ihYq6ghvbtsRZWhqn7R4SGSIhhOQvtm9f2ZyWR+Pshm
         dK9x3ot6b1gyjvdcNFH3+JDfLtIGQ/OIeOWuaX5sa1c/2e+PNCteve+q2EfIvsMhJF8F
         GM2Y1rKT1dekNX3Uhm6gzxzqnqR/jC6OMzatdj3rmgE86mzCM6QoI8TPz6joQOksj4Vy
         zNt/iQvynzMVHowLErjJ17ObKHNa6POyhm4KOzrdlzeoZH3z8E2xiz/6fhsK2pnL6Q+M
         ceTPLHMZEINYf2uALcvCJSCGSP0b3E9qBT9ciRWKq2ylOJKb5yHMQDHSifHHBjZb+W+t
         FyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfDds7tuNhwhmxEdYfvx5dBpHAoyuMyhcv2N9qnkoMCyHxJsflP51brFl2okEVJDpQeKE1PlRbqcrCwfw4lF64Lnv9exm5AGtKX3W0x2QH
X-Gm-Message-State: AOJu0YxzDx74JY92HHAbvdpF6MwMlTuftP6dJYikFSrSYEyEcxhR1UPg
	rtPFJlg6UkN7AYvFiC9OMpoUdDVGm7WPKChc32KMILvh0iHeCHPdnLNNAL4dKzyLx+otT+o2MP/
	S2FcznO4SR1VhDvzdeB8IxnWIsDQO8WJUVRZKQQ==
X-Google-Smtp-Source: AGHT+IGc9SFXtCBVVk0Q36NlpcIiTuTAmyhonC0QJ1Al6bY99e/WhNtokiN+/oy0JR9RdkndU6/+IO7er45eujBlK8U=
X-Received: by 2002:a05:690c:6f8e:b0:61b:1566:ee2b with SMTP id
 je14-20020a05690c6f8e00b0061b1566ee2bmr1134215ywb.10.1713398510284; Wed, 17
 Apr 2024 17:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713354823-17826-1-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSeuQMz-JCK7tqiQCmt7z37L1UncNK0un28JHAa8qRhnp-g@mail.gmail.com> <59a1921a-343a-46cb-9a9c-6a18f63a02b3@quicinc.com>
In-Reply-To: <59a1921a-343a-46cb-9a9c-6a18f63a02b3@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 18 Apr 2024 02:01:39 +0200
Message-ID: <CACMJSet_SKVPV74AKz52LRH1PaxzF4gaFbdayCYNVW7Xt-5mnA@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
 with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 01:44, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> On 4/18/2024 2:59 AM, Bartosz Golaszewski wrote:
> > On Wed, 17 Apr 2024 at 13:53, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
> >>
> >> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
> >>
> >> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> >> with gpiod_get_optional()") will cause serious regression issue for
> >> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
> >> QCA_QCA6390 and QCA_QCA2066, the regression issue is that BT can't be
> >> enabled any more once BT is disabled if BT reset pin is not configured
> >> by DT or ACPI.
> >>
> >> if BT reset pin is not configured, devm_gpiod_get_optional() will return
> >> NULL, and we should NOT set quirk HCI_QUIRK_NON_PERSISTENT_SETUP, but the
> >> reverted commit SET the quirk since NULL is not a error case, and cause
> >> qca_setup() call failure triggered by the 2nd and later BT enable
> >> operations since there are no available BT reset pin to clear BT firmware
> >> downloaded by the 1st enable operation, fixed by reverting the commit.
> >>
> >
> > Then you just go back to bad usage of the GPIO API. Please see my
> > suggestion below.
> >
> we need to treat below tow cases equivalently.
> 1) BT reset pin is NOT configured, devm_gpiod_get_optional() return NULL.
> 2) BT reset pin is configured, but failed to be got, devm_gpiod_get_optional() return ERROR.
>
> FOR above two cases, hci_qca driver doesn't get available BT reset pin for H/W reset.
> so we use IS_ERR_OR_NULL() instead of IS_ERR().
>
> is it not right ?
>
>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> >> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index 92fa20f5ac7d..160175a23a49 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -2323,7 +2323,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >>
> >>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> >>                                                GPIOD_OUT_LOW);
> >> -               if (IS_ERR(qcadev->bt_en) &&
> >> +               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
> >>                     (data->soc_type == QCA_WCN6750 ||
> >>                      data->soc_type == QCA_WCN6855)) {
> >>                         dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> >> @@ -2332,7 +2332,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >>
> >>                 qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
> >>                                                GPIOD_IN);
> >> -               if (IS_ERR(qcadev->sw_ctrl) &&
> >> +               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
> >>                     (data->soc_type == QCA_WCN6750 ||
> >>                      data->soc_type == QCA_WCN6855 ||
> >>                      data->soc_type == QCA_WCN7850))
> >> @@ -2354,7 +2354,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> >>         default:
> >>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> >>                                                GPIOD_OUT_LOW);
> >> -               if (IS_ERR(qcadev->bt_en)) {
> >> +               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> >>                         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> >>                         power_ctrl_enabled = false;
> >
> > Can you just move this out of this block? Or just simply check the
> > presence of the GPIO descriptor in the if block setting the quirk bit?
> > Warning on a missing *optional* GPIO is wrong. It's not an unexpected
> > situation, it's normal.
> >
> your concern is that the prompt message is printed by wrong way or the prompt message is not precise.
> is it right ?
>

Actually now that you're saying this: if gpiod_get_optional() returns
IS_ERR() then we should bail-out and return dev_err_probe(), not
proceed. What if GPIOLIB returns EPROBE_DEFER? Only NULL is an
acceptable return value from gpiod_get_optional().

Bart

> > Bartosz
> >
> >>                 }
> >> --
> >> 2.7.4
> >>
>
