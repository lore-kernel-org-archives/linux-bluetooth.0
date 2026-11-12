Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500324;
	b=LeJs9EM+CmqYVEmgmNhZ+wD1PuQyuiuk1SdP61G+ZHXZyW0FN2djP4oIJN/l8HRfZulU
	 thY/7w7Pg4SEwtKM2i4L7MtUl5V/X085uWyKqYPAdz/0UGefNmoZCXJ5GmGAZkq3PtStI
	 WJK4Bo6gI7vLmMeOLYp1HwxThlu0bzS1fFhXVNFLlnFrakgjk7RVbHGvc8M+ve4TzbHwD
	 qmdjuJJPOuhYx75eDMky6KKOSav8f37wiShT3OY2J6lYt7zxnTNYF3kkwxgkdIzHoiOAd
	 ENw2UNurvVHMgJ44OJNhiQSOFQE8cVDedyO0nXuA4xrLkSTYcLEpEabMUbrC/3vVvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3M7UarYmgVPGeZFATacV/OUTGiOuLLXmORrf/yDM6O8=;
	b=Wso73W4ja7ruWf5KLHRE/e6+cIyM1HrUM6qBZ2CkoXZT/y4uHWC1UjijeaoTHSU6VGrz
	 HL0KIaOxJnFdBZqJIWpEcMioXDSc1mSNcWxvNWp4xyxX82laacwr/+pRgxGZ+bPot9w60
	 sf4myV/M5K2xRkk/7ixEiX55zCvRikuZFG5r3LJTfwKiFsa9KrXWtQN4xv0b2Py6UE6E8
	 U55WSnTjMr65ho3pclzjkZlIRcJKdHuHy7USQ6veqoTxhhann1RzoKMMHrdqw07ktxK5B
	 a76stKMowea/V6LHfLBOG5rkwTJ7VWGaIq9nFWrxjevnrxEjKjEEwnCOPtjcJ6dXWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2BH5zhm;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93939606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93939606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2BH5zhm
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ea2e29d90so12147996d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500323; x=1795105123; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3M7UarYmgVPGeZFATacV/OUTGiOuLLXmORrf/yDM6O8=;
        b=N2BH5zhmLvWWCQwCPStknpDsVab5VNLqez98oCOS3b937Oem+Lvbk24T5fuzHf2E74
         epr/WEC1p5ptUkqCoSKoigPxPR/+hOg5E5N6Jqh9GTGNi59m2OjGxOiRbZIZzphnDm25
         fZDgzfzzS18iWV/W8x7UYSVoCKWV5M5Jty3msED+ozgm0SW2wxBgRXJptgpsnzE+W2pu
         ovBwBjgsGVQdpC3V8KGRI2G+i3qfpO6s+VsH7oMEjFOMTLTrU7WCfWwDsEtrRBY09bI/
         VdjP4W93PsEjbe4eufuR5V8Vi2eK0L6z5i07RJIvieqcluJ0TjnMf2ggs+ol0WJKpWeC
         Oxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500323; x=1795105123;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3M7UarYmgVPGeZFATacV/OUTGiOuLLXmORrf/yDM6O8=;
        b=vg2H/SLHSteAtDeXZUDIxE3i9i7O+s2gJ0QtR3V33QHDV0v/XC+HTWSwUk8AELiFBV
         qU7zyeJLe4peV9IMoMm2RAa6Wwc83TtyIt6LPuwzbRj6/DaquS32Rgjb7y8AOwklzFov
         N/S1amT9an4kGu256AXUjFtakxJVPsEQPRO+yRfl6shm/OrnwIOXKzz/pWN9U79ZfBiO
         cp9uXuXPi5Uc0D8e9LNG5SKgyBhaWg+8c+hliosI+v/8jgarqnQic90uWxbxYEF25U04
         jHwqfTSIfITOP1tbndDMsC02V4BA677taZOXP7TjDdby2Io9pu1xOqCgo+NomgysWKql
         IyCw==
X-Gm-Message-State: APuU4Z+2iAVVqAN+loCbyuKfVJw2Ps2LB/ux2UmqJhAv0hIHaqrT127L
	mttdcoiBL4dm5x9KSAqGea0D5+cU1+N521VC/evjpdN22Xa3py8cVDdlmonxcbl8
X-Gm-Gg: AYBFou3COZmjtXuntkA1UTyam0Y0Z2f9El13bOaGNMfu4df2FGbGpZIZGDmbSGZUULD
	uLrBRMewJzYn37zwHY9RtGy+neT8tN+kk5tizmh7UrxzfLEFhhT9d65ud2Bq5Y3j0kxX5Z+QZcb
	lFIWGwrHAeyF7LCkqBtVy2VRiQZbBtCAjPC3RLuggu+ZFEJpC0dclvMaOp6AvBPwNUvimai3iXU
	ndGJj8GUY20k+PMwB1/6tcDQHKnSSz+huSArgVxP4omWJe/+xKm9hQSUdSMo4cUEAVrdbRmw72m
	VgoliPMeXwHyg6ZgcJJGUL+eu3vWKdQ2nSsyTDj867xbUihVWoyUgbJf6IXPcfTXL6J8my4Wcv2
	wx/8Lu7cKoo2nbD7joyouFX9T/2FVTRVUh6hu9vZNiUHZ68klB2LGdtJjUjDuM4os94aExG3Or8
	kk2i3LJjW9OzXLyI1sfQW+yzis7xYtEEIlcGSiGz41v2LgbW44T9zHgthotHSZBzkSNSPimBFGd
	tp9kcmdH9hrKEejkTm25I9q+klyDGmYb5EHALWKHjDErR9OiIKIt+v5cipnLA==
X-Received: by 2002:a05:6214:701:b0:91f:1578:8c14 with SMTP id 6a1803df08f44-91f15788cf6mr32157506d6.5.1794500323477;
        Thu, 12 Nov 2026 08:18:43 -0800 (PST)
Received: from [172.17.0.2] ([68.154.79.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02ca1ed7sm50685646d6.24.2026.11.12.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:43 -0800 (PST)
Message-ID: <6af5e6e3.b3f5340a.a81e7.c2d8@mx.google.com>
Date: Thu, 12 Nov 2026 08:18:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5587885578492465719=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] shared/bap: Fix line over 80 columns in set_base_subgroup
In-Reply-To: <20261028135517.2395290-1-luiz.dentz@gmail.com>
References: <20261028135517.2395290-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5587885578492465719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v1,1/3] shared/bap: Fix line over 80 columns in set_base_subgroup
   Pull Request: https://github.com/bluez/bluez/pull/2731
   Created:      2026-10-28 15:20:57+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5587885578492465719==--
