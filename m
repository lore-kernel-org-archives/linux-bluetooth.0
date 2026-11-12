Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518616;
	b=AslWGtQ75a+cvxdqlARMzypjdyvSwI4BRE8I7yN89H8n5XeeiYWSrOj7nOie/FM+JzRn
	 MuWBzeXBXXml3I1CXsUcau7FHxrvzDA7Mt+lg4MnZ4P3dZ7PZ3SsL/e4tZ0OLTclLPPJ5
	 MxHWd6PTlW6+TlToX7VVOCNuRH9YesSHMVUV204Zhygnl42s3KauJ+v8k2fnSK4+dXEnH
	 7KVRAYfb/K4LkqlzY48iHM3MmG1Y4OAIqvHt6uLQuVjVN2GAqXUYyUCMfDsB47A446ea3
	 gtWzPrMXtCoT1gxgXsRAwZd5Uvvq9VHnUugB69EpslfmZ82Ad8rdsbwyYvIW6zS84Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YNaRYEIkRQ80P3RpunEdcqkdLpX0o7C2UAl2pihS1tc=;
	b=Fgc6k5lDwaFGsRNZ9Rf+uyX+IOeYPXg7Nm7I4u6nFagRW4zoQZa6W0mn7mylF/jNvGpY
	 sHCtZ0VhkJd/mnXVb87tuqdLPbpwpeXRWK/hPM8IkQCxu6wZOAZT6guLTEEf7PsN7CaDv
	 N+X0J3Huq84YzQZzfRE2ozR7tgj6a2Gi4mZKdQfZ1+ycSzdEaPAytzw7ZOqgc51POwRHt
	 BEQXVIkDvDKQpwhtzlPf2ruZp5DMLWWpAzuoOYEK5RiDGOq/yuHvnKzqxTMLT/fbUwjSg
	 J95GBEKqvmZNVJm0HWecvS37kzJmovNd/9fMlnzKngVl9hHQvThgmg7zWBGjgx4tZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmCq9ITf;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB4606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FB4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmCq9ITf
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso417950eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794518615; x=1795123415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YNaRYEIkRQ80P3RpunEdcqkdLpX0o7C2UAl2pihS1tc=;
        b=HmCq9ITf0Tg5VP8MWzIMyN2Hwk638oghUQI5U4u4fM2dPKWn5Wya33PEPpIMCkHwib
         4zCNDPpNQ9ZBwtIq/AjDuBH6aofreTe4sOIC9OU2boeLrM+75AxDVMOoAKL6b4ynFsPK
         JfrtcP4nYsIq/5OrFXGJDOFsq0/oWYcFOjYgQN8N9DNG1soHh5nSxZcff/c4m2a7lcVV
         C9ylCepRarcOk9Js3GpyS2g/nEZD24VvjqxggplcgrgXkDaRFwx5BrpqRNRcRddM+gdJ
         hrwFy1FxADPAc6N3jsWHpJP2v5vUVjTUQ5f6ADrV8GZrXxhJqRT3t1OVLq0uDpD0RO8R
         ZENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794518615; x=1795123415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YNaRYEIkRQ80P3RpunEdcqkdLpX0o7C2UAl2pihS1tc=;
        b=cy7KzYlxOEv4R5L87d3TN5lgE30FrJ5AluppWhm9CCpwmTsvXdYO06v+kW3xLINBc6
         cdJcS5jM5lTCtPeQcGxqt4sRFy+7ub8poIXMuIhHxBqCnFoHrsdsO/ABIHMxdEEZbuD8
         F6hLtjVd2ALpRfNLyUjwxnCG5vh9zg2vgJMswJ48+O/ksLjYjifNyG4itY23cRXsMEdN
         KGxkxcMhplD5WPMIB21kGAIjBTjdNNXDq11IGDBHNXkHnOSD5DkC71OfUtmo+SFRpYEt
         jYmqR6E4B/DocHszDzH8ibx//lWtT6U/oK14MpVkEhppPQq+Hu6703CE7tH+SiNKJFNp
         PlVQ==
X-Gm-Message-State: APuU4Z/6GSk/Fv6vK4xlHJ/gq7s17KfFkQyjYys2IakYFf2626/3DLam
	D4Yy3qHRbepnLaKBQEwlv/W89DHBh8JVl4YorW7WdKHzQ7H6iOX/lmTeI18CQQ==
X-Gm-Gg: AYBFou0iqU/NRnvj7woE3khZ7T+qL1ZYB7GZRQMLcd2v/Rnb0L3IZ54nvuKHbH3XVoF
	hrG7vtFfE/Hm+QV4DKjQ31EllRCUmoPPwvlaKev6yuwlzMp1TuvNkPIjEYIFlTnt8C6tanbWNOo
	l2k2AC8Eye9heXJyq6dmtOmgNayCReJ7nHc39z07mVEva83QDDCeVKPevz77K7BFRm9sc2TNKxd
	J0yyqNp9+UptwyTZcHjhFt6HsAp91z3mahL44becZqHwHk2lqLGvnU7G4cgo6jlQlpqFZAqii9P
	zBO4TfqgcfyTsdcspx5onSZ0In0QgRfSRIql/tmtdWBZpDl0ng8xtarisBbU9IZtq3AY4I5fD8N
	3jkIMeYo5dJMrnI0k0pcMXCxD7lS+tM/IW8ElWFYdgOccNj2YSIvgLxrNYVVmA8Dl1+rrOxYo7/
	970HpudUPTxHImjrZmuTQ32RCvMqR0+gaimwtfXnh5Zz1i+SqKlX5P79Ibkflw0n9KTvo3a3u8z
	0Agkeu0WZvTtJJ2Eru5pETrrewIsxjZBdNOf+3c+HDaK1iFYJgioORdJsNiPg==
X-Received: by 2002:a05:7301:77c3:b0:376:f1f1:bfaf with SMTP id 5a478bee46e88-3796676c129mr320437eec.11.1794518615158;
        Thu, 12 Nov 2026 13:23:35 -0800 (PST)
Received: from [172.17.0.2] ([52.155.39.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm890955eec.22.2026.11.12.13.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 13:23:34 -0800 (PST)
Message-ID: <6af62e56.d3462a00.20d635.351b@mx.google.com>
Date: Thu, 12 Nov 2026 13:23:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5478516122867107793=="
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
To: linux-bluetooth@vger.kernel.org, daan@daanbouwman.nl
Subject: RE: Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
In-Reply-To: <20261112152426.10335-1-daan@daanbouwman.nl>
References: <20261112152426.10335-1-daan@daanbouwman.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5478516122867107793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209701/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.60 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.33 seconds
CheckAllWarning               PASS      35.12 seconds
CheckSparse                   PASS      38.20 seconds
BuildKernel32                 PASS      31.14 seconds
CheckKernelLLVM               PASS      34.71 seconds
TestRunnerSetup               PASS      753.00 seconds
IncrementalBuild              PASS      30.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#158: 
  Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14976888.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)

13: B1 Line exceeds max length (85>80): "  Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111"
37: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/1123

---
Regards,
Linux Bluetooth


--===============5478516122867107793==--
