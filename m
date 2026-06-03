Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5720373BF4
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508440; cv=none; b=lhCBEqyXYSNEu8kA+pcS8VPxvh68oLbmeT6pWjv+k6OW4F7Hgks4LkWminAEK8BFsRKEomhQkmri66z3XCQ8xik2ijNzlb2UQZWVKQlIZUXhoqMb3fd7bq+U/2f52A0royzthNXeD1qbvatorkiZP/kEltAZ/92pVRlSt++aQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508440; c=relaxed/simple;
	bh=LMaoEPAC1kVqDM/4Fz1+kwbe0r1Pv6VQUd2W7mJ8DxU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=axPQPM8KRXeiaxZNG+cd8DhxbyHaUYp/INDz/jJDGU/rQY1drJQ4J75cbc4q400I0NQAPU1kn8EQww32q6La36Om/nYdZauCtp3+yPyyp2+iQYLZxt6S6wVtWCzaOh7ueEBnKV+pBBXCOgA61Og4I55lQFP7bwLDtBsoRxYpQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8kDYgYU; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8kDYgYU"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137dd5161feso47653c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780508438; x=1781113238; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iwooFR8LmZe9WN5ZchISQADle1FOazcbPHkHYZN34eI=;
        b=m8kDYgYUyL4pS6A2cW1b3r1WfPAr8txIkGuogeu9OS9oEOPBWOw54CDJfiRw5X5nrc
         pAA8oy+PP4d8ZUNV/9rvUinD31vkIqry9IotqlP4DRUgk4pMC4eg0QCknsrsDkiGAUHv
         LW4ByLgWKw90xdiXlUSvNRpNOqskNil28k/dcw0NRjzuGlMgyC01fRuIG3krQWGliU8Q
         xfXnt4uDMAASvVSR6a19X57XLemEiuLvEZZQhc8ikxZ5gFnzsyh5QPfdwX47nAxi92Yw
         h1uH4xPzx8IMXJWYq7C+h2IhQzPH4woClcpNaylEzIBHlQxc5QdZgkEK7Soph7w3GC6g
         8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508438; x=1781113238;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwooFR8LmZe9WN5ZchISQADle1FOazcbPHkHYZN34eI=;
        b=cGtYM3diUpY3NS+Rp73vOcdi0uCMsE5FeWLTfwYXM5PV/nEw42Ndi7CwXdlPvwPnwA
         p6fBTEHFJCsvrKt3PONO/5N5/e2wooUHUALX4gLx9GwIiOKhhAGmLRfSAZYZMX59d68P
         O3Q2zNJ/I/fU9soTBjRZCaxR4I64bpqim1y+dcvzpEbtFS/1S3o+Zko8OnuuQwhRdIZ7
         xs1hfyMP3w1RYPNs8K12+6/sTvG9wcIBmKMZVHdvMazsnMlGbpYXhv43McSSnwTOVDwr
         soj9ULf9lMU9H/HJ0B0ZRbGxhxZ5E4C4muPzZqC1OEq8wcA+/dZu3CO8C7r+sTGkMmZH
         I1hw==
X-Gm-Message-State: AOJu0YxmE2k+oEzJwDH8TjX5IZNvKBeSFU6yJzX7+KdBMJ4prvp3eXz1
	JJKXgipdTkjq2m27ahzwo+0c+c8AAkz98KRTt6vbKeIPLlv2vvHaeb8T2Z6spg==
X-Gm-Gg: Acq92OFfm8FIbHVPa3IShFh7ltmzf+/NF4YPjK38WQ47vkotBuEVw5GLoDuAEK1+jcx
	SqALQJ4Ar/dqkgY6FrJ+xcfM08VUMdWjJkAPjN0pnUtJWAGlEXfKo7lIZbAC/fQZiBI5y5WDlsE
	Hu1OuXBHVDhaVpk6U7ALg92skEev9x/00XCvlQtNabLY1kQRqK8mVGpERDBnik5B+XLS4q0NqOV
	ePJB7sBout+5AnJjLDzeKQMiBe2CkDiSRUrsVJSbj9koCjZf/fGTp6hGlewVyV6lveT032+9yQJ
	HdOxjLn0JI4l0KqFDYj+RlWufuAKlR4lMZxm5OESV4noB1K/ShwxXa+b8GU0HFXZnM+FhfU8s0y
	xR09HKp65P0ZDA/HidzMeJWjpVqE0OzPbzmwJj5R+nm2oSe/KTSjEV4Pzx72DNz6aj8zFpro3hn
	FsFsB/t1jfgpuGl6Evl4VpbMqAftIrlmSJ2bVV7zmzNOLATT/gB56g
X-Received: by 2002:a05:7300:8185:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-3074fa96538mr2224376eec.8.1780508437812;
        Wed, 03 Jun 2026 10:40:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm2668976eec.17.2026.06.03.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:40:37 -0700 (PDT)
Message-ID: <6a206715.d08db960.1426c9.5ab5@mx.google.com>
Date: Wed, 03 Jun 2026 10:40:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2591991289470153258=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260603150835.3539963-2-oss@fourdim.xyz>
References: <20260603150835.3539963-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2591991289470153258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105389

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.94 seconds
CheckAllWarning               PASS      29.57 seconds
CheckSparse                   PASS      27.88 seconds
BuildKernel32                 PASS      26.28 seconds
TestRunnerSetup               PASS      580.30 seconds
TestRunner_l2cap-tester       PASS      60.03 seconds
TestRunner_smp-tester         PASS      23.45 seconds
TestRunner_6lowpan-tester     PASS      22.67 seconds
IncrementalBuild              PASS      25.76 seconds



https://github.com/bluez/bluetooth-next/pull/283

---
Regards,
Linux Bluetooth


--===============2591991289470153258==--
