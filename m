Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590824677C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727087; cv=none; b=O/msiikoNV3mAUEhEn8qrCkTslfCEhPac4HhaOEiBVdIwfYE0TdnyA0csvzQsacU9O/ye+119IfUW8592kS2Gu0LswiBB8ShPiEt/KuaFsNtMBS4lC6RI+nvKzN7P1LKV6m0781GwoAYq7aPSQ+pmL/QFIbXrkwnzp5qn5RqmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727087; c=relaxed/simple;
	bh=90l87wKIrQgIh+IyS4utbc/vgu2qTX2DDzYcDPPtO/Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hz6O+woQG/UXf2Kp0BnNPiaHIwSTdOsVU/4pnjpohQ7GNWLId86jwzIWx4TL0lTuJYBsqgfhlBMVdvj7tEo245v8kBevX35L6Rcodq04oFxu2qDhmjdkgZvAOsaMuZdzeKSqHo5zZkd6MflUz6oaPv8KSE0G4+SmxmSEtWsxHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc0go6fU; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc0go6fU"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432cbf3fbso20292939f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727084; x=1756331884; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aNN46sGUXzufTzh1RbFFxkggNHtjsdV20tueEBjNA3M=;
        b=Xc0go6fUQRUXl8pb2uQ/ejVqIqarDeKYtNNw+Sdt1BRDuncv48xNZcomZ7HRr+zPR7
         lJCE6lbkVFIrF9Rzk3l7Fyr3Rzfe9pxoRLSXJIh3KsZQKm5qY9t3I/7OxV2L5QPnDVLV
         BiNW3gVgPVGpaeEqadrwCb8nSWHeypHGVaklRycLXfrc4vv4dZHPjqoM6tSAg4oMesZQ
         TwkIgGmd+k2XLkobIiKVmVb5TC5EJ0un6ONecCXvBJaUBLGIKp0Kz+0QjLWkISlVkSMe
         gBWlD3d4G+QHN+b/v9nzWehe2XrbSCV7RzOi1DnPb6K94wwXg0toaPyv1IT/+A4dnMZU
         Ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727084; x=1756331884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNN46sGUXzufTzh1RbFFxkggNHtjsdV20tueEBjNA3M=;
        b=m84slVNBWRojup/s246oN64iUUVN8p8oBSSFTwfL/3N5NrjqpI4DnWEvJuI1Cl0jZj
         of2B3LYJRbvulYIF4i2W9UABIZjd0Eapb1yAjOw20/xudmzga/Wqq5KB7OBoZgjyY0NH
         +0pZSbWMw7DNkivSRgc/4W8ViPp+v5Jdm1+Yzj2WcgaKFxwyM1wa9f6ILcTW7W45rpQm
         C9snIktj9unod2u9AWaO9aK8SzB9E2xUqDFpaZjbNuCFFayXE9qI6ZIiDr6pN3NjQFxD
         XHR7JFRlcI0L720H6GL1VNVuqE97S/Q748otBXDIhcqOLeHZHz34bRte+I9ABwn1JgG/
         V4gA==
X-Gm-Message-State: AOJu0YwI4AEiVjYm8vb/8j/aVJAU6fz2fvVAjX+hx7mTmzsCPA4n5QyS
	zKoRlJH2rhcPYP84pMVcWkD/jmSfWew9U4OtXSBNfdeGhGoRj0Lbycark7KQERMP
X-Gm-Gg: ASbGnctDbzqpefhrZIkMXdXaxQhAEEiU+yZPdgt+NnmCNL6yoZytbe4WwkOxIBVbtj1
	HJmmDDoHSsrNs7bRqYUsFJCO+5BjC92c+AvZQCnGha9qyzpzvQK/vP6DtScIrAmv47zX+742+b2
	t1frnhIkJ/IoqJ6wsuDUBSRNoS2P6ArbZQsklbZ5+VVlKSCGh5c139ynP5CpquE2v7O/8QLXmdh
	+pOuFagzZGGrgMVQtEbLG66Bk5v+kul1wDJSN+ai6KiGSLVqQLfkoe/nWEpKdFLLVoHqp/Lf22q
	6et4EnzE3bkjYHw1PqWOjItx3h7+yRF5o9QRbfYG5ZERzZDLMGwPNFEg+zfVsLIrkBZKItiZmiH
	gV2hemW3Y5HaHNrYsYism00+Igy0KK50=
X-Google-Smtp-Source: AGHT+IF371GqxL+LqgAbw//crbXugTBOXRCyxhD4wQcc3PhgKg8iFFcudo1wOffn0cLw206KlSjZ7w==
X-Received: by 2002:a05:6602:6b82:b0:87c:49fe:cafe with SMTP id ca18e2360f4ac-886b488b155mr81031439f.11.1755727084383;
        Wed, 20 Aug 2025 14:58:04 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.164])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f83ef53sm540692339f.11.2025.08.20.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:58:04 -0700 (PDT)
Message-ID: <68a644ec.050a0220.2aaa03.992e@mx.google.com>
Date: Wed, 20 Aug 2025 14:58:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4073563057892130299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
In-Reply-To: <20250820211331.1923957-1-luiz.dentz@gmail.com>
References: <20250820211331.1923957-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4073563057892130299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.84 seconds
CheckAllWarning               PASS      26.34 seconds
CheckSparse                   WARNING   29.68 seconds
BuildKernel32                 PASS      23.62 seconds
TestRunnerSetup               PASS      469.89 seconds
TestRunner_l2cap-tester       PASS      24.58 seconds
TestRunner_iso-tester         PASS      42.65 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      124.54 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.54 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.57 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.176 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4073563057892130299==--
