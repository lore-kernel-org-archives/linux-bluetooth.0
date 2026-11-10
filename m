Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335843;
	b=2m0zdncH+qvkG9Q2ANdWxUHv2pckghQEKCEiwLI7sFc7BjAMyYEORkv43LEfB8wV1VIE
	 l84dm2YzGZac/thiR0i1F+9qhycq22qCyabq+VP50J94zn5pjMT2UjroFAQUbBbQagOv8
	 VfHbhtn/NtjdaOLl+tWJqy69B42FOBjKe+AL5FljcubCGZalcAqgUzJkl/mqZHM4xeZWx
	 AEso6ImXHvTtupQqIDX55tweTgLPFh2PwZ6VP2Rm2EcN4GjuL1CEJjfB27nfZN8ZpJoZl
	 uX1WpDiH3kD7RjyaRNi0hdNMJcSsI9ZfhpXLPVIa+5vGHlgzPdnRRTcCdGk3a4lLXNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Ywd8wkxvDiCIrccP6koiNOvJxqijFhrByejTBfj2z1c=;
	b=o+GrpcfPFqN+xMd5QKk0iOzVpm139oxlcgd4JHxyhH1S6O9Ej1+JOh4UOelUWvpQyquv
	 /egtX05qOU/YOzw1bwC8oOG/jcF84/+MhxmDu9HQcYtA2kYMs/2ilFIZ9B8dfqibHuIxk
	 ZbCTWYn1m/VYqasHct11JE+/4R5OTDMS8KPJXf/rX/aAn+2Dwk/nnJceHaZGdEIunhzqR
	 vh7ete72kf7c05eYAA7INWHFHDrKoBiZKAeWMK1dliZyRrysMKYn5rw9Ad05Er2FvA5uR
	 iQCkiZFSiQb1BaGXjGm7O6zzGwbgkv65x2q8mJL0Ie4Bw/zRgAbXYVVIBhB2P5LAIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RE29PB8c;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C3606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA7C3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RE29PB8c
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93a40a9a01aso296087485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335842; x=1794940642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ywd8wkxvDiCIrccP6koiNOvJxqijFhrByejTBfj2z1c=;
        b=RE29PB8cx8QuLmKWR07g7dOkcasE1B5eS9+pkEzm1Kl7FBNSDOV4fPhhTiEIk16zO5
         AloxVyfg1UkYls28HoLSJs/GG1YNJj/bPmZJ4VrDkByQ60jUOjCKF+x3up/pMlfhADhN
         MSnao9t68oT0hIGQ3pkNj7S5ql27LhAZz5w49JKGBm9MSeTwPBpoboFCkcQIE6UWj2eI
         TdUGvqPoS9+XjBAEpmFEERQMhVAC5vHU8qqICavqpXU0msPy+4e5LJ/75zpha75ENY+V
         sx0IQ9WDERQ/VaajPs1AQ1jmU6rlMzg5K1nbhdkhH8sosVvsSz5OBn6aQhPKun9UNfGP
         SZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335842; x=1794940642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ywd8wkxvDiCIrccP6koiNOvJxqijFhrByejTBfj2z1c=;
        b=nJMidXOfYZuOJsRKx97+zYBH4/3WvZmnDLpyAmIKDOraKtAtPIqKXFR4kvm28x3X8v
         o9JFAEN6UHEI43SoKWyxqRKrYKumkHgygutuM1unTEHVVBvqj0c0YSq118S4XB+PEMiB
         lUFMNOvdpb6nHe09a6dG4mhjLUaNgubh8xoRzwItdiu0AgY8b8SRQPHN4VzBrSfVkmhQ
         ZlVdiS6Obce80rWq3DPmfVmv+ohig26c2RhbFmARdPfeTKyfwybnCgaBb7gxDOAWO5cB
         +IhOOR9MYSEwh6GIKjR2mzbWAAQn3XQueUW7nhB27fOWNCLSR/14utSD9lU+vulYYsXh
         E5ow==
X-Gm-Message-State: APuU4Z8bHSL2a5EKEO99aOWpcKWURZwCUf4Ls8mFQYFh013OvPFFc2t+
	TjcRmRMXtJuXjjL0lI6EtfUFlZ9UIYyBiIa+izSMji57eMuLptCZ5/ZVTgGa+toK
X-Gm-Gg: AYBFou3PxRMlRWWcfzZrHryOZGcr0UOQ0NK6UR3enFXgiDnuZ5/6AlgjkcBglB9dmvO
	SVUZEkfeXqZMvyH4FnJuh6GlISf+0/eCHZf5lLl1n8SgtS6nI+wI1wEtxWijhqxIIswzUhTahKd
	t2aNmhoTUSkp5VKq51UvZvPqcMzMhVZSyvDDhT/n0bqxy0MlZ4uHFwlirp4Vt7EXXwPQ8G9aa8f
	A2iPfKPNIhzxqJU8QML0qXX39qrBCALk2356sGSfYS+8XzhFUJyRfW78nTRybGdFeucAuNUInz2
	ghYkbCRitXftTK54szL/pE65/bl/eL3O/8COQb7nl5p+ST+uJdqjnYj6mA798Tv7AHlvKhKuW6s
	yItMI50q4JTQs8quQqwJaQXBQu9FSJmVjEHlFTqB2kHBxR0MvOf6huaFyZDnBpNS11x2qnCteax
	gZHO4Nz7vzof9kGADXNR1oZuUZLtnenVOLc7LrcgpGqGVfuKDdHq/MmCop/k5L8ytBHKC5WnMwv
	RnmrINhx+QRZvEwYK6ZW2IMTx7Q3rncKUM5L43jaA2ZXs4GHJpqXu/VC/JUvJYo
X-Received: by 2002:a05:620a:8016:b0:93f:1789:8359 with SMTP id af79cd13be357-947ae88a471mr60731785a.31.1794335841892;
        Tue, 10 Nov 2026 10:37:21 -0800 (PST)
Received: from [172.17.0.2] ([68.220.171.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7ce960sm283820485a.31.2026.11.10.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:37:21 -0800 (PST)
Message-ID: <6af36461.27a8fa0c.18a5ff.5512@mx.google.com>
Date: Tue, 10 Nov 2026 10:37:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3840804627911075985=="
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
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261110163452.2649366-2-luiz.dentz@gmail.com>
References: <20261110163452.2649366-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3840804627911075985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/gatt-server.c:201
error: src/shared/gatt-server.c: patch does not apply
error: patch failed: unit/test-gatt.c:2053
error: unit/test-gatt.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3840804627911075985==--
