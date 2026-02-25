Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B133CE90
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012951; cv=none; b=P1xb4iJjioS0q9PE6q4Vmjv1+fma1LqLVAu45Twe0sxO/Ck5PMy40g5uZ8wnx+CCJJ2LGney/PU6NI0p0tWOlD5xGF1OZ1t0g7B5CtdMtaO9zQ6khyaWUkiZSTQWZLgasCJ7bEugQeFbyzEYLerm0h9reEBUAfgyDspqt9bF2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012951; c=relaxed/simple;
	bh=aPkKnLWx/rLAeB2z6QOGylFvXmeQEK93aJVNnn90ZjU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E4ItFGWddRn2ff1RFy40wEi1GrZoz13izTtbUMq13oe7pZJ0qzYiiY/oNSCArRljOa1hTPOc+7PVKReOeZDL6IJ6D+czLgPnuuw47ATTjdTj1oFhV0TmpvVitobu/VHQBewIbjhSg0aITgF6N3QHmE1/WjfgFGJiqKDS+dQOQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW17oxYW; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW17oxYW"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2bdc4f2b680so362283eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012949; x=1772617749; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aPkKnLWx/rLAeB2z6QOGylFvXmeQEK93aJVNnn90ZjU=;
        b=nW17oxYW4r+f6O+dZaCph1pLvJHiSHasYLu/8jymKdR65jBV8LOQYRa0bgf2IcXHcF
         GRmAioEW6Kodx0H+bPgY1KHwWet3pWBbzxsCOaCDZHbXhMf1Uo98GdeNXBK6fbmUTXzA
         l0RQiuKzXGOkuf+ZEpcgVnOruiovpHSt0g5nFSj3qSF/1EtkLyqUMbtnHxS95LKKTuUs
         +azmJdVE8N3gRkfATgkhFMIwNRxZshPQ4smH0ezTWmzRAYxy6Z1wCGVIVdf6Od0KR/kv
         LW0mNsALr6RSNu3lYhEi65HXr7ulWqTdfINEoeNUyutHHKzU6tl4rAKCIvx0nimzxnsK
         2OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012949; x=1772617749;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPkKnLWx/rLAeB2z6QOGylFvXmeQEK93aJVNnn90ZjU=;
        b=GhiQsDQtRx/uuPHjBKWbvncMZ/jE/uwXoSBiDbXLUl3XwO9+Q2vNR/sg4r8kLKbuE3
         MIYknTpG070zov2X4FIs7tb7IvE6x20nwoY2uFM8ElInSwUKQpChwtGQpZ/rCVXugp55
         JZuAWMV0rKZKadmGyoljiqWjpBIriNTXpi7M+4iKwVE0Aw3qYsv936clRx6H4leulXnY
         +SmjqKaDu/y2qfJpN5uzipIaRoBvj+QwLm+GJhcAYhSl6PdOe7jBvSFRxT5Xo700+Can
         v43GqBjQOQKqUfWOsA287hKeAtD4/URjHqMPr8A/q0nLQqgG7NE9uJYcnB0uMMTGT+66
         UzuA==
X-Gm-Message-State: AOJu0YyMdgEObzj0P09qKxDHIwJ/uIF6GL9Rivepo+xiUZ1CzxQR0aa6
	6TECvPcUXdaFx2zGiv9cSFRiZvFq+kQrJzMUCcwXIc1DZlKsZy8hXRvqWRrmHf93
X-Gm-Gg: ATEYQzymjnEHhAS6fREDd1K3BUqAWXJIJy2qJ3rMJGbfEXrZ4gQ4e9N8coS4DtVJsFz
	JcGc60/tOHAoM1Pdnlv+D3mrIKj8DVsA39mnuJpJUnz8Zy2dq/rzvX4xAK5EpstjWN3oDFrWURn
	brOYoe14OtBtExgcr0+hxJYz/DyUy6G9kPj27/CK8Ezd7gF6hbg6anr6q3CzFv1SmLjdhG4kxAO
	H5FPOtDeDfXP3GX/Tdio1ClVs96zVE9xwO7gYQ2keJQHPBkqlMFIeTnv/F8+OBhUrolMysalpmX
	owPnyGww92G16PbwgctWJfUBgbpCJh2U8L9trwa0w5xXL//5q6smBtgBZ3z63N4QgdNSGzub4cf
	yncH1FdmfLWQdUnTa+XIupJDwzSJJ88b9Aux3AdbRQPaE7AkMjZgO5GmxBIYFxYhBl94d+4iofC
	s/a0xVIyk+ePfUUq5zAvRuhtG67ODVSw==
X-Received: by 2002:a05:7300:e8a3:b0:2b7:ee0e:e9ca with SMTP id 5a478bee46e88-2bd7b9e708fmr5821789eec.13.1772012949224;
        Wed, 25 Feb 2026 01:49:09 -0800 (PST)
Received: from [172.17.0.2] ([172.215.217.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da47778sm8754699eec.6.2026.02.25.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:49:08 -0800 (PST)
Message-ID: <699ec594.050a0220.9c28a.7b8d@mx.google.com>
Date: Wed, 25 Feb 2026 01:49:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2612184953359978753=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: [V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
In-Reply-To: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2612184953359978753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qcs8300-ride.dts:107
error: arch/arm64/boot/dts/qcom/qcs8300-ride.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2612184953359978753==--
