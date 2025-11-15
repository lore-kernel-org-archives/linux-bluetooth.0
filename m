Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90A2192EE
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227919; cv=none; b=guCQx17RvCcwm1G0RKv3lteva5x9I+RMpM0vlZstLt5rhqfYMrU6qw1M1M9JxB6miQvbLYtaRpu31EYIAh38rDcJ/Olxj49Gv6ylFknU1GHcYnYtyxJw7qUrNzjzbWk6921OM25imuzo9sDXCSf0BbRZHo6r65u8BpKW9d/+t/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227919; c=relaxed/simple;
	bh=SrtGwxj5WYCE8RG9iBrdKk/pevbomiZUvrCDzPlKSTc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MVKsYLerpte8+do84qq20bLBnWwWaj4fD4ViPvjkkilFmxzAFqdjxDg+TsQZAWdKI5dHqWTU3vS5lE6jyz6y4FEqE2ri1ImcmeOZWbYaYBSLZDX881fzBTf2eg6PSxxmT/gK082K24dkWxlHv8x3BQ/2ymxJ194klfv0l20ND7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk679UZb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk679UZb"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-948c66f367cso198295239f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763227917; x=1763832717; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B7fp3z57ae/mBP4AN/HmyTeVfqwtnx7ZZT85Qolsw2s=;
        b=Wk679UZbue1JNyupAGVY0IECt0TvSF8IOvrWkWRUPlNtY09kDdLlCO/gYQdPVimLr1
         OabcuGpg4Su1NtsPG82xR10KzI5DnrOemcqE/VVx/1PN1gamyY5gVd2UQ7k2BLdFvLtR
         mZ5aMi1vo/9+nLaAa5wGKqP0veMJoFEa1zJDNM+MRfH85g11dEligVSj+yuRv6/Yzx4H
         Mj9rkbyaPtWqBf/1k2HztOV01ynvodw5sb3OTGJlviHEzBI8kdRJJ0Db2I7GQhU0lh+3
         b9DJAZpH3/7+VpsY+/yPUNcRyGpZGoRWv7wcBYqVVahbl5XGvLvOMa/xDObjWfddCpvT
         k3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763227917; x=1763832717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7fp3z57ae/mBP4AN/HmyTeVfqwtnx7ZZT85Qolsw2s=;
        b=j9cAgkLi5jdxO+TkaPq2MVbG21KGEdgyaYvhKwHHqIEZXobla6KsWGO1r8XyOxiocj
         TEmuVpVGZLMHVRpKeqc8pnDDGPctHOUQI1HHQrS1Hg8+8ybfMjxOvoVzgZGW8Re59zfH
         pwyI9K6cefWxlmRorBZ/D16hTahXy/oSXn7rhAurD7oW+f6tCRPA2KBhkDulZDw5KxYc
         B5f4Brl+c+zh/YbXm8PzYiwYpHTnCIlwXjT/7GKoLRZ+pDaqjK5lQYa2L54JiNyBe5mD
         GLTVjVt1HkQtzGO64OUkICSWpzUIZMvF72gEJ+fxledZxRdDg2Lgub79vuwAErB04Rud
         SNXw==
X-Gm-Message-State: AOJu0YxpE8amB0fU3+ROKcBrPUYzBngIYUkkWdTIl7IpeEf2NTe/ctK6
	Q6RxjwzzlT5caSUWOAV/YSMoHh48Yt6//gkuPndWyW+tvh3Dj/wccA9VLpDE2G/F
X-Gm-Gg: ASbGnct69dW/Dvlm4UWaf2j3cC1PEqTCOmIzolvLmTvrEH5c9igRE9FWEpvn1nBMbOF
	IedZ/aF2lDiJqMFl5AGnfVKEupnp2uG9MWSvEzRMsgaYxM3m8JN6IBx83eo2dGFGbpVQkqpWL05
	j5h/sgYmC+MSXMGzVS2BDaffVBWYXEi/gmsobjRi+Auyk1MBBRmyHk5IvMhZtXbEeK44axX01qC
	aqvsG++B9x1l3SD9dNJL39wMnMJMhi5bje0q1xPfw5fXk6Mrk1mXpUIcrJ5MIv3z79AEJdCoa4R
	A8WY1XLoh4LVGzXJ/3WvP6CF/MCEayow+tabhViTb+QqWuufCXMSnI6IZPq2puGEwG2YOvRafYc
	nPTqTuZs0PmJoYstmzon5Tsi1Fs1UNSvKJrtyYoZCul33TaCRY1x4PRZDwl6iWlNpnafkFAu6hE
	8CRWvxsdbMPOcGea48vB51nio8U3QU
X-Google-Smtp-Source: AGHT+IGYfhz+QzLEelPw68b35cm1B814bYn6VZNwseplFGqdRKYTGCTN5ibwjmqYf8km3iU1GA4YDg==
X-Received: by 2002:a05:6638:16d1:b0:5b7:d710:661f with SMTP id 8926c6da1cb9f-5b7d7106732mr3277688173.22.1763227916645;
        Sat, 15 Nov 2025 09:31:56 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd330368sm2354918173.48.2025.11.15.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:31:56 -0800 (PST)
Message-ID: <6918b90c.050a0220.1c4f64.47f6@mx.google.com>
Date: Sat, 15 Nov 2025 09:31:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2748750613430766491=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: hci_core: lookup hci_conn on RX path on protocol side
In-Reply-To: <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
References: <183db933c90086f465918ac41188d730ac2bab4f.1763224083.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2748750613430766491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023857

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.75 seconds
CheckAllWarning               PASS      26.09 seconds
CheckSparse                   WARNING   28.80 seconds
BuildKernel32                 PASS      23.30 seconds
TestRunnerSetup               PASS      461.47 seconds
TestRunner_l2cap-tester       PASS      23.69 seconds
TestRunner_iso-tester         PASS      70.43 seconds
TestRunner_bnep-tester        PASS      6.03 seconds
TestRunner_mgmt-tester        FAIL      113.59 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.56 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      9.54 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   0.92 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 484 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.171 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.185 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.868 seconds
Mesh - Send cancel - 2                               Failed       0.129 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2748750613430766491==--
