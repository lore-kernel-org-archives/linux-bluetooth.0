Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C83E470
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374830; cv=none; b=to5M9/sMc2H3g8SYPZVXyDU+FaR2ke8LXqWfcntOmdMxTi5cpSyo3M/yacTZo/aFmlsD/hJwyjMO7T5VUqRdFbkdd1JeZIiJPg0Eq/dTdFvOElIyebNpm0dmjFZaG5sVRVMpQHj71oCREprDuemeC6rqMpkiR2FsygKXS8niVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374830; c=relaxed/simple;
	bh=6XWHnY7MuLLEc4+cIAUgz/dvpzJ1IfEZFhGTc8r7jas=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hafRKARALPp7H1BKC5M5OcsWo4NjK8yT7QKkM3CxngTYG8CFmpqv7vcz/lBMEXNpLnhXAy0x4bHrC+pzqHEcJe2svdtlOZJ7POj/dcmK70TyxC7a/8KOL6VzDXFbDQ19qbb8HPl5dug6+UbdkzOoOKgRqMo3k417Zic2YsA4vf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSECls3W; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSECls3W"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78776c82564so1532185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708374828; x=1708979628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1yJpVFtOJpIMflwjvlzlPmeFyCgKd4+4h03gES4AMaY=;
        b=nSECls3WcnuPD8vJJ9k/xJrwoBjRMDcdlQz5997vvZ1zFYnlOMVIzo5NNQq2E0xruz
         rFYBPOH0PD2sRNa2Gm/PfquQUXhNwGd7boPYl2Ngjxw41oBsnxJ/mJ+n5uvOPwZlQTwu
         z6IR/zZPQGFH/9V6ebcWH7nDm6kI1oXa3ONlvtKcYdqJ4tX2uMJKACibBHko2om4cSn1
         F93xhIWwbSy7Ag4BEQ3vTwXcZlqvxkG2LSaukVvoXU9wxkjfSytdchBsht71LXP0LX6N
         o8N8jRWl+GKU9v9aDcHx2EcZ8Ukuam0I2Alue8ZqZgWWj9sgDNlDLcOh2e0f8jwgCgeW
         ZExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708374828; x=1708979628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yJpVFtOJpIMflwjvlzlPmeFyCgKd4+4h03gES4AMaY=;
        b=uX8vRIYf/0yYiob45ReO1kB8K1ZBA7ashRrosqSs+Jf2cRJYzfr9KCkaOWp+T5BItZ
         KWNpMu1GObDcwfeeFB9tNSHPB2XO13nK6ll0ctkD3389vkngGN1BvpPpofDAqfQReIQx
         i3+U8oKAOkpAoMKqcN45KqhaYqBHqm3CMuc+1RNp4oHvSux9/2cg+N30pWOBwaB49ZnE
         78cvezwgJAJQl0ITCAcynSuiR3+n350GRHKEQk1+nZK6aUn5Ao1ym82HSeu2aBHwhFot
         In+LmVMWQeyrrRPG5pYtkr4BPbK5D//pOzRh/uKLmJyEmEmbUuyMvUQa2E/VJ078pen4
         5/VA==
X-Gm-Message-State: AOJu0YyakgSv/8DWAPfI9uuQ4lI5+8ajPZRGAhAoOmRa8lwsJbB92jVl
	NoMTkgBQP5FKS8QSbqIhTb9nALgC16oXZ6lXQHP9z+B5eZR8nny+qvajm2ju
X-Google-Smtp-Source: AGHT+IE4i3HhTGQ3JqSb4DAS91hmHPks7qZH5KZJiDwPVPxqRbMCtzBQThFBWi92zRDE/7L5QOd3Gw==
X-Received: by 2002:a05:620a:123c:b0:787:6fa4:3e8 with SMTP id v28-20020a05620a123c00b007876fa403e8mr2049163qkj.75.1708374828017;
        Mon, 19 Feb 2024 12:33:48 -0800 (PST)
Received: from [172.17.0.2] ([172.183.39.78])
        by smtp.gmail.com with ESMTPSA id vv8-20020a05620a562800b00787698df544sm1142746qkn.18.2024.02.19.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 12:33:47 -0800 (PST)
Message-ID: <65d3bb2b.050a0220.a6c6a.4159@mx.google.com>
Date: Mon, 19 Feb 2024 12:33:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4274297016864595003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ricardo@marliere.net
Subject: RE: Bluetooth: constify the struct device_type usage
In-Reply-To: <20240219-device_cleanup-bluetooth-v1-1-dd81ba00c95e@marliere.net>
References: <20240219-device_cleanup-bluetooth-v1-1-dd81ba00c95e@marliere.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4274297016864595003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827595

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.76 seconds
CheckAllWarning               PASS      30.93 seconds
CheckSparse                   PASS      36.81 seconds
CheckSmatch                   PASS      97.89 seconds
BuildKernel32                 PASS      27.06 seconds
TestRunnerSetup               PASS      500.32 seconds
TestRunner_l2cap-tester       PASS      17.92 seconds
TestRunner_iso-tester         PASS      28.91 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      170.40 seconds
TestRunner_rfcomm-tester      PASS      11.40 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      25.97 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 6, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.110 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.145 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.147 seconds
LL Privacy - Remove Device 1 (Remove from AL)        Timed out    2.495 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.699 seconds


---
Regards,
Linux Bluetooth


--===============4274297016864595003==--
