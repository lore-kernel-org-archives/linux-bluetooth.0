Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DF1C32
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421272; cv=none; b=u0dRgCwOqBwY78RKTlxp2nfrIF2aAmko7UUi6wCpPGJBIbp4G+eunOklboDRcfDoiD1f11IbJWnfkf+c05qhGdwg9AfGrIyU3JZBTS3mWHp/8yF6wGOoUTqY7EX9ddvzYUK8TNysDI9yCA++vBvSrh1+IRK4FHxEvQdQo7mT0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421272; c=relaxed/simple;
	bh=Z8KYGQOpDbqr0FZ96SIWthIcaJwBErxzQJGxVpMA6Ho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ADnoJDpX6fHWChS81eXwwtjClVQu4XfpoipeLpg+no+dZym//f/Dc5tssc480Gpf8Vfb5K8kOj0tWsTZ4FqOaQCSojXAGWByMbpAjKE+HyWJ4qXEwcWt7/VKaG1/eZsyppwl3VzDMinAP54aZgTQ/mTUgkO8Z6rlpoaIuw3vb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHEi9yC8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHEi9yC8"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47195f8f272so4069391cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739421270; x=1740026070; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhNWr8s9EZUnnQBOdwAaw6t/yvT3XrntPfPBf+inkbQ=;
        b=JHEi9yC816j4vUnWAPOUkP5jbnzj3gbNXlG7j6WgH1619JM5da7LCNA8SvZCgFytQW
         MiME+TsvMxAiBKdOopABAzaEQyCf/iUGE2EG+NJC7qOw8QsWnTMAoWxsJfCZlv3j/YEO
         wy0wGeRr8lB5JurbwHT8+6GSb5P2pNajjN4h0mLy61QzyUql3VxEBHLDMcb3RMVoGuXP
         biVljHmqNxVzUNunXFZdtgSp/CzbNo2E54rz5vee8x9fvfMfeJKiK/nr6WfwTsso0mwS
         VqTegr2sdquEgEPs4AB4vVfsjWlr0jpwBHbrk9Q6NaVtjWBrnCF3sqZx34m42yCBJvT9
         i0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739421270; x=1740026070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhNWr8s9EZUnnQBOdwAaw6t/yvT3XrntPfPBf+inkbQ=;
        b=JlCOJSZA6+J8dzoRnA7q3sX38tr05NkaqCu0sc6LpWGBbet1h4Dmf5xXuiXlFpfQlr
         0ZY4E0dEj/bupjU8fhKcCOUet0byPs4BMAbJL61Cu+amC3JWIThrUyxbtVdT+0o8hYCQ
         Z+McZFuyVJszgdH8PvkoB1GfJjt4O0ul4+9tGDYAssEYDOJXE6QeGjO/nU9e39iLwYVU
         FprAg2pXeAGjIyibulBVsiJpDcnNulo42Gab70Ty8qKL9VM/CRSMQqETNwchvqD7feMz
         4Aeei+6IYqRG7/mQNxe+8EXIvfQMDFQ1dlWlSYV+lrPDuLuEexh/y9NZ2VHEsNS9HCCI
         X45A==
X-Gm-Message-State: AOJu0YwNU52rJEum4/vs1a4FCTa+30YrEcqO4r4mzNnYjcfeNuXcsx/7
	jzArtVjA12au1ZghDuDbzxl7QSfOnYV4VBng3/IFrfJ1eVmja+sTu1NLpA==
X-Gm-Gg: ASbGncsiYwHOR1x3xgpVnHDb++UUCg41CuZCaLP9eZ2bU7GZY6MFYf+spuousXtWNhl
	wjJ82jzNnB/DbCIxLJZPmfPQzrgPyd7jU1LsETjmnl/eCdWZBIvFAmHqv1HAt0QiIdXP/GkGmXn
	5JczM74GqoDBePb+gercFUo4T4IFQzozg+1tOd+Dapkow9D7h+f9qGV45sUasm9yaviaWNgE+Dj
	YJCfnqMLkA3La3TjMXIwfL0JZ3BEst9PE39RpHov/3+Fv08bT9TYAPGHMYEm2nZ3nYqR1RuVxDi
	YpwOSiTqDSQScdvHpaI=
X-Google-Smtp-Source: AGHT+IE5fiAwqIZqjwm7xX5YH6eNMaoBX3hnajiTBKROt9U1RdBjw/WwGGS93jEab56sPEGxDXraCw==
X-Received: by 2002:a05:622a:1648:b0:471:c1fd:71da with SMTP id d75a77b69052e-471c1fd774bmr17223181cf.0.1739421269653;
        Wed, 12 Feb 2025 20:34:29 -0800 (PST)
Received: from [172.17.0.2] ([20.42.17.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af31f0sm3514241cf.58.2025.02.12.20.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 20:34:29 -0800 (PST)
Message-ID: <67ad7655.c80a0220.1150a2.0a23@mx.google.com>
Date: Wed, 12 Feb 2025 20:34:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8029235106718257680=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v4,1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8029235106718257680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933448

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      1.06 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      26.74 seconds
CheckSparse                   PASS      30.64 seconds
BuildKernel32                 PASS      24.08 seconds
TestRunnerSetup               PASS      429.51 seconds
TestRunner_l2cap-tester       PASS      20.95 seconds
TestRunner_iso-tester         PASS      29.73 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      120.39 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.48 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        FAIL      6.10 seconds
TestRunner_smp-tester         PASS      7.56 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.74 seconds

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
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.114 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8029235106718257680==--
