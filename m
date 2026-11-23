Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433623;
	b=smJIhhH1EkiPBNgiqadz39IjnbW/fs2iGTnly4VkEc0jDxWGm1+87lsYKALHUBXe8In9
	 Tw+acrL7q3ik36xpIOMGsJ4uUADNPBMcypgJt/jux+l4fcY72YnI9lFA2E7sPwJy1+ax6
	 Qdv0P1sjR0HbmH8O9X0/1jnlO/V4GcSZFVCk+KXXTB+ogCM5GeGfzQ3vUZ6dQyAFtZ0uW
	 tzi7EIeRGGpAYsCxhbTpUhm7SIi4fieDI2msd9S4qdB+HQRu5QqHe/J/AoRwyrZCPZGxI
	 m+TzQPF0AldtC6LbVuQmbXSwkaXqLheepu0vkgNLPkp09EUZm/cFWVlAf5mfEQkrTZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0t9kjeZGL1zyLPQO0w84SSR2hUGkwFkQVRJA3S92NTI=;
	b=cPI3Vm3NUDlB10fwkaBzDYDUAU7uuUqrvBI3OOfF5NWdRfo70iy9apiIu2NxsaTrPT3I
	 MjsTVzVTie5RLS6DZWyk8C9slvCbWffCrf9w1+EPaEs3g+ZQhBqlxOQmPRqDgipVJH+9g
	 8FmvdxU5cRuMes4eLpvO2nNQyY+F4ZtB1t6FECDAKGxob/6byOOsBI13Ev/A15TOteTGv
	 dY5XS1lfNPOK5RmIXntDRziGw8yujbewAXdrCaNmfkFOh41BYCzs49Gc13L6bxQFr/L+K
	 L0Dq3J//Rl1ATxKXWuq5+IHFks2mZ4YzPH6RBCvh285pqhktQAsFdioeMXqosEjntNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcK9jMbt;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF2606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 11:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80FF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcK9jMbt
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f04e3bf46dso21181095ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795433623; x=1796038423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0t9kjeZGL1zyLPQO0w84SSR2hUGkwFkQVRJA3S92NTI=;
        b=XcK9jMbt7Uy4rkYiEzFv3AGB68PGgtK5uNohJ6cquSKYIBeh55LKRFWpT+j8GWxOe6
         LXuc309FLr19PvWKKKywBkZHNG1DZ5rss4Sun3DH2O9WsaB7DRisw7rizYFSmFFkp6Gm
         kGciA3VVEW8JwTkELNU+JWH7CwsmvuocbHll4j8reYedkqsPRgmG99ijsKL7jKqnH/cD
         Mu0hfe/0FGJkFTjmNS5nRNh17zkod61t56RJgnOxdpxaasN0pU01NWG8W2hjeXuFaPGf
         NrBEjOhPqaXpT2xjwqTW9tF1G/neU2s+UMMD00fM2s3PEICG8oJXSKWpraigkD1JvjIO
         dHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433623; x=1796038423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0t9kjeZGL1zyLPQO0w84SSR2hUGkwFkQVRJA3S92NTI=;
        b=DNuM0Kde0Vqc6Z2Uk9pn7kNmJAjWkHBJieBASToU4r0l95aUetgLYqGpcKKj8M1sCx
         2EejTjIHgikavllqedFkp+4UerlWfbchIAxWLKkMMl2XQwMHTVR52d+p8PnKUjtj8aY+
         KtFKG2hrNYiPBWvq0sYjeQQMtRVsYm/glR8fpQG7SanvB+nhIkmCIuHmqnhXZFoiB01L
         iG0R/rCR+rTlkePbftj3QEYdTNFTP6mjj/D8hIjIjQItTgds2HFE1bMAgxc0tUHvc4o2
         D6An1gbgga5i3asy62FxQn5UfhytAbdNtac3MHPWH27FudGBSyz8nRnYpZ06BduNVJ5T
         6k9A==
X-Gm-Message-State: APuU4Z/RNsuCRIec1K8AegKEqjkGz0WpljUwk+uxatglq6GXit5oPc3N
	wt6TBbvRpHvmD2odnukuYycNJ5tlTHlp4vHjFPSbl/L3VQw9bmIAJxhPX9wlZTpX
X-Gm-Gg: AZFdTZdbRA6bRPbQgYdHIzdkaqk6M+OUlXEWgbsKtTLIVnld4NxveIB29Fu5ehJeDaO
	AKcANw5F75eiUMaYAHiYVnE7ksJZ3gcjSzTTDXN7wVU9H3tmjKGrBI+dQjvMtELc6w23yfjo0H3
	F+rEw593KicPK1I12rXTaKojQvr5/pbV6Ye5tDmaY4lSDTg/vZKo/SYs4ACguMWieqmifreCs2j
	B7A0ijBTvKgDuSp+9YqJse3dFvS4+jSCFENo8uj+7UdYS1dZQ+hJA39I8DIDoWxtll+pj5pcBNF
	UFafDojpSAzHxT2cbyn/J+jyaEIfqVKDFV0Hdmw8bx5U/TVLSGDD8XDEdjpZRM/rBivCf15YgNo
	NoFrCMtV2FTP+z8W2v1cogchuJw5dZEOisT+WdKUK0TOub+prM+SL3P87lpl0oj4HvvtjmRe3zO
	HKtNXpNvduCWyeAmTfTM3Rjj5sTzsRvl3mOhxfAr0odxepPi94WrAFLsn1hZSwpGlCHJUNdhBqw
	ogFnx3ikSk9tIc2Pr2J2UYbeRA2YKx+dZjNa/goN2/C4/rwe93mauD096zlscMB2xUNDRScw5St
	RAWVyTqv4kL03/0aQc9OpoDC/ERe5T2smUXP3g==
X-Received: by 2002:a17:903:2285:b0:2f0:41c7:9a40 with SMTP id d9443c01a7336-2f041c7b268mr111199625ad.4.1795433622880;
        Mon, 23 Nov 2026 03:33:42 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-48.us-west-2.compute.amazonaws.com. [3.42.157.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm51332155ad.50.2026.11.23.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:33:42 -0800 (PST)
Message-ID: <6b042496.e84c8c18.25bd38.e2b4@mx.google.com>
Date: Mon, 23 Nov 2026 03:33:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7412938996580152313=="
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
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20261123-monza-wireless-v8-1-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-1-a8b38604be6c@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7412938996580152313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2477
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7412938996580152313==--
