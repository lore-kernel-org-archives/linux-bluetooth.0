Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9F2F8EA2
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658885; cv=none; b=Pvw4qwp5gaL8oCdzWDPnGL0MXPPzgrFIVkDQKm28a39+kEltqfbTlzIUB5nGcAGMZX1+1kbmlTE4BpS8lK2Qi37x5cMdgfANGAlanvcUJmTrNkdhFIgG+B69GXBn1MwpYfRwqh1DdMQoJypkd1s5duULGRIb8MvSlc0qQzJcWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658885; c=relaxed/simple;
	bh=lqLXPBsoHAp8tp3tf2cNxN1lH6oBYlVKAmopKGceXhg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sshahaMjOqO3KIPgDB21/PBOQgpisuzsuG1KjXvsKkEQ5hVQbnvDyGPVNF0uMdX711I0jVub1z3oFqzD8tMEjP9t3GZK9FtOn0bByYuZn58qZjUH2c+r6CwJyHNfB+iYT8E8WLyvV0GXisEnfDAcA1OP+d1+49RwZVWbTJKgDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzLpT+z2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzLpT+z2"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50fbd79350dso59573921cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778658882; x=1779263682; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dMkHkgi7TUUam7TMpJTLi5AlR9NnJ0Sby5MuJdRR62Q=;
        b=DzLpT+z27c2rZUj5aICB672mcsSByvnEUX9XjjxNQDHjJnD4cSdHKAnfWkhIdVChGP
         KYvmVZfJ8LK1J/XoGSdGtlPqafuufTLwItD6UV5FxdrWN1Vk6jb2G+LDe1qO5lDxUrD+
         g9ScanSRUgvqZ6lfYpEhGyepeoCevkzsQnX9FH7mhV5PRN+9xD0w8M6jf3ZuxO02w0GF
         XNt9R0LSm5330/bXMvGNijjx5tVnUjSdTcsH3daldzK4lfJY4ap3TZ+mSwdAroplhuIo
         NVxoN6+iXK69MXblAAJPRlaSN+EGqt97WI6SsVqdFHng9ybJswBzisN5O6LIVRvuzMpY
         CwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658882; x=1779263682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMkHkgi7TUUam7TMpJTLi5AlR9NnJ0Sby5MuJdRR62Q=;
        b=WqeTzKSt3KO/YdmJ7GXmgeYYy7wUg6FTsCSFSPd15E+0nlyB7hFsWQrdoVgAWSmvlu
         6lS1GruQqidcWg9GX9XRm2bvycYpoXbNXlQOCUk3mWlGGqAlZ1A/iudn330TLfJ5K8j9
         QJDXF1iTOQuBmt3VnD6bpzimYzAgN54Pp2WXRBg0Gc3cCaxIQ5X7vheii0z1i1yBv+ld
         bUrLwgfUeTKWH1A3klvx8fA3feW2NDIlWz/8j3pYoOURXZVDBD/sgm5rEArSggztVHpr
         /cH7f1iqhDWMBfqd+0yW049vbsVcZTCiTehxZ4lUwIGli7K16HEav1IIjbwZ28cC61uQ
         fhQQ==
X-Gm-Message-State: AOJu0Yx61ZEBkzkxEo0c4u2JMg8Q0QCZrksMiTw+Fgl9SKDm0oWcSQhW
	pTaRx5MWv1Zsf6vxLK54XjHBht57zG1qX2J9N6CJ7sVCDwvb4QpA35PMmtyudw==
X-Gm-Gg: Acq92OEAIHtuRZlZiBgq7W5FdET5COP6LH4xw1b31p2HhE3W2IeQvyYvtDpC7S3VKac
	XQMXv00aAXEvKHB5V7CDnnT5p83ssnGHnsAnEmzea5/I9pVYEnRXuU8bn85tKThdje702ehY47n
	Vb+wpGMoaWkBCr9TbWyHHBL4I+IS++CbhuTolEDsvtzwTIWds1USiPlvJoNJ+MZ5HU4EZjdQohO
	avFQI4Fa/sQBGMmLyIeE3urUr4BzLCLdpNAXHBlTod+MudG1kdHofw17DcVOLmFFNDRbd5CmeOa
	ir6mVw5L3nOa2iB2/+SZkqbLrMT+UIfoWHQKpDntxRLxFtGa6MWqtH4KqLKbHag1fuAeD5gBDFy
	1d+p7kk5cvqDgEGK+UY9tvHjZK3U4K0PwbT6hexj3BCtjOCOKEw/KcFIBhAkO7YzmNIawHFUeVN
	IWvPdlR1O4FrwexO99u2YF95OcLxJaAPP4
X-Received: by 2002:ac8:5d45:0:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-5162f5e30ccmr28473281cf.40.1778658882277;
        Wed, 13 May 2026 00:54:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c7accddsm364156056d6.36.2026.05.13.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 00:54:41 -0700 (PDT)
Message-ID: <6a042e41.050a0220.2e4b54.13ea@mx.google.com>
Date: Wed, 13 May 2026 00:54:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7066526880067259001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, w15303746062@163.com
Subject: RE: Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
In-Reply-To: <20260513064547.352601-1-w15303746062@163.com>
References: <20260513064547.352601-1-w15303746062@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7066526880067259001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093952

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      27.31 seconds
CheckSparse                   PASS      26.18 seconds
BuildKernel32                 PASS      28.14 seconds
TestRunnerSetup               PASS      519.12 seconds
IncrementalBuild              PASS      24.50 seconds



https://github.com/bluez/bluetooth-next/pull/182

---
Regards,
Linux Bluetooth


--===============7066526880067259001==--
