Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993347;
	b=agWvms1/gkIQjPZuC+md1XSYNTixy+Mi9ntyE4tOe4UM+AYD+wB7yy5Y+k2cB9NW55II
	 CsuTHxy/92J7uobsdq3RYLS5qw5vf+iInO3rrgv6AKcPOEo1wENUu8b9E2vWwxG6FMtAi
	 R+m5SP45hfJ+Jwx5IYG1Lz6baHazGxDnX//+2hAJGMIem2mwn+gxREGjELHCVKCkoObof
	 Vxr9eOHNddRmFDmD3+8Z/ESzpMndog8sj5nPgIi+KSmN9hvDGYcR4FsVa5w4zXalKewYT
	 lC9lUSFvip31ahSmylh9cf89yaJgQ3sMvoSDL9pUddzC5eVCO1xdWsovB2kyimx6kNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993347;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UiuovoevWXu9XJy5bFhJVWdiIRXYyIvXEQ85Dby6mgk=;
	b=hsJ6zpvYgIFsOJMi69ITIwpJzy4zcz74mmZrexC7SS7J3VRAYDpp9DGrKuSbmOPWDU4B
	 9jJCKx6eT2T8yK8oqt2929rUPYXJBIV+FZrLghagnz6qh5qotH47+n5ECDqwO3GlZs6Wd
	 ibFKD9VquI/4muG/iaihd4eDgUBtIG6YWrYZWqPUVnaiAv6Hb3Z7gPy0wXvfuEGgXBun3
	 7eHTTGJUrWbZadEnG9JlIGyZxwcAtOw/47lIMRPs16EzZUqHlegRb1ag3ujK9Kv4e33ai
	 FAPPFKdxmJxrnNZaUBU9SK1bymdyg97vuB16VHCIUlpv6DuEm+HKmsYdN4TjcUbfqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=lr0pDVYh;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23A606A329;
	Fri,  6 Nov 2026 19:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B23A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=lr0pDVYh
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1793993345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiuovoevWXu9XJy5bFhJVWdiIRXYyIvXEQ85Dby6mgk=;
	b=lr0pDVYhUQPa9H+L629Nktye7hj/QSJsIRxA9WbdR2ytXVKmqkfkoophSyk++3zuwFfL7H
	bdnDX5VyBVwCzYPKAu+6l1VOZ2EXnE68Eo6+ZyT39j94nqhtlw4dnZgpV5j/iqOJusp+Gy
	vLdB2bYKUWd2O2QkigAr+yW8UhDRjOIWa/aZnOklUNLjLYNk5i9f6U3msoSHuJYWeQ+rNd
	SPn7qLXrBmb5V0tw66XpN5mLONU/XI+Cc4pBFUB+tGNnXTjQE2vbZUO/oJx4zLFmJ43HtI
	Dyi4XXq3JY0BNkm7mn38ktaOjVwLMFAkrGNnBMIrGrFeVh1dc4Nqpdh9VqcQQg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3990
Date: Fri,  6 Nov 2026 11:29:01 -0800
Message-ID: <20261106192901.1930168-1-hex@freenixos.com>
In-Reply-To: <56866622-a854-4aae-9e97-40eecc4adbe1@molgen.mpg.de>
References: <20261105201952.1556185-1-hex@freenixos.com> <56866622-a854-4aae-9e97-40eecc4adbe1@molgen.mpg.de>
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

On 06.11.26 11:57, Paul Menzel wrote:
> Does Linux log anything about this? Maybe, also paste an excerpt from
> btmon capture?

No, Linux logs nothing; the packets only show up in btmon:

  = Vendor Diagnostic (len 492)                      [hci0] 0.761331
          dc 2e e8 01 e4 01 03 00 0a ff 10 04 01 00 55 53  ..............US
  = Vendor Diagnostic (len 481)                     [hci0] 11.334015
          dc 2e dd 01 d9 01 04 00 0a ff 10 04 01 00 51 d3  ..............Q.

I will add this to the commit message in v2.

> Both firmware file names are the same. What is the difference?

They are different builds with the same file name:

  OnePlus:        BTFM.CHE.2.1.4.c2-00002-QCACHROMZ-2.184841.1
                  (216380 bytes, built Jan 3 2019, shipped with OxygenOS)
  linux-firmware: BTFM.CHE.2.1.3.c7-00024-QCACHROM-1
                  (177060 bytes, built Dec 4 2018)

Both TLV headers report the same ROM build (0x0201) and patch version
(0x0002), so only the build label tells them apart. The controller
returns the OnePlus label when asked with EDL_GET_BUILD_INFO_CMD;
btqca does not send that for WCN3990, so it is not in the kernel log.

Thank you for the review.

Hex
