Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494962;
	b=gnKiVKQ78IKkdqUjawSczcPAcawcuq8yPnSeEkY0aVWlEYoHhUmk7P3b1PJ0gkjtL2zp
	 UxI2iExyCpMoaVS7YiAS6SKMdWTsRxMekjpHfFIBpfUSn3fJwVxB0ysl+n6FpI3rMpnQR
	 lFWBHMmWtBqZcfgC4iNBAvnmlMkC7q6gjDwzPXiz8Jrzg/V/DxhUO62n3/8r9GwZ+ZV3K
	 Ux0TACGBbx+b5Rn+aEj19Jmt8G7uAtUjhh5I0dGvEzIZjyA4gtjMKunCTZnE3G1O6aQpv
	 B9Z+jAJV4Sx9hFBQu0FLkK7tRejkLN4DbExyEhdOasQp8HE5yz+i++St96rJ2mMeauQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a6JmNtwsC479LW7C3URFMM1XNY4U2kPYHWSp05ZWEes=;
	b=D+ZG6rl/4nLamb57px6hoVAO/NECQXfzjJTo2feX4FqDKOUJZ3AzyAcpdfd5GCWedNOC
	 eIK/UgOfoF6iMG7zaocCRAywKsNyC6oBSE/BgLBVeuBMtWqgM5IG0+eFjCgX7UChuOBnp
	 gyBobcQ4l4znKYaibyx3cKQooKInFfD5GitPvQkYZD2ojF7y4V8IJAVLBRe93S4os+amL
	 XaD3fEvF5pHUMoQo8PJ+H5lePhKlXzQwymqXIygN6Wpf1kCUIC3AOr+/MSVEljCy1LFg+
	 Zx/9CnZ6NXBbPb9jH4AZZVjYCcLDwUgbRV6BSKxIT7YojLqgHNs9v5g0KZIkTAbq40A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K9RNBq4G;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C25606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56C25606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K9RNBq4G
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-57297a3f099so93525b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 20:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795494961; x=1796099761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a6JmNtwsC479LW7C3URFMM1XNY4U2kPYHWSp05ZWEes=;
        b=K9RNBq4GetSyBglQLs1ncYuWN39r31mTJx5/E4FjI0pKMviLXbV6l4oXypq/YLlMHo
         lGRb3Lgp8cpPEi/Ah/LZpx/a3qF2Rpf/eyvRrlaAeWoFdv6XWROurE5n0pxs5IUftn2a
         rThhraGLnghSxeA0F+zYYbteGWljU93wa/UkuIgog1ZGcXihi86mhpgskLoSYI3G5UMq
         amqJVA/8LiZLNNy7xC1zqK2TXzX8pExPWCrpDvLXKLsbjYBzjcUoO3ySTpyme5xJH5n3
         blWl3JjG9wjjdd4poO8n8VxTs9RsPsaChl9YOEvLuZp+1gOgcEYObof2PxTZk5N/vEkH
         DiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494961; x=1796099761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a6JmNtwsC479LW7C3URFMM1XNY4U2kPYHWSp05ZWEes=;
        b=0kvgRcM/81BmSrdzmvjvTc9q6Yns5lXzt0doralCD8sRNeh+JytJL6wQxoXGinbfVH
         +HeSGzE5EjMnIGUJEurqHbkNbCAYT3lhDxlanyw9XJYVYjXaAH+wjl9szj0ss9KOCca1
         OadBsjpn3aeurc2o7nTRTrBpA4hKIvY07V41Y/b0RugmzcM6naodQC1Pq5GlK7m/Qs5j
         k1CC728GDZW3AqhtEzRvbn+WdPwlNCOAqwnmumJssRF7iVXRtvO9hFwmUqwbmMRxvEJO
         /YWYUWUbA3rNwJvUF4lIJsXvCJu2u4E9eFcg2iK/N41UwxdQqZ5KFTBc+HGNkMHSLlnc
         jThQ==
X-Forwarded-Encrypted: i=1; AL+hErEcT5CrJOXP1ZAknyNNHYz3MpTjIiya+8hx9gGqOL9tc6kAJqUzQlKZw+ycxSFCZBYom+70+moYPnl+nLN+JlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NECILFWv7Nd/+aHrp4LMMmGPODpNUCDH2ud+qIetJ/dKUxhEK
	Sp9mEllBBxSjzftC5Jtom3hMjW2CLm9Lll5lnli2pQykhWY8RXuTKAxA
X-Gm-Gg: AZFdTZd3rWzDjceO6bCJNMrJIpyBOiXWVcPNOt78Mlzs/a6XvkXAeqg/MdvckFUbx3p
	4yEgEVRE/vyWPTUj3gH5pIBjwf1STZMY1OMbwjSh1Y7MlygVcvLUbKj9/w3qFFYDOUaoQ5a9DYM
	TsAhzzaDTzjlv/MgPdXH2dlug5LE689mv6J21AC9H09n8pYTYzveGmHYB5nZedSH2AOctrLZZqp
	DNW//lComBhEFUA7t32vthWW4HMnvvI91NJTGPE9y3trV7tcy2OWDxAEPrIfQJW2pD0E/7s0IWX
	pSlQpZ+/Zkj5zGlBW5HWNfRo9OVWQ7DrRowADxyuK+9nr0IsCR5/OI9hESTVnNWeavomU/RWtrh
	ZLGV5miW2x3mhTmSKwBh7KV1h7uUXc+pq7r1+/ofsq9W0T2eIjXK2gCAMuapYfVdyHPu9bfnrQA
	WK2YBqbQ2mBHDMsF43PYQ31UqC6l9bVn7+PuFHfUKoHsSnC09HSAyu+2EZ5ntyDQmlk4wQCjymh
	QQ3SghC13Ole2cZTgUO/W4KmQ4y95V5CqWY+CUMXZIJuDqDI4LX0CI0EgmBwiNZGqPVG5+WUA1m
	2+ULw64a3208UAMO60d+MnIgyfLkK5HD9kKg39gRr5R6edsSQcnbyf16pGiHmFOratXvma85Cky
	wTMWJ34rcqw==
X-Received: by 2002:a05:6808:c123:b0:53a:5069:cdef with SMTP id 5614622812f47-57a09b0c52emr21890400b6e.4.1795494960966;
        Mon, 23 Nov 2026 20:36:00 -0800 (PST)
Received: from localhost.localdomain ([37.19.221.69])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm14193466fac.3.2026.11.23.20.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:36:00 -0800 (PST)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Tibor Harcsa <silurust@gmail.com>
Subject: Re: [REPORT] btusb: QCA9377 13d3:3503 on ROM firmware: HCI hang during mSBC SCO
Date: Tue, 24 Nov 2026 05:33:39 +0100
Message-ID: <20261124043440.1206949-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bf27c4e0-31ac-4ee6-b7ba-afc6744e5c0a@oss.qualcomm.com>
References: <20261029013350.360574-1-yaroslav.voytovych@gmail.com> <bf27c4e0-31ac-4ee6-b7ba-afc6744e5c0a@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 at 18:42 +0800, Zijun Hu wrote:
> QCA9377 is not ROME(QCA6174A), btusb driver does not support it,
> linux-firmware repo also does not have firmware it.
>
> See table @qca_devices_table for supported controllers from ROME.

Thank you. I take the point that QCA9377 is a different product from
QCA6174A. Please let me explain what I am asking and why.

The problem: my laptop's QCA9377 module (USB 13d3:3503) had no entry
in btusb's quirks table, so its controller ran the ROM firmware. In
twelve recorded failures, the first HCI command after an mSBC (HFP
wideband) link came up got no reply. Removing power recovered the
controller; a warm reboot did not always.

dc16388d45ec adds this ID with BTUSB_QCA_ROME | BTUSB_WIDEBAND_SPEECH.
On this controller QCA_GET_TARGET_VERSION returns rom_version
0x00000302, which qca_devices_table, the table you pointed to, lists
as "Rome 3.2". btusb therefore loads qca/rampatch_usb_00000302.bin
and qca/nvm_usb_00000302.bin, and the kernel logs:

  QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111

Both downloads return 0, and a later version request reports patch
build 0x3e8. Across 74 SCO links, 50 of them mSBC, there was then no
HCI command timeout: 58 on a diagnostic build with BTUSB_QCA_ROME
only, 16 on the exact upstream entry.

linux-firmware lists these two files for QCA61x4 USB chips. Whether
they are the intended files for this module is what only Qualcomm
can tell.

Three questions, and what each answer would change:

1. Are the Rome 3.2 rampatch and NVM the intended files for the
   Bluetooth controller of a QCA9377 module that reports ROM 0x302?
   btusb has BTUSB_QCA_ROME for three IDs whose commits name QCA9377:
   04ca:3015 (0a03f98b98c2), 0cf3:e500 (0324d19cb998) and 13d3:3503;
   I have measured only the last. If yes, that would support using
   the same setup for other matching IDs. If no, what should
   13d3:3503 load instead?

2. Is there a list of the USB IDs that need this setup, or a reliable
   way to recognise them? This year, 13d3:3503, 0b05:1868 and
   0b05:1825 were each added after a user reported BLE-scan errors.
   A list would help add missing entries before users hit failures.

3. Is this loss of HCI responses after mSBC link-up a known issue of
   ROM 0x302 build 0x111? If so, is there an erratum, an affected ROM
   range, or a rampatch or NVM revision known to address it? That
   would help determine whether other modules with this ROM need the
   same firmware.

Thanks,
Iaroslav Voitovych
