Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47E2C17A3
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127824; cv=none; b=RkHBLPHek/AVsUuHueKpmH1a4zr6hxNxD6TwR/WevFyaTV0IcBtO8hJzrNWZIDPQluNxXYiybHwqxps3MoQJZPSvCV2y0FRd/QX4PeUcNvff1pZwnHlTR8fYP50VfOjz1JxSaMHKWhDu0pQeFQ+sRnLE9Pwf2yYbNMIRHiNQCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127824; c=relaxed/simple;
	bh=AbdEzrBRM9rXqOwp/MhPtICnS/OzLrZ3S2RNHcpcdrA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ouOsfTuF/nw5KS4B0PGMXqrPNQvjufFqlmI1l01OaH/L1LLWLBGk49gMpMXVhs4jXfx0mJPYe4l2+Ian2ltKuMoFznwSGpWALGZN9R9jVoY6tk4f7VYawvgoKQQsDfc79vCfuXb51okpWDJ5ldk5OlbGnY23xCDVsaUjSpWXyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN/DZqb5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN/DZqb5"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82109f51565so2529443a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 22:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792127822; x=1792732622; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AbdEzrBRM9rXqOwp/MhPtICnS/OzLrZ3S2RNHcpcdrA=;
        b=cN/DZqb5Sc3IMt+CSKY8OAVZRYbFddFjWTvNSgO7J60lQCUjX/ARhujk/pEUk90CAO
         guTas7K69iBYsvjhYAahKGEWQpT8rwjUUwnZs8dyzJ7iJr02X6kc7ZvglbKoSZWAQaV3
         JFnCRHQhrs+NiMm3F+H/ziep0i2Rod31GEzlpsULtNrIxipYw3MTyEfFNqRaBHGSfHaE
         xHCIJdtIYhmtnlb0MmZ9WsmJr7ExxSrcscEw9T9Ws0us2H22l0KYJ3HJHmlW+e2gcOpl
         SAu0eixJk/HWNaMgOnCaxFDT18wq6pF+0qzOHrxT8lHMBo5PPl+LLNrL6444uWwmNa/C
         2Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792127822; x=1792732622;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AbdEzrBRM9rXqOwp/MhPtICnS/OzLrZ3S2RNHcpcdrA=;
        b=Oe271KkYNonIaXMu22daK+VP6fKVZdFwlt/WBqRPR7/ryHIM3j3N5QrTGLO0P8WWiu
         yEydNTN0VWVDMWmrmRaCDciNC0JvDvptuqxc9lA03rzsDe9/bBK2crRvUsIvXyb4elCx
         M36rO3jMlKW71sL5Cs63rp+hHlciO+59/E81eZsYAKcaegQVvR9s/yBb+6AJRtkDT8ob
         7c7p4vZkfXTcQRuLFsabK54yeXgDF+8bNm3GGLThQUmZyH8ttZmQcCxIvOoTVSYDk1+h
         0h5BHH5ZfsuftYJzhpkAdAzEzKNsq4onCxJxxrJI/rFaAFZv7hLLz1mwNo/neMKBTbq6
         II/g==
X-Gm-Message-State: AFq9FYIQL6gcSBctOzdMMp8MMhbXlwm3MW/OBYnJr4efx3V8PngONnlL
	7u5SVO3ML+09FSMzV/ENjYSfuj7jUgL4PrlKyLZ9q1UKpldJhXGEmf/9TCPBpQ==
X-Gm-Gg: AYBFou1bgpFqZSyt1L0WsFUsw9Dzr4c1xOOdPb11G3YZUs6+ICU6+Zce7Ia2IScwhMR
	/5/qMix38aV/myCRW+DfUiHnGEu/UUk0kyydpLQYaF+j+cVI3LReNgWubCx5b+weqFypNLdRiIV
	lPnmlun67JfI2sjyK8nfdioU31UvEovKZH+hkJ72pCgkja6YfYS5ycP1fdUhwxeBigoa/dIzbaa
	x8kjZdDTvu+Empi+6HSUZQ5Looz7k1v6QWL3O6MctUMZVEKlNj7TnUxeSNwPrmlWESO9XQTbzFs
	FXXGxAD2K0O37B/BV9cU4YpDowp2kn0cvFNBKV8M8BeIxjGgI0g5uzCU7tBeP46THxoUTGU7A8x
	pVz1An3DZsm+N3xQNIucMUvK/QD0Xf0n4FRYzaDKvTn8cBwepoK7jNgJs+My7HnBvYWLZpRjEXu
	VwqR3OCVO9WdPMRbp2osQoZ47a/ExjCjBxq+xq4zbVFvgPksZm2X6UX5ouXGpTgl0vGc2U0jxGx
	A==
X-Received: by 2002:a05:6820:4b84:b0:6de:1071:8b1f with SMTP id 006d021491bc7-6ef0f3aad3emr16606822eaf.55.1792127821720;
        Thu, 15 Oct 2026 22:17:01 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.6.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a55cdc7dsm983303a34.14.2026.10.15.22.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:17:01 -0700 (PDT)
Message-ID: <6ad1b34d.f9614c1d.be72e.ad70@mx.google.com>
Date: Thu, 15 Oct 2026 22:17:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6869654837680323388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, artem@trailofbits.com
Subject: RE: CVE-2026-63974, CVE-2026-98297: backport fix series
In-Reply-To: <20261016021047.16461-2-artem@trailofbits.com>
References: <20261016021047.16461-2-artem@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6869654837680323388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:5349
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6869654837680323388==--
