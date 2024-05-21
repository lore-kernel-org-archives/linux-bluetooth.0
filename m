Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3F148859
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319608; cv=none; b=Va4yzjoy7oYn/8XJjwzZo2hsp5z3i1Zb3Dy2xT8HPo2zJ+JZdUH1DAePm3P+8fvHTCMjdMjrdQSr7UiLMsqwlP1fpsK1eYToVsFbLxoiDILyK/cDPG4ohPu7j/+ktGcFICSpCtFN2+oHFeZKoQFQGnfpwqNljWuQd5NjZ7FAfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319608; c=relaxed/simple;
	bh=PG0Bhj9TcLH+RIGS1FPI6Y6OS2OqHxgW6MGecFCprms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7ep5g9poF4hwz5RKwGUfJ1ZbO9XwRFGW8O/acI1spTXyErfldQ2xgKEUyYRbCHSJjBGyvL5aOV22Ea8xBZaq6FMRwrfXpVOzXlmRGuqOdEesxd2vK3FyYj6SoiVUKVKL9pAPIu72Ba6RZkZzRU0ylO2ptmoo8WZSlslEdXiY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnlD5+BK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnlD5+BK"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso7726760e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716319605; x=1716924405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5xNertqR2g+hN0eAyKVzqg+xc07skQNSSjJdiq7WQ=;
        b=GnlD5+BKWFy2m5S16Djr3aAMvbZHdpSgY6Cs9zCF+S7E0IP75m+NcALgQ1p87sMyfD
         LK9yULrubSBVjLrQv0Y+k8RB/rd+tISgiOI4J7gnvbJ8y3+JKJiPdEoUALFFRHQsnshO
         GVwT0gtT9z+UY1mSPSvzwYhLzzxS4JQiGEhrN0fGy4oA4JaImAtZ7W+QOSUqF65PMJXt
         b41MRlKR5Tb9JkCl89aBWHE4IPPYDo4/J5JqZZDA0TIdHU4BVe0f1eKcu0GG1ggtQSDH
         9NIrLCVIUS6CYTOcvz9Cy3yG4K2uMDRz3lLtgBVeML5bWsZr/FYP0Sc/g+zRp6XX2c7u
         u7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716319605; x=1716924405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD5xNertqR2g+hN0eAyKVzqg+xc07skQNSSjJdiq7WQ=;
        b=iYuiWcPxPHT9kmgerbepZJTA2hp6UnZRE4EzVb/03y3Qzr04adq8BsRG6o6Kbqk0d4
         m2PxvO5PUj3VyZvbcIPfkLZPFp5x38TfYdaP+nzOf27VH6y7AL/y2tp7SXfW+diVcV5T
         9UHkBHZLhFups+guvWZwJLJ9isfClmNMEXSB/wNUwTbO/fIw2U9P/eHD11bf8PyJp27j
         5xqB3kLmKnZ9UxueSmsQSHt83b9O9qWQlsG+iLgiwjnrwTrqU/6lRLEvogY53AED9COU
         GQiaAgMf17kSKCzbvQFcAi5TGeSzpXiG0p7Ff7fT1N/CLAHz/gnDg98pynvn+QilYQYR
         8IJg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ162tM56y5UB9Jvjxpwqsqa4IjYYjR0WBQUl0Ep+1Z4atGGLDTfiYFDxeHbjvxw4CA0BssDCPaaUGG5WlXQ6c3IRfxlQ+uxLhhOYl5xy2
X-Gm-Message-State: AOJu0YwoiURfbHexFanWjZhk93/3AKTUrRULj+F8xIwmKyGgWU6OFVC3
	/w4t3fL9ON1VZnVxK7NHlf+cDq9qQw/QMYeJlnRw1JrOs3YEFH84LTuh9CfGMh4=
X-Google-Smtp-Source: AGHT+IEI7yg/NIK80VlgHgC5if0nzTCUSeh26mIUJJHjHzauPok3eKyNNCTC5GQNcMDPLnXS2NGD9w==
X-Received: by 2002:a05:6512:1086:b0:51c:d528:c333 with SMTP id 2adb3069b0e04-5220fc7d748mr25123725e87.20.1716319604792;
        Tue, 21 May 2024 12:26:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3791sm4734603e87.174.2024.05.21.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:26:44 -0700 (PDT)
Date: Tue, 21 May 2024 22:26:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
	regressions@lists.linux.dev, pmenzel@molgen.mpg.de,
	krzysztof.kozlowski@linaro.org, lk_sii@163.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
Message-ID: <Zkz1cppeCsKRrqQR@eriador.lumag.spb.ru>
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>

On Thu, May 16, 2024 at 09:31:34PM +0800, Zijun Hu wrote:
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.

Please provide a trace or a detailed description and analysis, why it is
failing in such a case. Just claiming that it doesn't work or regresses
doesn't help us to understand whether the fix is correct or not. E.g.
the message - expected response - the actual response.

Next. I can only consider it to be hardware bug if there is no sensible
way to reset the BT controller. What if the running OS crashes with the
BT being enabled? Resetting the controller should be done at the powerup
time, if it fails to respond correctly. Which might include sending the
magic command. There is little point in resetting it at the shutdown
time just for the sake of the next boot.

> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> by adding condition to avoid the serdev is flushed or wrote after closed
> but also introduces this regression issue regarding above steps since the
> VSC is not sent to reset controller during warm reboot.

Is this commit already merged or not? If it is, then the tense is
incorrect. It introduced the regression. My first impression (as of the
non-native speaker) was to consider that this patch introduces a
regression, which left me puzzled for quite a while.

> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also fixed by
> this change since the serdev is still opened before it is flushed or wrote.

Please see Documentation/process/submitting-patches.txt for a suggested
language.


> Verified by the reported machine Dell XPS 13 9310 laptop over below two
> kernel commits:
> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
> implementation for QCA") of bluetooth-next tree.
> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
> implementation for QCA") of linus mainline tree.

I couldn't parse this phrase. Not to mention that only one of these
commits is a part of the Linus's tree. Maybe you had some other commit
in mind?

> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Cc: stable@vger.kernel.org
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
> V1 -> V2: Add comments and more commit messages
> 
> V1 discussion link:
> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#t
> 
>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..9a0bc86f9aac 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device *dev)
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>  	struct hci_uart *hu = &qcadev->serdev_hu;
>  	struct hci_dev *hdev = hu->hdev;
> -	struct qca_data *qca = hu->priv;
>  	const u8 ibs_wake_cmd[] = { 0xFD };
>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>  
>  	if (qcadev->btsoc_type == QCA_QCA6390) {
> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
> -		    !test_bit(HCI_RUNNING, &hdev->flags))
> +		/* The purpose of sending the VSC is to reset SOC into a initial
> +		 * state and the state will ensure next hdev->setup() success.
> +		 * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that
> +		 * hdev->setup() can do its job regardless of SoC state, so
> +		 * don't need to send the VSC.

As I wrote earlier, sending anything on shutdown has a limited
usability. Send the commands on init instead and drop the shutdown
quirk, unless it is there to prevent BT from draining power while the
system is in shutdown state.

> +		 * if HCI_SETUP is set, it means that hdev->setup() was never
> +		 * invoked and the SOC is already in the initial state, so
> +		 * don't also need to send the VSC.
> +		 */
> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
> +		    hci_dev_test_flag(hdev, HCI_SETUP))
>  			return;
>  
> +		/* The serdev must be in open state when conrol logic arrives
> +		 * here, so also fix the use-after-free issue caused by that
> +		 * the serdev is flushed or wrote after it is closed.
> +		 */
>  		serdev_device_write_flush(serdev);
>  		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>  					      sizeof(ibs_wake_cmd));
> -- 
> 2.7.4
> 

-- 
With best wishes
Dmitry
