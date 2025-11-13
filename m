Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805435293B
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039562; cv=none; b=vGnWZduzvPcdDA3QNUJ5GiUG+SW7oKg/k3df16fCOYBaQQj1AMu+QXBi8s2OV/UjaPGL3GI2jjNn95dPCL27Y9ry0NvklDUZRuLlDb2BlIZqaPMBEveUeYMi1AoThxIfS86tiGgvLvazZBUnp71AldlS7FtoMgQK98ttTB7s49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039562; c=relaxed/simple;
	bh=v7rbUJhLwMgdMItk1QSgOLQY8/yf5OJNIdiSb7NFqLE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pnShQguqtG0G/PFCi4eAK/aXQGeexjqxADYRZEW6X5t9s9CbZ5zyMG/GZtMFM5NoHKoKBJOHkRGfuBgY8gLVhDmSUWkQ+bWNZYZCm9MNyBBsd1xtFb/x3XBZjH/LlxunL0FgLcwvzBrPUXJhwnSk102XIrlOlSQeLDKkBLfF2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mseLCQBa; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mseLCQBa"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-948c962a0edso36285539f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 05:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763039559; x=1763644359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v7rbUJhLwMgdMItk1QSgOLQY8/yf5OJNIdiSb7NFqLE=;
        b=mseLCQBaSAryPT6oGXdgxvzMr+E+zI4xJH9RR/uozngH0Nv6KxSg1q+dBdMSCZEXEC
         hZ0AcRAgsL31dWjCleA+QATobx38RbCiAf3ttOJVxoH4bd0/8IiDUwUXPnIzGbjFcfIR
         TO5hxaMxE6Ds1pXEzs3bJMtgCUoydPdUVMQYI6Iru5lr717wkH8ZrmVRsWzmaFSa3qVu
         /FP86/EL6GJNgcBu1nSCSBb4che9fW7gNYSTcnKwFoewTtpUXXXVUo4PmUDtan5MkJy5
         wYvu2CJW7Ae2zFa/DcSuFIh0OfWArkCodwOexggOblFbJWW7SvxObB62ZKlM3uRoY9ww
         f2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039559; x=1763644359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7rbUJhLwMgdMItk1QSgOLQY8/yf5OJNIdiSb7NFqLE=;
        b=JbksfwKSyyVNBS/iafkNENyDgU1LwHCRPeWU386djHR4b7ECqXfP2Cg4cJu76p0dsy
         R8NTdYZ+kfD5wG5REuSFY+ZDvsD72zgqaDiMxDiODmUKBTZNHzFSPvgSIaWWCXDczf1G
         CabrzJvYQAeSoaiKJaSNHYNJHxfmgCVnzAv7EW5WCHL8/xvQYEqg7P6TCrtg8dryWIQs
         SSRCdWvcM2t7KXZiKDF/L5E3lqloG9/T+aDm/DmNr/2j7kqGDot14YNlVX0su4ZMO9bb
         LZV0DXlTbIq6eEUtVL8Ddcz0n7VM8kKF/crjPREt4Ey/Tu6so2Zf3u1VJkg5+LO9ZGP0
         e90g==
X-Gm-Message-State: AOJu0YyOong2nhJoFyN2EQoScji+1fvpwTHzKmxdT6e5AvorBKaQRhd5
	O8nB8Kyw6GUzsJuUyNfBP5wezgFlG99OiZXIdsXJKjxu+9+oxitlTPBlWC6tkf2Y
X-Gm-Gg: ASbGnctbIe86O22rcT0u/sKmAszeI9PNHnRy6mMfeZCMZ2wVQh67CGEPNLNDvGd5CdL
	VAnRVa6cTIip47X78mGKVkCghzPDRqssllBtZDUEn1cxnQ6zRx4tpS5YOVtISRVYKGcR3Sal0L4
	QE9Wgspkfnh97hErfR0HY5bb1Rh5baH8DBBRpMgxe5/c0rEWzkMw2OZ6/642+qpsbJE8XRAzEqz
	/1ie5qr1UJ1lQMQXGvOkZQ8Wu0+4psYysxAxOc7JSy31vX78gki1RtLV00Q98oCqVbXNNcwSxC4
	5hMjOITEYmZoh1PMpydVaWq4xeWn8k6mXedBalZis7oTYFYHlxq4qvIe/1EM1GCTndKcse7UgwB
	E67+VsURPJuluFK239xf90I2sHEcWUqXNNa/mhcUY0sXBG54jaLNbQjyh7SgY36+jHboUZS9eSJ
	KuNFsqUTI+q1k1GO/av4YDImUfcsOh
X-Google-Smtp-Source: AGHT+IFKzMMwSNLMjVkcJ+lqTSYVgiE5e3C94OCA2mozh4MNhpR3xOG/RX62FtNP0u4ARU4RvszFsA==
X-Received: by 2002:a05:6e02:1487:b0:433:795e:2da with SMTP id e9e14a558f8ab-43473d3dc49mr81192985ab.3.1763039559414;
        Thu, 13 Nov 2025 05:12:39 -0800 (PST)
Received: from [172.17.0.2] ([64.236.135.131])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2d15f60sm66069239f.10.2025.11.13.05.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:12:38 -0800 (PST)
Message-ID: <6915d946.5d0a0220.99d2b.11fb@mx.google.com>
Date: Thu, 13 Nov 2025 05:12:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0048434311632578007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wei.deng@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
In-Reply-To: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
References: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0048434311632578007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qcs8300-ride.dts:71
error: arch/arm64/boot/dts/qcom/qcs8300-ride.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0048434311632578007==--
