Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C9382
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480146; cv=none; b=cIRNCS9+65LIbqHmfFON0i2lxbSJg/nktNKwmpmScJzKGSgXXUO9/TK3e6k8a4GYfiFzLCgtnhDQFnd79Kt4sgUqVX+jfk8tj0xvhQ3vIBcVxUJUsjtyay7KaieBrf/HyHpm0A/1qCt3Hj/NYEK8rcE2Ilp0tv4G85LXxiaCeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480146; c=relaxed/simple;
	bh=5ZZjnf4R7D6z0h/Jvshc73SfEjkxffQ0YBV8zgfj9KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMB51Ztf0YuI4RYL46gQr9KH87v2Ji/BDaoMoEzO+d3EB/pxYwUunbkyv0isxr+O7LtY4fSpsemXdzvFsuyMTizQPXQXz63izm+HVKQkKMVD3b5J345GgEdh+TKiLPZa61TPE7O1zWR/XavWHzGQpHpLcXBxe9v0YlJi5U4nzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MA9CPR5P; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA9CPR5P"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2445906276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713480144; x=1714084944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKfUSYksKTj72yPLq/023/BuzyeQn6Zc0JBtcx79h2Q=;
        b=MA9CPR5PX7rdz2OoyMP+tsuTJwv2SLKru+4qubFWNSVvP8cgv1u54PA7zq63T8UigL
         cNsLR6+KO1rsKVPGZ8hSthePt2Wqg0YtkBWvuY8RIBFkADioeJ8dSYdBUWAIJffxzRyr
         Uefxr/q6b+qGbHIIlUjbbpaS0Il19V1Ry8u4ztAQ1R7vqJvNXN6aWmsJwFvjroAi7t27
         hvFyZHWozdUnAeqUtew2Rbsa92SsHC1YOyWyCkpCPcbb+xkJMWQkZuiYxZdVseHVpPDZ
         xAHv/iGThuYtGs2qvT7niGu7giVAZcwBmxAXA/QqpNbRtISnxZuYndrjqX1rAYUIxtdV
         7eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713480144; x=1714084944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKfUSYksKTj72yPLq/023/BuzyeQn6Zc0JBtcx79h2Q=;
        b=OUncMBpO3PFxr5djlANyVnfg9TMDQLdkqgLwM/3FPPMbzQ023wy/SGY6WzsL6ZgEVv
         q41FtpmZZUnz7Jml7TTsGCWkq5mj3hrsMtYSp6cT57iM/oF8VYPyVgg0XecTxC8k2Hxc
         n6YwC05M4bS2JqN2H1uurOEvpz6jnY9C25yE0URz3k5BLfUdWiO5YyZ2YYdWzI+2NwfS
         7XoCWJ5okhtjB20qWjvklQa9SXGDHlCyj8iw1+sClYf7/w1shAJrU3YAIS8Mdm3v1JBg
         1JA50LkiPwtnxdBrTucZ4PW4N9f4/mj06lt/pFf7rvddy1biIw/TbIqq1iUarp7T3You
         mKqA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJDN8HhssqdzyQS/KweZB7Gb/nSPPSsy4FFtiFOcHk4n+UwzjPGGI7ERiGiiiAl/a5Y4asZQQ344WbgMEQEZchdZQs7xTZhPDX9rWJhi5
X-Gm-Message-State: AOJu0Yw9A6MgDKbMEVpnTOv56+tQhJYwnbSvhkjU2M7ZnKxwhv44BO/m
	JDWxJp8uPWYYaqf4mASGZ9oBFJa9y6Wy/ZXEeqN9MJbIQo5xn0cPCwuRDyh2c/8l6aquw4YMsRx
	G+soSHacufdHWYL8ra14/AHCQiYpuWYlijxBGbw==
X-Google-Smtp-Source: AGHT+IE501Opkla3+OHERZIp0Z9co6uiQD9dymo4DInnWrpTqsW954tkBO2gFG/UQM45GJPReGCcd8qjQFCq6Fn7M/E=
X-Received: by 2002:a25:c78f:0:b0:de0:ee2c:b828 with SMTP id
 w137-20020a25c78f000000b00de0ee2cb828mr488631ybe.25.1713480143715; Thu, 18
 Apr 2024 15:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com> <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
In-Reply-To: <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 19 Apr 2024 00:42:12 +0200
Message-ID: <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 23:43, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> On 4/19/2024 1:00 AM, Bartosz Golaszewski wrote:
> > On Thu, 18 Apr 2024 at 16:06, Zijun Hu <quic_zijuhu@quicinc.com> wrote:
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
> >> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> >> Reported-by: Wren Turkal <wt@penguintechs.org>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> >> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> Tested-by: Wren Turkal <wt@penguintechs.org>
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
> >>                 }
> >> --
> >> 2.7.4
> >>
> >
> > I told you under your yesterday's submission that you should instead
> > consider bailing out from probe() if gpiod_get_optional() returns an
> > error as right now if it returns EPROBE_DEFER (enable-gpios is there
> > but the controller is not up yet), you will act like the GPIO was not
> > even specified.
> >
> > gpiod_get_optional() returns NULL if the GPIO property is not there or
> > an error if anything else goes wrong. In the latter case, you should
> > abort probe.
> >
>
> 1) do you meet the case that EPROBE_DEFER is returned ?
>

It doesn't matter. It's about correct usage of a programming interface.

> 2) does the reverted change solve above issue you mentioned?
>

What?

> 3) does the reverted change solve any functionality issue you actually meet ?
>

What?

> 4) BT still is able to work fine by clearing the quirk even if getting preferred H/W reset way failure, why do we need to bail-out and return dev_err_probe() ?
>

The only acceptable "failure" for gpiod_get_optional() is when it
returns NULL. I should have fixed it when I sent the patch you're
reverting but I didn't spot it right away. Proceeding on any other
error makes no sense and will result in inconsistent behavior.

> we will fix it by right way if EPROBE_DEFER is reported.
>

What?

> this change is to solve the issue mentioned by commit message regardless other issues.
> it is not possible for every commit to fix any other potential issues as long as the fix
> doesn't introduce new issue.
>

What I mean is: don't revert a logically sound commit. Instead:
improve the situation on top of it. In this case: bail out on error.
And like Krzysztof said: right now the GPIO is required according to
bindings so using gpiod_get_optional() doesn't even make sense as far
as bindings go.

Bart
