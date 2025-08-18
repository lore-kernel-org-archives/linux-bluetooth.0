Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1D1BE871
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552868; cv=none; b=C7FQik2muXJWtXMPWokDaJI+fCPAzAV/Zcvxnxth/6ehaSMux3H9QG+N3YPX/JYb2X6tqqEyYDWsUfIqd8l4mgZXWcJHCaBusrSEiifBHriEry3CJiOFdCw1P93tvNTKiP4Q9jhYxBDlCmbjUdul/7d5w2tBPtW3GFOv5+SqSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552868; c=relaxed/simple;
	bh=CsRnmEO1HWVsFGGV3AaTjJwp87MM41xUBehw87C8n+w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hq3+Fh7NahPqnST70Fa1Y3jfVw7+YnMa48eTQQ+kmL9EJEX1aaog+tM371kvn7HUt5lCSLPXEnoiefdPL7C51Sie+d6QfoWqiHG4t1ZHEs2AuZ0w3MT5PIT4rnWqpGetw0ti3utJI1qxOvdJtx+atIog2+bv887W/WfkOl1qC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SniUw8wh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SniUw8wh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a88dcb665so41666856d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755552865; x=1756157665; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wwQaRaGyLj1fh+Y+nEkeTfYM00lrJbh+cBSDl3eQZss=;
        b=SniUw8whGNhcYZHYcSPp3kipvAMBrAZYBYXik/IR7ccEPgJI+OKp2Fdgi2rPYpN91N
         d0IeSrOxVAoQWC86YRTrZk9BP7MtbipJmo+gMXFLAlFreO/RDtsYEoh08B0tuQjdClrn
         CGskbMCA3BCj7M5ekMK6iQ2dNOlMltBNdtSjVwvaM8jrcWJQUoVb0AL9y/xq8vtJH+kk
         Q7x+nISFv8a0xxujCCETUR4sD5roXp8kTUyVncJLrNrKnLvkn8zTZJX5p/1OkqAs7pXl
         bsY0GNKq4gB2TlTEKLHdSFYQRZzsbu0ULoYob2vvbI8Tn6V+2tj5WS4enR4sWOIiKNyN
         4ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755552865; x=1756157665;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwQaRaGyLj1fh+Y+nEkeTfYM00lrJbh+cBSDl3eQZss=;
        b=KkvU7jvOZ9LA23Cy7bRpxkSnSLJEvCFHtiAFhaKEY/Y+OySCxm7cy2rqQbX6oyhbnH
         Y6S5/6iOCDAFK5KIrT3sDFisbJeAKtk5QBjEGTM3h4/9/DLtiPBZIXAMBDE7kUaR0bYD
         Io5Mv0bYB+G9Zwtft4+xffTIjszxR0Ycb1BnArrgbCxuHnHcWkKKgEiLWmlgZTN6JOoA
         fL8y69swGMOUkEYLlz+LlUGtCe4eTNMSVyZn036xMVTvaMOgev77nU7ERL7Vm2ZxCG72
         Ajo/yuLo7vpvSsTXcddSSvyc9EOGoP3rk/86b3w/YtewMEa4bdhpq3IrL3vkbMeCYVAs
         2lLw==
X-Gm-Message-State: AOJu0YxF/HjYn9iGv4S8ZEPmroxSoeR23JQ8BnMpcYc7D1yaO/ETc1gN
	o0fa/dLm3ATU2LIeB5iGccXpM7Xx0N7mqdwolBZm2b1B4CroFTjJCzqF6e+LYcDa
X-Gm-Gg: ASbGncs3fOnLHyTPA/3lAnNwJ9q6RNNOblywP1LTR9MnsULv56YshOFOX/35YwGUzy8
	qexipYP4g8Fozt2f7a7+fxYwQ3uvAYzalewxQuWC1oQzkN64z6NGsL3b53+a13i9DZsG1EMaP4P
	RqgFbz3y6o18out6Rcvj9gyU0UfvR9X/Jh4bWRCc5qERr72pXS4mlbxi13qK73mD6R6ySCFuJpe
	J9lQoO/weeS55c8j76QwOXeDd+dnvwQwtKQotmtRuwvKxWex4c1phQ0iOWq0Cu5RtH8dT1PqyMW
	vLmCzxau0hXZpqW78KPahHkZZTsnZF/Qo317oNTNm3bYDhObE7S8TeV0vksMNxeOoXvV8k+7NCu
	yFV7uj6ih3uOrIZrT1qolRpzbwN+HKA==
X-Google-Smtp-Source: AGHT+IEAg3EgDkDr2+zAqspLRoLvLqxfVIWrAVScd/XB9mbxFf6FUYHzmrhWS74iChJbouU5GGEhTA==
X-Received: by 2002:a05:6214:c82:b0:709:8665:f839 with SMTP id 6a1803df08f44-70c35c1934dmr2168876d6.43.1755552865166;
        Mon, 18 Aug 2025 14:34:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.111.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bb34e3fa9sm40453226d6.22.2025.08.18.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 14:34:24 -0700 (PDT)
Message-ID: <68a39c60.0c0a0220.34a4e.0815@mx.google.com>
Date: Mon, 18 Aug 2025 14:34:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2866074956570926128=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/8] Bluetooth: hci_core: Convert instances of BT_DBG to bt_dev_dbg
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2866074956570926128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=992737

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.99 seconds
BuildKernel                   PASS      24.85 seconds
CheckAllWarning               PASS      27.81 seconds
CheckSparse                   WARNING   31.92 seconds
BuildKernel32                 PASS      24.93 seconds
TestRunnerSetup               PASS      495.80 seconds
TestRunner_l2cap-tester       PASS      25.24 seconds
TestRunner_iso-tester         PASS      36.75 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        PASS      129.09 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.33 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.144 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2866074956570926128==--
