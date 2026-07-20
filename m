Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6753BC68D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579437; cv=none; b=F1DxNj/SKXOoaaR2zvLu2mPGSa/17A9h76qyIWGTNT89ktVSaLUP+8ZG0ogmvmhVhGKM0+AL++JvuBoiGsA4femUDbnLIJcBv7iYWUIxXecO4oJmjkP3w26P/+LrQntSdYFr17NdJ3UO6z+F1lYHw7QJl2nOQ5I5MiioUQxZ/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579437; c=relaxed/simple;
	bh=sp7ey7NvYPyt4r33zEiS+1aHInJbrSzB0xek8xQS8XQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eAxvYhRhi5b6JQoJRabduAjlNhBJzK5rpI3COdhKi6jBY0f4UuYwSBM4ZuESKvquZkX4PQaUy0iMP1BT9LutOek/IxB0kiDGZ0ZwQr0dYn4812ODZ/ObxETbs4jkwGsOWCzOGA9tc9DfOHRbSzC9IiQ3r/gpZ32o0r9tzbuxJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN6ciy+u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN6ciy+u"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso7190257a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579435; x=1785184235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D31oUgTybX8oiJhzOoYWHRWnGDWdKE50dIMCHt7xMg8=;
        b=RN6ciy+u9Lq+fFih8HnnbZivBTAA3DcoRLBgDMbH/WvA/mIUJQ0/vUGjdLfx3aVZSk
         JbcPp7kKxUw8McYsKvh+Wo1wXpNRLNpsrru2jWyCOmNddFk7knrCmrIyKrVp7VUZCLjK
         /SC2W0mgD8RDOywjVqpK9hGfK3Ii7buBHPBzDVfTFQey4F5la4jj7J/G8eqxp9B3RvgY
         jZW91fVKoM7doA32+QP5OBVCDZPSnCFxQCDSTUgHoQ9SzGDgbNxHAlKLhNJoY5lMwdZC
         csx5Lk0K266oQIpdegtpxad63HG4F2A4cELmPM79jMFyLQVHccoOSXhrlDWleNhPK0lw
         ykrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579435; x=1785184235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D31oUgTybX8oiJhzOoYWHRWnGDWdKE50dIMCHt7xMg8=;
        b=ju5wA41GfPfPNH4tNfECz73EUuP67wRzQ1TnBfzYBGLG+2JdbW3tT421ovCvLrw4vZ
         zR0X8oT3UL9IDHgD1vtDqzQT+c52d5ntz/vo9vHw82UqBy3kU747VecIbGD00qRsS5U4
         bMWBz2gbThx1RQHvjfkphyXD+gz9ypJ35lpVRiNImNI1CmRZdUmSsHrw9LCmd34WizGm
         O+P75qw4/RBEJHAqP3YRVErqyMx9PiKLZnRxtLjce+3Kyw9AkYxbP/5F4sGKX9P4cEtX
         v5Kyt+M+hKrKjvPrf12L6Lq67zz4DZqEEFVELsV2WxF0MD5HTryPhQo2YFpdbmSS9TIQ
         eD9A==
X-Gm-Message-State: AOJu0YyLMl/LwgcFhqtlN85SsvkVBsEdDHjwtDcXHZz7JhkvUPQcCBWH
	bxfiRdfZb4Z3BfuY6coaFaEG7Cu3GO0qyDOR+s+8s2+0WYA1nRwXaT24coF45g==
X-Gm-Gg: AfdE7clJwVocgcjHYKIUYKCVDcoXehIlxPUHIpgpuOQGAR21wc2Lyt4A5pMloauO+3P
	xO7Q+YD/styfR5a55Ly5VS08Wtb2KUSyk6r17zmoi1WU/6U2sQGAs0wztin9WrLnhXl1bWdaiyM
	BLdgtbaBxVXcNAoiQ/lJLfBFfu6nEKs9B13vhho63TadizlP1Gh7b1BBpp7vv8/noaZeqOPj1I9
	CYSspK2SiZvklEoTtpSY5gUd6izFQq0PoNa3lYQXVfxmGQ96Z99z27WBX1THUebLXRo2TB0OyYP
	BZCCaJFhyB0R8ej3TKq/6t625OoU/oIB/EhDMqjgw4F3OFLOxJyxIGC5vC18325o5DWqc8SSZip
	1J7fpOr7KxDsyquL2r1QlvDdcahGZrK9kYS1W1eeCbKTuSW5w063OVsM7V9Ydx8qbIyOgUS2pbb
	wI0SNldz3nkXQ=
X-Received: by 2002:a05:6a21:512:b0:3c3:8f3d:833d with SMTP id adf61e73a8af0-3c3ad95d53amr17628765637.40.1784579435510;
        Mon, 20 Jul 2026 13:30:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm39821906eec.12.2026.07.20.13.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:30:35 -0700 (PDT)
Message-ID: <6a5e856b.9edb5c9d.280be3.9388@mx.google.com>
Date: Mon, 20 Jul 2026 13:30:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5172089222770568994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: ISO: fix UAF on socket close before shutdown completes
In-Reply-To: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
References: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5172089222770568994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131089

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      30.13 seconds
CheckSparse                   PASS      29.14 seconds
BuildKernel32                 PASS      27.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      518.84 seconds
TestRunner_iso-tester         PASS      84.67 seconds
IncrementalBuild              PASS      26.36 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/465

---
Regards,
Linux Bluetooth


--===============5172089222770568994==--
