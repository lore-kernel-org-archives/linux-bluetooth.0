Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2315886E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949448; cv=none; b=iqjl8pGt/L0j6FrMZSkI7E52uV0UZu42kKBDusu0LF/zmgRkcUk4zp/doP1PQqLA2dO0s/X9/eRANZTxYDdedwGtJ8J47hOo0pMNlv6piI1F4EgCZ/P17jFA9tZtv+aT9IqD0XUykRbCRC5ltZ/7do+Th0DRHzBd3/p3G6DOyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949448; c=relaxed/simple;
	bh=Y2wzOvQe5awl2YyrzbxpkVss7E7jaSjDhA6vqXjHISs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csmoo/XTkb0/hc7gfLelAvmE7FWfRJNkZ81uCesOB8ft8AiiK4bbeFTXG52ulD9baSWLgVUq1yNM2ucyB9SWZaJFZvbzzZTw6tTw9AiFwh2zggMSQvIgiIdSrg0+//V2NeRJ+ybBBs035pcpCdX+2Jb7JJGr5UmEJYqgdXhN/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fOLfqlIy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fOLfqlIy"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d6c1e238so8329785e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713949443; x=1714554243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9za8GIt2C4BOKtDqST70eWWIAaa++7qoZuka22atU=;
        b=fOLfqlIyZjW5NIDsjunXrf5zQeecKGfECk1Ut0zAaoXNQaqoYT1Od8bBgbAdUY4J+b
         oAMyqqAiDH+z2wPtikd1QoVvSzGiMRwzX9ulXWrh3iGFknUibZ7fUT9rOGFBpbjuCAdS
         PoNu6hm2/LXgd4mk7oaSCDm6k96HsOqTQCEsp51qnyihrHJu5DcFeeim621432QuiQd5
         JYmxm+TEa0GjbbQf5vWKb0fKYyLWPMY2R/6561e1rHlQFxe1He5MZElaDxyvZaUtm5Qk
         WFpWeoAHVVgeojypTFH6UpBUlZFpihTSUiJ/cVXHmmr5FsVzagTNOyVfi274v0N2Zbsr
         8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949443; x=1714554243;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG9za8GIt2C4BOKtDqST70eWWIAaa++7qoZuka22atU=;
        b=vp04W987ZX2vSla+EuCNX6skuj3PZlxBP2efDZjimQQ4O3LWpSTmRseieQSRRM20OK
         PdnLG7BoTTU1XdTbvlnUG2ys9TJtOvPb/TV0AOJ/EkVuelYlUvTpo0wUHWjIupqyCvGw
         nZnJOSRM29l4bBO8hQcIjNPh6seD2En0Wu41gVw17TZLo8gvIUSAWLdMT6277Prgr4BG
         XCXjEqsEcMEdqOGQy+u+Jjqi0zg65oQ5VxNcIj+k2oofuVpJ2KjB5zvGkNOxHZeWqHUy
         aVpZnMkrz7BBsAKqB7obyIIWOZYo9eU7c4wVDRih/D6SEkpCZHHesZsUYxF/xwLix5pd
         dz/Q==
X-Gm-Message-State: AOJu0YzLW6P+LdIzN6N7Dw8SGI2ANb0evzhxQtoOueLgD1Jt0+oKtIy6
	6Iv0D3739JOLjxf93q9bSNtkPZdGUiQqEm5ltaB9+AiBMfAH8NSyobKVGj8r98fiNH+Ht3lh0mK
	P09MLhPzWQhaIuzBl67yB0DTTvAMoBkrd0hcv/g==
X-Google-Smtp-Source: AGHT+IHihMiLWi4mS+U9MLzHnIRW71T0GNRhjdzDm651UOR7kxLQWwQJbUNXRKm+ie/OljuDvauLwUYFyWyyLZUYUGA=
X-Received: by 2002:a05:6512:925:b0:51a:ca97:66d6 with SMTP id
 f5-20020a056512092500b0051aca9766d6mr1164489lft.67.1713949442827; Wed, 24 Apr
 2024 02:04:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 05:04:02 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422130036.31856-1-brgl@bgdev.pl> <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
Date: Wed, 24 Apr 2024 05:04:02 -0400
Message-ID: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal <wt@penguintechs.org> said:
> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Any return value from gpiod_get_optional() other than a pointer to a
>> GPIO descriptor or a NULL-pointer is an error and the driver should
>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>> power_ctrl_enabled on NULL-pointer returned by
>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>
> Nack. This patch does fixes neither the disable/re-enable problem nor
> the warm boot problem.
>
> Zijun replied to this patch also with what I think is the proper
> reasoning for why it doesn't fix my setup.
>

Indeed, I only addressed a single issue here and not the code under the
default: label of the switch case. Sorry.

Could you give the following diff a try?

Bart

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..0e98ad2c0c9d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct
serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}

+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
-		     data->soc_type == QCA_WCN7850))
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+		     data->soc_type == QCA_WCN7850)) {
+			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+			return PTR_ERR(qcadev->sw_ctrl);
+		}

 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
@@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct
serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
-			power_ctrl_enabled = false;
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
 		}

+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
