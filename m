Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FBF357CF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696123; cv=none; b=TkHFJOf3vHWD+2zmAbvV67cYctBmRcdf2XnarYQEP65rwHvaP+BFH3Une4HeWdXoFX7Fd83oouiSftNwQ/WAEKftSXOf4r858c48nGO2MU5GG1Lh8pe6jZ16awctHjbEGSsO5ic7fcwTZ9bGsIizCN9jqDYqzUS8jLGU6zThgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696123; c=relaxed/simple;
	bh=oKiLn+AhUJjB+AxFCDuHvJh2LtPH1KT91EoJCjOv/qE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kB0W6NU4+jEGD+QXciJsSBQ/uPr98YI4SgAnclVG3k7j/5yl1DBcTw3MA5LQHAiG98o2KRrnkcgmanPvSCbNtIgX7FOumotmSqTe2rW0EcU+b4P4lL5rVNGYq1wTU9plcrEgrFkSlNfr+kWhxWwbW+/Gg6c3IFOhePSdaO/yNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeRm5ucS; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeRm5ucS"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5038630eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696119; x=1779300919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0QSND7Cxl3i4jvEbBlVB3BxOJoeL2pm2m+J5wli8UX4=;
        b=aeRm5ucS7A/GuZG0J82YUMtkUHbe7BGzb2lkZe6zQ/phzUsJeMCNhA05McXKGBBRHA
         fBJeopjs2LFtd1Mm8zbj5EWDuMj5GNZ3PSwWO1Uti+Spq95NE/WCJdD9PnqBntJOpc9N
         IeIPRSc2BqOl4XzM8gKWH36xYJzlGdQUyyfKfp9l7wBu0kZPwmFkoIrZz2JuindAvr3w
         GgUdNwASK+M1P35N6NI4WvOhfw03jswfhKPGXrHT0d3UET8IFs1/8Iq5gCqFENPfAhqz
         Bc5s6IdezxGaWAoDQ9y2sZzRjjlw6lmCSD1W8acyWGloNLtU5u9rMj8HPDHEwAIDnfhW
         QoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696119; x=1779300919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QSND7Cxl3i4jvEbBlVB3BxOJoeL2pm2m+J5wli8UX4=;
        b=dBF9D0QuJHkZYI6d+7HkrKGvQF/yCvxanG17GVDozGs1KdxudplRBOcDbF7odYpXHr
         FELFAQVe1SvgCWiQDJuHxLREgh2nR8TenJT7Va3u5DmqeVfYhm523So3QYD8L17GL9Vt
         UsAZJXngcF5uXxwQyQWx3HuaVceDqDgjtMoHfbZG9tYJFqf2Syu5DMTURhvgGw2QsgLO
         AfVeS6yWg5TSI+rvCdLFpWIJVx6SYm4AkNuT1cwKow7cMsXFAF2i61YhSnpEUHXD91UE
         sXE3JMWdQdHpNd0ula7nCstgPCJ6NW+XF/Dfst4EJOz7NMceHXdTYhoaJSMJ536LIoaA
         TrJg==
X-Gm-Message-State: AOJu0YxlQ1ChWp3Vljd8PEGaTsGu0QE6EfMlMrGCpbnG3nWrgLYO0BtO
	DkJdZQeeTISfg/QgG+HfDATGVhHkt3VC/hGd52YW7askgqcbEGWQ2mj4acRzmg==
X-Gm-Gg: Acq92OEgepkX03wANIzoWVDzIAVnLrsg5AZrEcfB5f57x8EdSIbnzH27/ZTRF3vy/d/
	g8LYpiKO3CqJ3mTVVyDu/T86/XCKcYQgBhDVgDMFmRY3lrKTF6aDLWD9wAghkkcbwS/siPOqCze
	Hiy48QeRVd502DbeBUtrEENrWlwWFe+TQxmwhi/gP1H7YxTF/KnHZOKxZCaJdBJwctV0bnAbP9f
	eeTFk53uUMtWrkQUw1B7nLoMnVOUUrfirRTb4ncIo6w9MePQ4HEmiYzPy+QC9+CKHv3QmKzeYIl
	ClbBQ3ygnVZ62leDYhjhvX92JJLuyqU8/LaLju1A94JhaOxWUg6kXm93lwdJy2G2K3KKOifHGp8
	iUWUMMQT8v7QgK/Tf9/yhdJo6u5E9rQ2XoSEYhFuhHPhdnS6r7u826blfcHi78H/ZELid25Pa/v
	WPdl2qJF0OaCwMaNZrYkugseVqmh9Q
X-Received: by 2002:a05:7300:a94a:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-30261d79969mr368214eec.15.1778696118532;
        Wed, 13 May 2026 11:15:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm28322036eec.18.2026.05.13.11.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:15:18 -0700 (PDT)
Message-ID: <6a04bfb6.050a0220.1e11c8.672c@mx.google.com>
Date: Wed, 13 May 2026 11:15:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3560166403874242481=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
In-Reply-To: <20260513173228.1220717-1-luiz.dentz@gmail.com>
References: <20260513173228.1220717-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3560166403874242481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094370

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.73 seconds
CheckAllWarning               PASS      28.99 seconds
CheckSparse                   PASS      27.94 seconds
BuildKernel32                 PASS      25.65 seconds
TestRunnerSetup               PASS      573.39 seconds
TestRunner_l2cap-tester       PASS      376.55 seconds
IncrementalBuild              PASS      25.42 seconds



https://github.com/bluez/bluetooth-next/pull/184

---
Regards,
Linux Bluetooth


--===============3560166403874242481==--
