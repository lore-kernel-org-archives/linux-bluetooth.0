Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B51ABC25
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101505; cv=none; b=Rqf/VEMr6gJ1jTMcxvW1CuQPOkiom90yMJ0sBif9cYEER+CSTabwcUiTizkFJBZ254UOBcMFyyyMRXdslWs/1IlOOkEhy8innyXF2q3CgKJZjPO9dxEk6IbwVkHKzBOQfd8cHidSJIaTPe/VqsfweOBaLpJbeOyS12PJcp7Jyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101505; c=relaxed/simple;
	bh=iXl28YcXmHwAX3wfj7h4ifBDlLKN3Y//UYhLlOnqvX8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n4bBestFB2AozYBOTK/k74BEuLz/egFpgsuTw/uDqrw9v+GEnO2MNrJbe9gFuIASNRmCwV5YGcOSqEkBqH7H4AnRgF+ewD4sq7WInHqtiBYGVmFJ5YTa5h3P5FUZXNuSmclu89qS91nuNwccB1cbH1gCsxtc/Ih0D56ur/PflXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUSiwplU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUSiwplU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso2561985ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720101503; x=1720706303; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciFNniCuu29H2taSF/Hpp5/l1afxBcoqHHBwsSUfvSc=;
        b=eUSiwplU3DZwbpo/lMEnihf1HCf27pj0NC/mkUNO8QC8GiRY+GWL3Nabi0M7DeIHkN
         92lqiqUfAuDMoBhOfr2yquRzv9uS43IdB2SUAiOgnGqLFOlA81dGncgobd9XyZiKTvWf
         bO8AoZxafo1mTBES6kMb3cxS4mUm++Mmlcn6prtHlWpp2BxZmaJtiwpwuOfpyogab3ba
         5vMhD4fsl31rHB+mYZhyKDhNgHnsD0Y1P3NynkhVKeDHs+gBHODPltrknUKN7wseEIPF
         uG/neNMpcbSxwMbKlyXHbN/kQxv4d3sVLOI7WS/v9nF4elz+X3Ub1nar/Qsh30NqQuEz
         RCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101503; x=1720706303;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciFNniCuu29H2taSF/Hpp5/l1afxBcoqHHBwsSUfvSc=;
        b=fQsyEFFNQsIo4VGjru/2IHWfImcT9qtqekRkw6vqXLYjCb/ttsY2NDF2caIUM0MNNU
         jXujku/RUqi5LbsPuCc2OCgy+EmcpqFCd3ZfcuqkVc2wUTX/n+JvyORlTg+yFaKoDyW+
         ZJn/jXM2g18WuQ1LY0sB51bNJOzzYXAed9OQT1cMyPpnx41BsxA9i/WPinM7mwhKWVSk
         lTzBVqOPXNCi67nL+Q6Bw78kViYw0A9jssbNrxBBqmC3BLLtlfQ9Cokl85F2sqjkmZjA
         MMD5zjhbyUuG2IFvl79aSOOp9mg284+ox02jyiZH9kLYf4gOPfNlcd02bKSpL48KDykT
         3DtQ==
X-Gm-Message-State: AOJu0YxmJxh4lc1HqPJbnNwEKexHckd6CsW1zRc+PGa4BKXSkST8E9W3
	/tJP4gebtxiiOaP4SYpOcxW8OtQ5Kd5U3m1WMHc+YdCE26fzjLr7oCOhzg==
X-Google-Smtp-Source: AGHT+IE68myQJWuatp9/8ynmtEpAcOHBi0oDa6p/1AH6IVdRMYRvHMXbkazyQkzUENWuv35kxdV0Qg==
X-Received: by 2002:a17:903:230a:b0:1fb:438a:5e5c with SMTP id d9443c01a7336-1fb438a78cfmr1891735ad.43.1720101503427;
        Thu, 04 Jul 2024 06:58:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535e9asm122836685ad.158.2024.07.04.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:58:23 -0700 (PDT)
Message-ID: <6686aa7f.170a0220.8497.ca38@mx.google.com>
Date: Thu, 04 Jul 2024 06:58:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0529721336903388287=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: btnxpuart: Add support for AW693 A1 chipset
In-Reply-To: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
References: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0529721336903388287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868459

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.41 seconds
CheckAllWarning               PASS      33.73 seconds
CheckSparse                   PASS      39.61 seconds
CheckSmatch                   PASS      105.93 seconds
BuildKernel32                 PASS      29.86 seconds
TestRunnerSetup               PASS      546.30 seconds
TestRunner_l2cap-tester       PASS      20.41 seconds
TestRunner_iso-tester         PASS      35.91 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      116.37 seconds
TestRunner_rfcomm-tester      PASS      8.46 seconds
TestRunner_sco-tester         PASS      15.21 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      33.04 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.176 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.203 seconds


---
Regards,
Linux Bluetooth


--===============0529721336903388287==--
