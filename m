Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E542857EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964459; cv=none; b=mQEb3jiEox8BuvhR5GFM7oeQ9GTXgnCWCxgsu4DouUr2hcAoYFoCgRtHTkDORDn1PxV05Hd8LqIZgaYW0g6TtCbFJgbG+SSC+v8uHEkGyRBC08Rz7nC4YXfgk/iV7sruSat5QFZGXQ9dOKw/tU5cJW2fPW51Tlt+z+MCcKWTiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964459; c=relaxed/simple;
	bh=TPxlAG/gP8fM2GDztIhwEXPuIQtg+D3tLV2PTc3G648=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aVUo5C8wBF5QJyfdNJCDmAc+0lAQDtY9TAdueMHx5Fr1fUTqr7fX86m+yF8BQWa2uEKRMUq7yhH/vSS9XMahYtyBEPcbtU1J5c2GlzaHiF3C9zq+Xo243ijlmJ4WNkLYzU9sVzswAVLP1QxuIyB8YZjnydDko3XT/o/v0yO8uNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3rJJ00C; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3rJJ00C"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso4875849c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779964456; x=1780569256; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/Vn+KSZK6EPfIY404OnO4okmuKWJmRWwqZQ/1od+U=;
        b=r3rJJ00CR03EzluzNndq2lu0jcHBgdwfDsEhDeVwkocq+vLRX/pBrndwT1rOOD6+L6
         bH1MGJsscuW5n2bTA6A6zt+ySYkFT1k1fPSHwQ5s1e7nh2AiacxeVLvUUSC+PnEa+k51
         wqZWyNvXW2YTEPCo0imbGEDxuUOZ8Bp+hhjtgHH7Z/Qu2ATGqxce7eT4u+6a6dDiR8kl
         FAvlpzxZN6NdD1lWNDOa3eBq78sQx25u5m/PQ20ndFUWtkPns1gs93dLmHWTgPnPjJGP
         YUwfcdj1PB2Vb0ZRt8ePGpEXi81dE2D/Q3nigdeOLFJPkISafLOO6CDVlDiSD6frxf+s
         Fyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964456; x=1780569256;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg/Vn+KSZK6EPfIY404OnO4okmuKWJmRWwqZQ/1od+U=;
        b=O8a+ML4gaDWZNyIRbtJuys/G786qORsxFuGpRQ7obfp9IFvhU0aU25QT/5U8HcTe1t
         OT47cN9w+LTq78/duNM87H38My+leEtNS84aAXfgDtssInhuw+nrfiRKktkMO4MYse79
         Tng3Ec+nURnfk6awLl73nI0DgesoGMrMEX8VIO54cwswd6S9C6PiFu8d4lCjjX0WpHEJ
         ld/AadOzUsE5MIbaRoXbPDPAOxKNg+Yu4ZxGfcMi45xpQsoZoPediVIiy/9Z/WGQssAM
         i4acIwwu/AR5v7i1WAVS2LahUtlGgwFvQ/iXXb5yXyWYNcwlgd2kQwjd1BmVYaKCPrNq
         Cd5g==
X-Gm-Message-State: AOJu0YyBesDa5qrBaG1GMA5k0QroUxQiErxcsq54dQRn0cCKE7UzOZYZ
	v1pif+33M7NVbjPwHwqPKssJ3lN2JiII4QYbz5R/DdB0vYWQymHi53S31b+u/Q==
X-Gm-Gg: Acq92OFoOKLEPy1fpSk2v710KbN5gHwHXUKMyLt8vag60LU0TlVZ5CV1ZVw9agQlnOJ
	M5BVPtZTLGnFGV5Kkp+9wJcJay+kEGWF8xwJagHvsTHt8gSzIbQiS0PCrAeMMsYM0MQDh0r3Fjp
	Qso8W1QvkZuPu+ayC7RSyKCznZnmuo1fooac8JN5cleWV2NEqzs2/IsyLrkANE/1ka6nl5q5ZOV
	LSG2PPsp+b1cIIq8tkHliUo5kW+QVXesKQauIF5BoDh3XeanmhCgOmLoFnfFZpxl3wKvmAlWGuW
	wQYQP+cPTvlyIrfxsHq+za8X2AuXjqZLASnoM4oWHb9R//NeDbIn1cc63cedhJd5tSKyv3SnvFZ
	4pe51rUilJd7OeUjPv9z+CEyPNaSavikpeR3OE822mFE1Z1Ktwg1Ul4vShI1FdQPpoH6e8g2GSl
	FNLRXu33+QAhENuYS2q8ffL5p9jDvFujM6CUhRrAYj
X-Received: by 2002:a05:7300:238b:b0:2d9:bc8d:f62a with SMTP id 5a478bee46e88-30449052679mr12962573eec.16.1779964456324;
        Thu, 28 May 2026 03:34:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.183.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef3273sm20512869eec.2.2026.05.28.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:34:15 -0700 (PDT)
Message-ID: <6a181a27.de8afdfd.4c667.d370@mx.google.com>
Date: Thu, 28 May 2026 03:34:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4166891058399473457=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: validate advertising TLV before type checks
In-Reply-To: <20260528094506.3699804-1-rollkingzzc@gmail.com>
References: <20260528094506.3699804-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4166891058399473457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102158

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.49 seconds
CheckAllWarning               PASS      30.32 seconds
CheckSparse                   PASS      28.51 seconds
BuildKernel32                 PASS      26.71 seconds
TestRunnerSetup               PASS      596.18 seconds
TestRunner_mgmt-tester        FAIL      227.64 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
IncrementalBuild              PASS      26.28 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.265 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.836 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds


https://github.com/bluez/bluetooth-next/pull/252

---
Regards,
Linux Bluetooth


--===============4166891058399473457==--
