Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F71F5434
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900052; cv=none; b=FcTYsA/OaOpAc7APj7AOQgilpgdqoXZxx7BUnlBwU1j0r0jBVttGVWnajnp2XqPWTTbJ0MKkN3RT+80rZkLIB7i0Ws78hzIR5NowhVd+BzRr37a7kz7OTx6cdbqr/9Pkm/mUlAtqOSsG7m5yw6dHrJh+RPUzSeVLHBRMJLckRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900052; c=relaxed/simple;
	bh=2C0srtA5BINKpiVKWy3J35KpuRunrJN0AJwA06rtpTM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gmKEVOR1aYkUuSltPYnE36B8uwMM6vqxmUr0AuVUzbjYel2YngANHoi8pAEc8vgxj0aBvXgxkh3Hte9TBfgpkhBrbZhC7yQdOt47YtHt5xUocU9NRAUmxzr3iBDoeFOLYJZ9S4Sr+MxiQL+cZsVcl+mkBEfdEuJtJyFH/VoDpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBKJTG0j; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBKJTG0j"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-94822ad1baeso76786739f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761900050; x=1762504850; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/9Cpc3xZLvJuyTVw1cDV2Wxow6aR4ki06ek9hP1K8=;
        b=jBKJTG0jfIRXmhyRb8XejNKARtnfXc/zJY4z7wQo3D0dkv5yNQx9k8P/R8ixylQS73
         8Qn3QJlUloO1CtyQs6bCJPUxsa5ugm36b9SfKBSu+FmRISxhNs0noKxqYO1EgssUk2EL
         bK7BNOVBnJEG7/DGibJEV8xeS3dtMh8H7G3ngGmw38lp+X/kHIK2LOtMbGteLD6+w6za
         fE+3M+bASHi/92s8qn3N0x9S3d8TOE0Bg6YoGXURRyQBx6qH1NvqMo0XmfUxI8BUxe3C
         Wp3ylfwI6siW0GBOC/QTSLLaFI5mJpUMV1Mlpkh2NQyROlFM6CNHu8KZWwR9BfLoMiLR
         X9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900050; x=1762504850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hX/9Cpc3xZLvJuyTVw1cDV2Wxow6aR4ki06ek9hP1K8=;
        b=f2BTk3120vFYSntpWII6jCvFZ12e8Ni33oHVWFzrgsldiwN4Q/x0rJ/kk60ZRv+P43
         rFNBvz8eDdxdI75gJUSjsCLS+qJo3DHkyXT679ArRA5mFPwXfw3iuqqinajmN3CqVZGA
         MadEQk3noZqkgZHBDS1bhCICp/fHu0VQm6qU7EFjWkArRBrSSxN+dEbPoTpKq2T2+Nnc
         ZVMvJni6tht0FuxlLzN0L4hf1SAQR4H6TnvZ5udw9phBB71MjeoqqOBmuKDSD0oOUKei
         CXRxgs+quM/h9u0SrbES1T4l0bq/UpxI/puny4mG9pxUX5o0g8tW8haKHy38OvXAXcyv
         b8pQ==
X-Gm-Message-State: AOJu0YxvBvFzTcpnEATM0Lzug90ZpNdRgeBej09/1hbV1z4OEcEYQgic
	whsP/Gxo4hdxZdG4T9eRBMdtUEO6NvpmSP5Ht27XiO77xQfugAhnBMtztxOaAw==
X-Gm-Gg: ASbGncs/gYf7AYubZO/98QPWe/EVeHrlv2WD9fCcRH0zfd+6GSUptORSO1GmCAq7xIS
	xP2YSallP4anctx5qQlipUDmZPOnrff0vazNQ0YqvU+Y3lu/xUp2zQWgP4kAH6Kygb310ZV0C0b
	JeYzMNgP/2UQLyXOdu4xaYD19Nen+YbNNE4ZF7cTUq7LNOs86Zmt+7mauKItZL1MmPjs203bDRu
	BEIfctTsq5ZOj5pJav9gp2MCQjOhDM7kq8qNaA7sF3w0e1krnmE10tz73cdjh/AuV63VgM+NYOI
	Ob0snsxg5zgcSyfAXEyk1IK7k8HGfGxU2Vow71Bvfo6vs3g+s2z6yqCt7XzU4HPOFyfcYt9cAxB
	UcBNXUn3vzmoMURKxgiWVtLCYPrRALA9wpZIaHYBcU1HNYTII/awY+QOn+Yf0gLETQ7XN9Q4i/A
	3UAGU/1w==
X-Google-Smtp-Source: AGHT+IE14hlmb2TvviODz6Xv/DdUXMIR9cl9Yvp8t8w9L+p+HSdli6ANw7i0HJgtQI2FwNX+fX/x8A==
X-Received: by 2002:a05:6602:1651:b0:887:6ce4:8e07 with SMTP id ca18e2360f4ac-948229fc636mr456885239f.9.1761900049733;
        Fri, 31 Oct 2025 01:40:49 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827b96185sm36756239f.6.2025.10.31.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:40:49 -0700 (PDT)
Message-ID: <69047611.6b0a0220.1afad4.074b@mx.google.com>
Date: Fri, 31 Oct 2025 01:40:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7382408181746101799=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: btusb: Prevent autosuspend when le_scan_disable work is pending
In-Reply-To: <20251031081525.2275894-1-lilinmao@kylinos.cn>
References: <20251031081525.2275894-1-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7382408181746101799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018064

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.33 seconds
CheckAllWarning               PASS      28.14 seconds
CheckSparse                   PASS      31.58 seconds
BuildKernel32                 PASS      25.30 seconds
TestRunnerSetup               PASS      500.55 seconds
TestRunner_l2cap-tester       PASS      23.96 seconds
TestRunner_iso-tester         PASS      95.04 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      115.21 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      12.43 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.172 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.996 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7382408181746101799==--
