Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25098188CC9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679913; cv=none; b=T6JOkn0mrwEL1xgOpd9WKBN8SXa7PYoe5KRTVOCXfFM6hfuQI1sStyJAPw9JaYE2vXDl4oFqXYbA/8RFsPBb8NNgZr7U4APdZboBmX2bgMoOn827oIY5rKZi3tMGQhFWd9E9diStTe4hVNxivoFb3HUycr0arQ0D29Wk+uez9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679913; c=relaxed/simple;
	bh=nMOam61JQLzm/Gag/L9W65lJt7tGeHhnbCOroFpbusU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cEwJE5eyrrLkLwrR1YFtgvI56uXUPhk6f47MHhfzuoHS8c6TWX980IdaTv76zoCUYgBfbaKJ8+XID7O7mvSVZ+wj0EL5gtYV7uVvQZyyG6M7kpGczoL+lCeh0foyVeuMsd/BxsGUicP/q8zLegTsVoRotKvUnTSGduA55P8bbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLuXqX9h; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLuXqX9h"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d098f7bd77so426257485a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750679911; x=1751284711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CIjGHAk8gUUUTeoKvXANTDx+mzR9EOrKF4tAq9xWIEg=;
        b=OLuXqX9hAVQpyTaFk9LDKeogyPHY8qQSvihBECGFAY7ls7oH9shxuuPx5aK5Z6+twd
         yTIkgZGQI7R4biNi+dH580GTwhXTuBa03kaUtCCGqyae+VNzF+g2QOLszoYd7SP2hSQX
         hcorzcHBBFLZP0H6MRfRbTklotAvDIVl6t3Sbof3dM2f/slEOrG3i/XMwA/bFrS1qIie
         tul1N5UvyyBlyHsrcLcziqEGmh26kiqkj+lXZYTvWP5zTwxwA1Jbjp/kuuwG++8L14Vc
         8+jDV7X6W8B2oqqLVeEuHegZSn8PQT5/yrzDfZwnTFsdh/x3TFa1Pb3X9zxDTeMDSqUj
         nYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679911; x=1751284711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIjGHAk8gUUUTeoKvXANTDx+mzR9EOrKF4tAq9xWIEg=;
        b=xFNojrfbCWhZnkEo9hqKjj2StOeS+lXQlrl6fOxQvxJdUnVGZyciRmx69hXn2vrr/n
         P/wtdadJH39XAWiZp0fGVPvK+5/dH1l7e+RpoM3NZuJdTH4OxzEB1tM9p/gDM71rU9UW
         6TK/WCoRjQ7Shrs7f+N1qbkPX5j6k3weUiQX8z3kha3GV5GVzNmXCI2dtGrSpPLsv0Yv
         24VngAhrc+9oVyBE51Yt3CBZZcD8VaBF23sihaX0rQSsu3RJ+YJe3HGN57XJXhtcAgnn
         OBF+RC7nVdJJhQYbNxhi1OYxyq0Xs79EyBotTzGUSKqMSUvthYUcaR08P9q+1twuQeWU
         ixOQ==
X-Gm-Message-State: AOJu0Yyf4RPfH6rh2gwBC87r6msFDoCs7YuH2CvTJ3MYhFI3OQuh9vaq
	ncopntGBP72MFccwRBdBpRO+M/ekumprHhyI9qJB1EQVTvM2X4uLM2ZDzfmUeA==
X-Gm-Gg: ASbGncu1CmWNOALQTRNqMz71vZuNmpHVA8zN2vNqTnNHpqS6hn9ZlJPQY36Y3b/5odW
	YLE1upYdjB+TsppaKU2lHlSZ1f10vsN48e9M8QCi7wJ0fMqdewMivPTqh0vqaashf2J9QIlMtpf
	ZDmh+7NbhBfBajmSygpwjZKWo1v8Tqx02WV0QnNDQUwR4B8GvRZIVl6hSsY4cX4TPCembDyr5tF
	+QwJbjZEBDe3GcbQq6ZvNmTLe4RTNhROzc+SZeS6DTVfFYYjh7LVhCSJODFuBqYMQ4+ezPJbA9Z
	n7FyFY5sd280PuA4gABI8yrmZV9i0+ND+uA7W1Ya3ePK7Bfw6UPcFl5uEG7olC/86hc=
X-Google-Smtp-Source: AGHT+IFoejtVj3fuBznqY2czGsa/zgRqWsn0SNHl/ilYysRB/Gv9q1E0NOFfMBwlFMyq1KapDUpKnw==
X-Received: by 2002:a05:620a:6845:b0:7c5:d71c:6a47 with SMTP id af79cd13be357-7d3fbf9b3bcmr1641645185a.8.1750679910707;
        Mon, 23 Jun 2025 04:58:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efa3esm379523885a.75.2025.06.23.04.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:58:30 -0700 (PDT)
Message-ID: <68594166.050a0220.32f56c.c1ca@mx.google.com>
Date: Mon, 23 Jun 2025 04:58:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9164699997928906364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun_hu@icloud.com
Subject: RE: Bluetooth: hci_qca: Enable ISO data packet RX
In-Reply-To: <20250623-iso_rx-v1-1-65dd2882b670@oss.qualcomm.com>
References: <20250623-iso_rx-v1-1-65dd2882b670@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9164699997928906364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974799

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      27.73 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      476.49 seconds
TestRunner_l2cap-tester       PASS      25.28 seconds
TestRunner_iso-tester         FAIL      67.92 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        PASS      131.29 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        PASS      7.44 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.23 seconds
IncrementalBuild              PENDING   1.04 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 130, Passed: 129 (99.2%), Failed: 0, Not Run: 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9164699997928906364==--
