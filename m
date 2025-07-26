Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF811E9B0D
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513932; cv=none; b=S2yaB/VCbPNaYIzSr+1MGFZjzefwOAPSrIQwG7W6u5csDv7qe3BOY9X8M6Gw023LwQ3zzId7Ze9xBh1xhF0wgDclYV7CMX/awGfw9+pBOyEjiszH2ae5H5WOMij2/dU3oK0h0BWEikN3BHFjrLYhNF+QR5ek8EuqQEz9TI0qZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513932; c=relaxed/simple;
	bh=itCi2eNDb8hQfVzNoHUkrWw0b+4h7USeU+vfVVpB6c8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hUUnf+8m6hlU1uveM+PLx5pjvGlBXdAUvp2SYIQeczxuHa/YayRDtWs9E1CRELIlIhjQrmyIu5CIuLo/jTNV/dTVTTviUG4E7heRsYqzeqasGzU9hJhyLrgkEhTXWMdTfjqewHuxDdSaGrhyaqFwMu313E8enRjhryj8+NAYIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myS9Oot/; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myS9Oot/"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-880f82dfc7fso30587939f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jul 2025 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753513929; x=1754118729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xi66ZEmL1YCYdtSptYylmxLyovZgMLc+/jEEk5XPy3M=;
        b=myS9Oot/KMfKBDt0tsqk1wmcksPq4xGRtc4lloKIhrgll8X+OJL3D/96aKCD+lyRt6
         yUd+AvpbPX/3kmz2KbyrYrJq3uRAy29W665C0JsuI53a6fJxqU19OAxyqDURaKeS3zCP
         xsWF8BZkaKymXJzZw4OYKD1zA8glvKc9jSFff4RGiBHDMh+oEntwEfRDp8h/YAfNz9mQ
         5KHmrkU/6txn+yZ4n/2O1EkZmJfc9FtzlQvIAISuadUpDNvNdfkDQvApdZiI28aH6Wvi
         p40eXTUTVTwG6hZNjMh6X4Oeo1y+eiEiFPxtdc5h4zeNBHKgSu2FKGueA5EdpaHVcovo
         t8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753513929; x=1754118729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi66ZEmL1YCYdtSptYylmxLyovZgMLc+/jEEk5XPy3M=;
        b=SdU9u24U4texdJ3icp+TOIT5jXPOGpRZgSU61Q3ChQ3XeY7JM+goQOyZ8lZZWbN8IZ
         SVl0dmudEjqEBwzIVeZ8N026JUsUbboYlNwTWX4SFGS+gcjfoezxy4d+5pVN6uwUnOGd
         UExlG35NhDt1Jbu+80w58Jsfbo+/0HnplwrKCOuK/T8PiDkyTKde7CKB81hLCfNq+cav
         t8ypsEcf5auN07h12ZXoDwUSnpAw8kERA41IuOq/o+iiurjb2phaJUBSlEynUO4rexBy
         H7mW/h1dAhVF0I3oHGC+jBuisRAalo404K4EZEQ2auQON8F+WUk7OZ6EJdKEMJFe/9sz
         gBWw==
X-Gm-Message-State: AOJu0YzLwFPb8UXH3xFJvlCY7ZYREhnz6LyvyClbTvQSMRNcx5ERfSi/
	fXkwAz9WvUjgUopWa5sPc6ak9vzmbgb8cESc3+mj1FiQ4quczAJvThhsV5RuBw==
X-Gm-Gg: ASbGncvIdgJbkmcR0yRxlRlOLue3ugDnUONRvY/1KyxO99ND481Zy2B+4zIpG9rC+TL
	wwmnHF6S5vlyQ7I6M3x8pLWS6aTOhCAPDNp0PpuLM/D99NJqe1YV/OcoA696hP/LjL/zqvwx6xo
	7og5MEIneNNhmQ1buBJzcjK7pIh8ssD0GUt4R9H/yxiLr7Bk9Dr9Hkmd2qDjxdwDY9SFk6qSZuD
	jeHkMoQqHYhdxLnPRYmD7Dpi67rkCzjKKo8nUUZUYxs51WMq+ppDkQOyAzy3IbADnfVEx7LF7y7
	GIbZ4m/P2U1DO7IQDX70sYZi+r8Mqd7F3EPc/qJi03ZJr6QF/nuZhUf3DrS6LYoIB6zfPfkCs6h
	Xko773aumhZcgmVyAWGOG7w2Y9q3u
X-Google-Smtp-Source: AGHT+IHaHXpypecIdeyoHEQp8gmm8/aFVzxEfkpxobZSHo8GlhdJ7fODFUHjpTyssMm2iLlf23o9Ow==
X-Received: by 2002:a05:6602:14c6:b0:87c:41d0:9982 with SMTP id ca18e2360f4ac-8800f1240c7mr916801739f.6.1753513929504;
        Sat, 26 Jul 2025 00:12:09 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.161.16])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91c9fbdsm442288173.8.2025.07.26.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 00:12:08 -0700 (PDT)
Message-ID: <68847fc8.050a0220.28e229.0d35@mx.google.com>
Date: Sat, 26 Jul 2025 00:12:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1291364701478180165=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: Bluetooth: bfusb: Fix use-after-free and memory leak in device lifecycle
In-Reply-To: <aIR46cMM38E8iJqC@pc>
References: <aIR46cMM38E8iJqC@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1291364701478180165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986088

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.04 seconds
CheckAllWarning               PASS      26.67 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      24.31 seconds
TestRunnerSetup               PASS      475.79 seconds
TestRunner_l2cap-tester       PASS      24.80 seconds
TestRunner_iso-tester         PASS      35.94 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        PASS      127.54 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.34 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.77 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.076 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1291364701478180165==--
