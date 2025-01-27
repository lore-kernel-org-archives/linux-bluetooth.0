Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9331B532F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017069; cv=none; b=dasmioa3YvBYA4BdlCeOTtoP52zkdY7Zge++HPERFdCLLBfvcpJum/EYhlKdGq6NoWeFqxWrzFBdz9b1du5GXdu/KnnYmAETs6U5/02gR3mS2HWSahWDu5oY+miZkgjiQgmfOyT/8NMyQVziv7vTB1j27ZCnvb+z7Ev49SI/+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017069; c=relaxed/simple;
	bh=HpYc16YS2aG3fe8WhuffJJgxt6iXiP2SJyLu9D1q3oA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MU/Mi6xxFHHWF0hqY/iQbQJYcmhaiv95rBXTFBzakAcUQ23kEbfkecPXK/Mv8WI2A1aStAsrxACo8JNCcSuAGw94Wt2eJRRcly5VD4BgEhFxgLcGRUYL2PFHC5RMwSldT5xXgajiO5cdQf+15DynDw+55dPiGQJt3ujkmznFMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc3LmnU4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc3LmnU4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso6591405a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738017067; x=1738621867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nVEXPFONH8LY4WAtU/Keaikn87uotZev1TqIOnV0HE=;
        b=Qc3LmnU4P5gGwWAmQry3bH4UvfrcGKYapqBZnniQ1rIYwnRDNpoQ35+7ASmnTI4RgG
         5r9xz+f1VAvbAqxXQhkBKigbBr+mJtCDqnj5F6M1WYYpabMVbcDg6rWxYJpGbTTZBWUe
         OKrmGKEJiAGt4vA4UJjeLJVblpra0TtQbCwVRg4ZRpO8WSzQXclTgrmsJ0eUP7gj+vjW
         ePZQL7wssSmWLl96hccrd/Y/CwTEkBbmu8N6qxXHZClbz+RLvJ+IVgv/913d5rtRWBLu
         ziDjXSxFAP1rWhANodZP6Yb5/yPpHBnuyT6dHUMzSnv7FnoaaJJb7J0sL73RqnuPNcDy
         EtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738017067; x=1738621867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nVEXPFONH8LY4WAtU/Keaikn87uotZev1TqIOnV0HE=;
        b=kfB6klCHpICEsJZVsHSMU35FPYNDhCXAxgloDEN05iCWRqJaLuHNs3oYKvubAtE6te
         n0GOnQ5LaCmE0GVnuvfle/y3d5djjigDhpyy2ZFl5AAlIHHGPNMYtLF0wgmwGHgLu3V8
         bdiwoEDk8uSkBdHlF7Y47mYLTG/HcivlQcygElLhfsqD0aps9/Yybra8XrkH3siC00u4
         WamdEXoH9DL8TiaYuetkOUNGBn2lte8ttJf8ZaZsCjBkXPQJKSL5hghGX1EC9o214dPn
         /j7MGweoOVrVchnW0CLt4Wx+8CGSjZiPdwG1tmCSfqG8DoQYp5BQsktDw/Y1i5b/zZcX
         bhag==
X-Gm-Message-State: AOJu0Yy9a9YoQxB+fSDnM8mVSuR8paKOykDAmcGkIoqt34TV77/QOnT2
	u2HMZNbxelFpFKeerHYEArddQFI4SCQREH4fVdumzvsrD8NoKpBJXY+ITw==
X-Gm-Gg: ASbGncsggH+bt7CIKwPK9cVkE2TYvYozYf/xGekYX6TQnGQcxF1zJkSzgtJ2xzz69/R
	+RClJ810YIjek41kI9qMAc6NdO6Jmf5FTt6ceEjTqkPR2O0DLSjOeQ7ooPRIVg+1SLw4YMq5kWF
	nyLY/3ikUgwW2ROOTSCrJuButqF5kS3ylsjS92+xBw66xlewxVfxajdHLnyl8MQjXeCwW1F73Rb
	A8R5vPSi9AX8/ko8o+DZkM2VMGNP/DWjKZ76H3YDV+FCMFQWzv86RDvgLSJ+bahHF30TQPP2ptx
	+CLkuWoQ
X-Google-Smtp-Source: AGHT+IGznFZO9oW0Yb8T4I0WtNAOdEY2nyXK+bJWB31d6ZDhF3omNsHpEiR3aqbYUBD+UBPDfjJNrw==
X-Received: by 2002:a17:90a:c890:b0:2ee:cd83:8fe7 with SMTP id 98e67ed59e1d1-2f782d9ee9amr59262720a91.35.1738017066855;
        Mon, 27 Jan 2025 14:31:06 -0800 (PST)
Received: from [172.17.0.2] ([20.169.14.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa76ebdsm7811381a91.34.2025.01.27.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:31:06 -0800 (PST)
Message-ID: <6798092a.170a0220.f56db.7782@mx.google.com>
Date: Mon, 27 Jan 2025 14:31:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7225595468895568655=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: Remove unnecessary braces around single line statement
In-Reply-To: <20250127221052.197899-2-deaner92@yahoo.com>
References: <20250127221052.197899-2-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7225595468895568655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928654

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      27.14 seconds
CheckSparse                   PASS      30.24 seconds
BuildKernel32                 PASS      27.66 seconds
TestRunnerSetup               PASS      424.07 seconds
TestRunner_l2cap-tester       PASS      20.29 seconds
TestRunner_iso-tester         PASS      27.05 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      121.36 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      9.38 seconds
TestRunner_ioctl-tester       PASS      14.45 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.186 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.148 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.165 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7225595468895568655==--
