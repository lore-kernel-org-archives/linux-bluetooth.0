Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A36FB9
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Aug 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722803771; cv=none; b=HRfKnB4yOwGoznXkBV9Zvq5QyMCeFjKhBC6nZqkmOrB400Tfvj5CrILt0LIi+fob9IPOjHvmFNJPqHP5XyoRoBV2sACx8SgJ0c2H8Eq4pe5/G83mslGzcIbTYb1SmMQ7Sf6ghEjFY/BK4PQ0FaS/I2EGcTQ5f1oIbpu5gzmgjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722803771; c=relaxed/simple;
	bh=Cggi1eNHliiz5MyR8NlN3ZDs3/x2waIFrGVGvARGveg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Textm6+vMTu4gNWccIXi63CkMP8JUUtPMvPoDDWutlHdK/pKrg7IHm8GBiejWMYguRqXdXpIsKjJk8hSZyB0VX7DXoeOF3KbTP7sNEMy5TDzWZ5CP7FyIuc6+T9hAr1Ew9dxmVZGp+KoNklW5DM5R6+HMR4EU9icoxkmFTTcUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv8nZs52; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv8nZs52"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d7bc07b7so580556885a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Aug 2024 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722803768; x=1723408568; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ2Hbg/Ed1fDsRNDhQW45EdSZ/LkMQFLKCeQRf3u+Xw=;
        b=Mv8nZs52cRHi7gG/d1Du0F5xrBdVDMfVuzKbBQOTQtrYPAzyZJS+OZYkowEOJS0fXw
         0RjNfG+HSu3ZeqcjLKFYhgZUuLZN2tiQzXSsb3vPhkhHCLtbzGQ8Z+wKSqjB3Ga2MN8m
         YKU9jSVTufkIm8mdxG+QeI+oO6iPdYfmdlcI0pBBWvcMyeH3Kh8TZ5VuqFqtF8wdUxzC
         S1qxohoQ6b0pOOhLZOG8vh/MdXZXoH7qr49kgte7gHTRJfJahQ4Qpo9AZ+xO24aWebZz
         S8uW4T3Me2yUNwHqqPbMjKVujA+BSQkyA3cDNdJER7r+GZ2mzcCzv8aY7eikoWdEv1F0
         Ilgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722803768; x=1723408568;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ2Hbg/Ed1fDsRNDhQW45EdSZ/LkMQFLKCeQRf3u+Xw=;
        b=kNSJt9k8F1shpd6hGl0zhMT8CCnn2DsYu1qXFgAOZUlR+lWCUbc2iIndeTdq9y1jG5
         /NIpWL4TaN3dk1VVWY56sKYsOyB2nkwfZQIbbSQsJ5B+T6zDsvSwqi+OKOphGt2ST0kr
         IcLVAYPupoPiBuq7jmZ3515+DsX4vSgemtVWEhPUebHlAwVVRdO/+2wnCbZBKBAtFAoZ
         jouFuUQG2LOsg2ZeM8G5EufxNYH+3qo0eSaf/diw9/xXiP2IZQbSS72Rc4X1NDhy5Hk8
         8tl65/8q0f+urXgg9TvfiyYjmIOlzItO3cln95pOBPq096FXwHhUXR9zhysImY9L8Oad
         +vmw==
X-Gm-Message-State: AOJu0YxpsipAl4ZQjXDdpCJ5JdYMQpQdzbQEnoIoi7D9FSm4C/1smHiZ
	IrJDEHjFidtS2E0NWif7ALplgGm8PPns26TmYM//hPmmoLsLvubyisDbBg==
X-Google-Smtp-Source: AGHT+IGj4e4jry1TmBOffti2Vi4cGwyK4dq8yBVCh4uCl+G5AaFp7kqL9404gltzGiYD9BDrU9bkFQ==
X-Received: by 2002:a05:620a:3956:b0:79f:8f3:6ad4 with SMTP id af79cd13be357-7a34eed1880mr1356862385a.1.1722803768164;
        Sun, 04 Aug 2024 13:36:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.36.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6e714fsm287258685a.33.2024.08.04.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:36:08 -0700 (PDT)
Message-ID: <66afe638.050a0220.1fc171.8fec@mx.google.com>
Date: Sun, 04 Aug 2024 13:36:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5049340421401441314=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bas@basnieuwenhuizen.nl
Subject: RE: Bluetooth: btusb: Add USB HW ID for ASUS Zenbook S 16.
In-Reply-To: <20240804195319.3499920-1-bas@basnieuwenhuizen.nl>
References: <20240804195319.3499920-1-bas@basnieuwenhuizen.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5049340421401441314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876531

---Test result---

Test Summary:
CheckPatch                    PASS      10.04 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.88 seconds
CheckAllWarning               PASS      32.21 seconds
CheckSparse                   PASS      50.88 seconds
CheckSmatch                   PASS      102.27 seconds
BuildKernel32                 PASS      29.31 seconds
TestRunnerSetup               PASS      531.84 seconds
TestRunner_l2cap-tester       PASS      19.96 seconds
TestRunner_iso-tester         PASS      31.67 seconds
TestRunner_bnep-tester        PASS      5.11 seconds
TestRunner_mgmt-tester        FAIL      121.30 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      27.72 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add USB HW ID for ASUS Zenbook S 16.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "Bluetooth: btusb: Add USB HW ID for ASUS Zenbook S 16."
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.717 seconds


---
Regards,
Linux Bluetooth


--===============5049340421401441314==--
