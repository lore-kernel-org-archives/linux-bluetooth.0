Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D837465
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707026846; cv=none; b=H9GAirm9cANtWUGP4u9KX0uvbQvVcihPhWrtExBCj/M/6+4YoggQ3BXl95ULALXSxWmKqt0AfYIZX3BdzbPvgiSOyCTwEFfP4QihwsBj5uAkyeh8+n3lArkOKSqpoZ/CJNyyiCxoBrmREzLlNx7NFjPnOaAIWw+CkbXrXnDp8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707026846; c=relaxed/simple;
	bh=Te/5CBC1U11we3QNW+2JudJByUPHv9a/fcJUdCH5gIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wn/P7IF8Fy/vkMuYwDaU1P9+qSGTU2HTIfTEgCK9udkf5ti9WCYvBRH2zyaYaINgLZ0ZyVDcS9sOIzm2czN4qHe8IZuD3mIf8/VMQ0Dc9AJ5pyAUp13l7PPnTPmdbNvPk8NhTGiCQx10qGP4El4dZLKiPinTPazx+C9N7k4FQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrNnaf4o; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrNnaf4o"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42aa4a9d984so27701871cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Feb 2024 22:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707026844; x=1707631644; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IOhswIoR4OrXz4Av2AlK2qWbGzetpahSq5csWfSlQQk=;
        b=NrNnaf4oVKHxcbbsK3KhpivymZpmF68XhwFFTZ5coZSpHIB+Ey9Su3ZsQqSYN0yhiE
         COJkD+zQLFRY4jHXpQmPyvy6QNX5ObVt/qEb75mrRJgHegcN+UCV8UsZ8lVv2y8PBGTf
         wrduVkI497lGUU6RNWQLeBPqpnYnMmO/uswGP35eyS1w9M4us69LHeG575ygeLBmHKW7
         DenZndgOCe3faDMkyn1McWdrPATe3aoKzQa5n8Xe6wkxEZB73hv8y6mAnTqUjIeRSF/m
         y97vXP5hRQOfLVhf+8yiISuJbfJxecHXPiYTypnRBvd6gWuQso+ZIFAUyqmSfj8tM58n
         +mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707026844; x=1707631644;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOhswIoR4OrXz4Av2AlK2qWbGzetpahSq5csWfSlQQk=;
        b=fLP8qdHVRDxQjRSV5VlhwSHjXoHaWDgvV1+n9hRbyZXYY/hH7iCc26ByEcq+LIBcWU
         VsGKt0lcUpiUt6+4jkavEm01OE5YWc2xaHDWtf4vLeBDH7ysPnIG5HZsrlVYePCvnQJF
         PttlwMkRgcqBQJ06JiQ1bcl0ploAGQwHUY3u225bOy+H14bTBSNxdzQPlNjaV5ECmROc
         dmW5s/St7G1bBYApNgc6PK8QrUiZiqNSh2QmyerJEyTVh72LgmiIjxQIMFIjxed8Qijw
         ZKKKb97AX0jp0IXS7lC2Z7tLnHe6NICRSXEbhNzba+AXquMlDKvMUIxEWBRdPXYWnwM0
         CGtw==
X-Gm-Message-State: AOJu0YxfQvXB8WD8yhB2GS/rg3/3YGwlrVe7j4rtsRjWrUOZl+s1sDY1
	CDM5jWrirPo/Mt6vzO06MNNynwJIrH3qiFwAWsfG+hWtFxip/uEAInx0X1XN
X-Google-Smtp-Source: AGHT+IFiltfnO4pbTIWhs6ooTRS4peg6L00mF99uhp3XFENSqQSbNOJ5IyL0jSkL2syjv6xHuGu2VQ==
X-Received: by 2002:a0c:f511:0:b0:68c:88fd:d926 with SMTP id j17-20020a0cf511000000b0068c88fdd926mr2488369qvm.56.1707026843533;
        Sat, 03 Feb 2024 22:07:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUu65mUc9vRQrUW2CaFztufT4DpcKIQkNfPlUZVrhyoi4hgSFefdS9i7alsosnoo5QoKEqmhanbLxCgHOZvFMs0+fP+hv6bhw==
Received: from [172.17.0.2] ([172.183.131.18])
        by smtp.gmail.com with ESMTPSA id nh1-20020a056214390100b0068c81299a2bsm2474070qvb.15.2024.02.03.22.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 22:07:23 -0800 (PST)
Message-ID: <65bf299b.050a0220.c5ac3.c41a@mx.google.com>
Date: Sat, 03 Feb 2024 22:07:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5134446994074934279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix triggering coredump implementation for QCA
In-Reply-To: <1707023659-4189-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1707023659-4189-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5134446994074934279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822830

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      28.02 seconds
CheckAllWarning               PASS      30.64 seconds
CheckSparse                   PASS      36.48 seconds
CheckSmatch                   PASS      99.47 seconds
BuildKernel32                 PASS      27.02 seconds
TestRunnerSetup               PASS      496.23 seconds
TestRunner_l2cap-tester       PASS      17.02 seconds
TestRunner_iso-tester         PASS      33.58 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      106.91 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      11.23 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      25.80 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 486 (97.8%), Failed: 5, Not Run: 6

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.082 seconds
Read Ext Controller Info 2                           Failed       0.091 seconds
Read Ext Controller Info 3                           Failed       0.085 seconds
Read Ext Controller Info 4                           Failed       0.081 seconds
Read Ext Controller Info 5                           Failed       0.099 seconds


---
Regards,
Linux Bluetooth


--===============5134446994074934279==--
