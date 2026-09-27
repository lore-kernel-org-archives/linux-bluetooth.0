Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECF2FE56A
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551380; cv=none; b=dEKs0xqGRxBI2NtI5PbG5onPdbgeXnLw6iooAaHJlLYG4FdEExJDZDkjesJsUq9LMwS2zsovdH4YZIKYKRNsU2fI9At1daQP0X5BglQTBcMGlYnaPQpXbS2TxDE8PnU0mCXmFX4v29LfAGUz/DrCmyDs2eJVcKKbijLXYwXs+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551380; c=relaxed/simple;
	bh=RIFH2e0zZyrW80WqznIVMYwgO7o0QjehGovO/4eRP64=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Efwqiy1NcJZ7GwguiBV86FcjsMuRnKjjXIqhG3s2KokCw6D2WDzsqgQEBsUfoTbQJtqySfTjH/g/mLxJc8n9/9GEppHQZfhC/ydGMo2zQU3rkgOucx6RrjWkzidgDDk7/Cw6Fj8okI3Xbw/F69RobN4FvPPQR9FDKP7aTvuqeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGZ+j5qE; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGZ+j5qE"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so1983637eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551378; x=1791156178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H16HwcLRWyJ6hBOBDANvfEKTuioQcb53FV4JkaewBGE=;
        b=YGZ+j5qEB0cn+MQZiEGUP/KepXmFa7EpBpu26LsbciD3FIovbprAAOISNRAYQmmz1P
         Nojf9o4rNaiNpuOq5/loSotHmepU2LDIZOZ9m7M3qh2bF6H3nH+T8CJyAH9NWrGeU6xr
         KobQMsM/8kYvWbwDvN7DtfqiMHmILJAiMGvy2r3KSghKcPLi2XsbRCNhJn8al5XL8TPn
         gMJ4lZpmzzg7YHoQ4iLv8s2q4VwiXavLLAfLwjjWCmF1bmroHALEK3Lwzl2d8kHgwlc6
         9MO6N6RkeVwubGZezL5PrXXpv9jLI7s5woimfggfyfPJ0ylDYcoknuR4a42qUXdXgY5u
         wG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551378; x=1791156178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H16HwcLRWyJ6hBOBDANvfEKTuioQcb53FV4JkaewBGE=;
        b=vD/y+5fUmlkbov9TV9WHxq4ibupc6oLy6hO1/4jM9Cd4ItfE4o/XpcTBFrRs2dre2/
         GGaa1+6vphnp8INZRIglDHLL4PP083b1TDyfho/HHTU48e3BR+MFRAWHQuAclXpaMzhX
         Thp+yCYRUAne5JRGkHNz5sBHnx7u+DpxGokqt9DF38f3fC+W9o+kvu9HhKulbFzlcwR0
         Wgz6g2+vzrUtmpufoNPTcK5BTR/q4cKhh5eQzAL4eb0llVK4wKStvQMsYiStxL3e18wd
         X0N6Rwxbwq8EXEk7hPgGbEH+9ruL3BMyufwmasWJyiM0pwJpvBrziiViUMwtTS3OPAQa
         BaoA==
X-Gm-Message-State: AFq9FYIdITd6oM60sXBcJawJzzWToxk1quBV7x1ABbA8YpIew4YCzdfp
	D0QByopARaFAVFj/11xQTmuUHGFDTQ+xSBjaWczpKqIJzP59tzcoc2QDG4xW3Q==
X-Gm-Gg: AYBFou1Lgx7ZNPZxshb0UnIROMexMZXqI8SGADUcANGotu/FucqCC6CN1hwjb2ccnMD
	yhbskabf9X/JkvmC1HfkFdcsJBlII+amIb1jA8v0tPUYayOCiDtUKRD3fXeU/IREWJG6l81up7a
	eiaObdaK2o1zpbjBvsAi8n8i3f9G56FwJ5m14XbLJkmjksWyVLMUrMvwQXsR56LyeY5bHWHYQUS
	9oUnn74rZwDSY7bgzyH7SmYrUgFVfry+mUQ9aPfQvowPC4H/GuP/5wdWLwwNpKggjJxyJmQV+hO
	N12E2KjuP5yows+z5KCHAJI5wb9qZVLZaznSjXnS9cIXtf+EJegC31dTXrxBtWDlrJWKWfiBjY+
	zyLJjmKK9SUbaJfqh/G/zY3CEW6vuOvzo+9LQinGf9SrMqMZDc5tGX9v0gWpv6BliPOYlk7FsTQ
	zvhTFLBY2Esyw3arrx3mtmWI29xowZhnDXdmeVZgr376jMDRfpbZugcuUv53k9jTky0hcxQQ2Ax
	/+b
X-Received: by 2002:a05:7022:29b:b0:149:2aaf:df53 with SMTP id a92af1059eb24-1492aaffa46mr2339196c88.16.1790551377252;
        Sun, 27 Sep 2026 16:22:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.75.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adcc5b00sm20373777c88.15.2026.09.27.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:22:56 -0700 (PDT)
Message-ID: <6ab9a550.edd3b74b.2ac4ed.0ec0@mx.google.com>
Date: Sun, 27 Sep 2026 16:22:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8915987350809198485=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v4] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
In-Reply-To: <20260926212145.1343318-1-qwe.aldo@gmail.com>
References: <20260926212145.1343318-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8915987350809198485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174573/

---Test result---

Test Summary:
CheckPatch                    PASS      2.43 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.99 seconds
CheckAllWarning               PASS      31.66 seconds
CheckSparse                   WARNING   34.44 seconds
BuildKernel32                 PASS      27.44 seconds
CheckKernelLLVM               PASS      31.03 seconds
TestRunnerSetup               PASS      701.58 seconds
TestRunner_sco-tester         PASS      8.45 seconds
IncrementalBuild              PASS      25.66 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:151:35: warning: array of flexible structures


https://github.com/bluez/bluetooth-next/pull/827

---
Regards,
Linux Bluetooth


--===============8915987350809198485==--
