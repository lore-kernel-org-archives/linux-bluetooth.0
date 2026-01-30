Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439313128DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758566; cv=none; b=DqBaUxZur8lxtPBpAvwr3OwArspjXmAXUgoQrkHRsZ/SItwnqBnntITQLh23Zek0nfM96djO+BUO4vqsYQwPE7YTGQG7npa7BLKfDll8n2RvR+5YosYZRcS9bTgI2x+VoH/KX8AVFvKcLRQYpJD/hFLtxbW8Hz1hwEC88py58T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758566; c=relaxed/simple;
	bh=nssPnkAHsBp4BWxMSe6QHdSEMx88jDie0KgsjHVAIVo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cbncNwR7DwqnW1p5svR2G+OcB6UyFqt/uSqeLt6KGS/iMa0Wiwqs/GJw8EPACzj5EDxfZBLKiKq2nVosWoNZSUfgR2uCeQPl6FUI2c9HrHZ9JevQsCFMEGnG6mKcS707f0PEMMgTJZOXS3H0X/bTt9u76YspOM391/Oilr7YeVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+WLotK4; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+WLotK4"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3714109eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769758564; x=1770363364; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qs+NtkLugp4sjD933R2vo+drk+LPgpH4jqsgsG6gsfc=;
        b=E+WLotK4MQogJg5aMGvTqlwd0ee+y1cMuW9Bl6kKakRo96EPYeFsnyE5DqxUK4ixlD
         E9kQueBAmW4Gs6X8RLJi3ssCKkApEvYBhJavkE2xQtTvUzy2wdvMaKVYm63SWAhfitpy
         fpFf3oIKUJzwBbDq5MqRr5lPVeaLu3VJNfYJdsUkQg+HEwqp6emjGLxKXjatHJjLi8Lg
         Iw1JFg3I4r9g8QiwCkFMKke/MC92BjuoXtdzhtftAJJX3j+WnXKwrNCa6LgwKrguZFu4
         hQepUXbPEZuG+vrC3iavSOMAT+j0/jkXTMetW585k4exjr+XSkST480k9+gv/D9anfcT
         qIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758564; x=1770363364;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs+NtkLugp4sjD933R2vo+drk+LPgpH4jqsgsG6gsfc=;
        b=IqygtqS4x21o+2FtPHUS5tUCrzHpgtk43UjxAI5zc0+P8+9dSesJlAHR0t/lQhyhLA
         D3OgngwAdSXnoVl/nh5D4XUhKjJ00KnBYGy5/NG3mgtBjsPZ/072m9akfwEvPKdGK7Cf
         dfiv3Dln96xsWYQr8f9jT+W1JUHKHsaxVVql9Wczm5FEPVAnzraVbPkrxB/7SAMiFhiY
         nVTkzfNBkrGGLoYMVubVrMnE8/ofCtbAHaf5u1NrTXu90Oqk8WRBoSkVkx7y/GBpI82Z
         IfpFFei7o4/Cyjs00YFsnv75hnHp2zJFd0IBUsbAvKPBpBNF9WJJAGH8JS3WXZOPhSKL
         C5zg==
X-Gm-Message-State: AOJu0YzthqZr5ovFPh96AOr6zSS2NbgK0rf4NiOuAHXZ23U0PNysl0SH
	W7Mb5QJ7DuBpgyz026xJQTWoTJE0cXi/rVVrSSHcqCMp8i/G88ely6sDnSfw3Hcx
X-Gm-Gg: AZuq6aK3DxDCw56UXpI89B68bMi7KQGinFOpMwy5W8wRZjdZK1lZDoWTkzqecBRUd8P
	pRYeqffn9zcOQTZACeokWAKw0WZnzF8izaAwOMRw5krSTCEoiLJbRb6xZpj4vbnLmxqJDr2cAee
	kjcZTy/UQcMkX7J01dJbGj70kLEj0hiS2Zqwed7tXtH9np7oyjMr7yqgtrSaKUfmp+WxTfa3kAd
	cGuFbSoCG9xrNs2FKHdQNInJso+Dg9nfd9GXERoVs/KU7LHu+u6P/Em+kGT09RNO5AbfJd/ssSc
	HPIjDu+zBQV75oA3h6rvj9PKtZbwEMa75IkmHhnRidy9Fkfv7tFb1AmMNRczeZloZzWFhcRO6SD
	rLBt/EdjTq4k15Sohuc5jr7IWZzBnWXAUlPBpazHzGY8oxYrPwgyuOrWSOdq/wQHpqZI7JHDp/7
	sF1xh8w+z5n69rfa5+og==
X-Received: by 2002:a05:7300:d50f:b0:2b6:c03d:9ff0 with SMTP id 5a478bee46e88-2b7c88dca1fmr1033852eec.22.1769758563873;
        Thu, 29 Jan 2026 23:36:03 -0800 (PST)
Received: from [172.17.0.2] ([52.159.244.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16ef3b3sm10028187eec.12.2026.01.29.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:36:03 -0800 (PST)
Message-ID: <697c5f63.050a0220.280031.86a3@mx.google.com>
Date: Thu, 29 Jan 2026 23:36:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1306207572915319249=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1] Bluetooth: btusb: MT7922: Add VID/PID 0489/e174
In-Reply-To: <20260130061356.2343346-1-chris.lu@mediatek.com>
References: <20260130061356.2343346-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1306207572915319249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048839

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.83 seconds
CheckAllWarning               PASS      28.82 seconds
CheckSparse                   WARNING   31.94 seconds
BuildKernel32                 PASS      26.33 seconds
TestRunnerSetup               PASS      559.30 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         FAIL      77.64 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        FAIL      115.57 seconds
TestRunner_rfcomm-tester      PASS      9.64 seconds
TestRunner_sco-tester         FAIL      14.62 seconds
TestRunner_ioctl-tester       PASS      10.55 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PENDING   0.81 seconds

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
drivers/bluetooth/btusb.c:4659:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4660:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4662:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4663:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4665:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4666:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4668:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4669:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.740 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1306207572915319249==--
