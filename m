Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB218DF6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734949973; cv=none; b=gMJvMBDjCjXcsxmSzhI1PzfwtMX2mX/lWDKef7/HLqF0jO18uSrlDwyCff5suNQKhDW3GnbUS9AWP/Qvp8atR1ShD74R7zRNnKYVzbS3hcVZkpZFWk7uRdi8OyfPEYKeqvB4S/o1g6FQeYA0soD4IWpeG3Gc917EzHs6xPbsAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734949973; c=relaxed/simple;
	bh=JKaGyY9tfXVoAZTbvSuxvDJBEeB3B0m28y9MKLcr3AA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hZ33fGRyPFKz4v9wLbdUgJENpE5FO/0kZmW2WUr04V4PiNB4ukoeO0dJrl8y7zAHur7iTSRmcMpNnc7UFTtSmGs10lhwziR90WuFImezBYTMcZlzxKMMoUyRjqpTmUaS4FsioEo2OsK968oeKynlkfhp/gTAsyOdH906n4YFqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6TYPuZQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6TYPuZQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e78c4d7bso2965818b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734949971; x=1735554771; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4zOsQxWdEpDRtFc8PkN8wuJ5W1vkwSDmpKs7O15kX/U=;
        b=C6TYPuZQttlnqZrErOGz87ob+zHInHTx7k6xzQkHv4dBqTYQ4GLDyfTRTP1RIqWkJW
         G4kzelqwfK0DSnsfhg8sY1Wkw57zD8MTFzxR+pAHJqlgP6868CJ/oSaM56MLYTWl8308
         giQuwzHkwcNsAoipbrp3yEJXartE6IUputBOsRtbIJWoga2xmjjXc5WgCC2IMVMrEt+Q
         kfmZQy0WxY5TlBjO9I16o1XeMcCjFruW/ab5COc8JudhCxewZT/mKwBA1u+0WNm3fBic
         e1TmmzESC2nl+tNX7X2LH7OOZMZx1I72T/B3c1XptMvTAT24lpN9cp9fXlXKG0omYbO3
         KlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734949971; x=1735554771;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zOsQxWdEpDRtFc8PkN8wuJ5W1vkwSDmpKs7O15kX/U=;
        b=IEjLXYqVnHN+3ih5bDuFI4XM200J1EJY8bwK5qP/qgJgxXIyZ7x57fmdDBBy0g22O2
         zpT7RU2MhzhguIVBnX6KRFOIdvSTbRG5HE0OAmd8Be9ZQbed6XgrHfG1MPyWW8zhSXSK
         svmWw1vsfjOucU3wPWRlEsux4CcoNxHhD0DCVuuvygZeQYKFVpPdaaw3IAYxhFXyFZgq
         nIj/dsD+LE7TKlw/MQxOKt1qsQWf2FXDFHHVXb9BwG38vVZrS8gkSHbxrRk4DUgRihmZ
         xJyhZtPB6pJXD2xeV5cuAAHXpND2RMENXd7hglyCxkqLXIZS+/U97HRCOKYKjiyAh7oz
         lNQw==
X-Gm-Message-State: AOJu0YwPoiMnO2zM4k9RZAL48Ha0kEFrUZ+M3bj5RJNBzoKPj6i/B9lC
	UUHOwuSaTdro06tuXZTedG82CssZPHxF/kXTiU1z6JGP6KbJhiUZ6Jrkbw==
X-Gm-Gg: ASbGncukWKnXxEbXZfLRdRo/0LqgurcG1FymKyXxDiw4DS638B6fIkp3GzH//W4n/gP
	aG3CJj6pCn4zVLvmULlw9JQ07f0Awqi+8QbI4qEZWpjeBPl7bSiBywdt8iXT4fZI6ynkFAyhVtE
	RD+k16GFTVnBxGKblWcau7z5LWf01/2sdTQzEON7XO0cqwSHg6osvBkenxNEmeJvO62B0slPMGI
	rVOrcwQCUi8m+PVJ8Fomho5Coqb+LuUfLypN39rujjzEm90KCbrfY2XLiHsbmc=
X-Google-Smtp-Source: AGHT+IFxXa3QeEo43v2x7LfIpcanVTuF9sUV24LwS2sBphk6hi+8La6CC1wvYmRqQcbrhuZKzZdC5w==
X-Received: by 2002:a05:6a00:2e05:b0:724:db17:f975 with SMTP id d2e1a72fcca58-72abdbd8df0mr20707696b3a.12.1734949970455;
        Mon, 23 Dec 2024 02:32:50 -0800 (PST)
Received: from [172.17.0.2] ([13.86.227.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c133sm7788889b3a.183.2024.12.23.02.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 02:32:49 -0800 (PST)
Message-ID: <67693c51.050a0220.1b34d0.47e7@mx.google.com>
Date: Mon, 23 Dec 2024 02:32:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5195105724216694565=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: [v2] Bluetooth: btusb: Add NULL check for data in btusb_suspend
In-Reply-To: <20241223094411.47496-1-en-wei.wu@canonical.com>
References: <20241223094411.47496-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5195105724216694565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920373

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.25 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.65 seconds
TestRunnerSetup               PASS      436.10 seconds
TestRunner_l2cap-tester       PASS      20.35 seconds
TestRunner_iso-tester         PASS      31.96 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      123.62 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.28 seconds
TestRunner_ioctl-tester       PASS      8.05 seconds
TestRunner_mesh-tester        FAIL      6.08 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.180 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.182 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76c/0x7d0
WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:2257 __queue_work+0x687/0xb40
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.119 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5195105724216694565==--
