Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0201A316A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464185; cv=none; b=rY2h2OkaeA7THKBQb6KLbq2LDTkyahts6+G9CkuSyOSKzdw5HOkdSQI6YOf+M6+AEn4DdT1uALwqQbJ4sC6nwM+ZI3NEkC1zkfs6dz/nlPqombdOGCqmXlfN3PqMdC7A/ZPnv1jtrh6q5oZmByHs/x5xKsR52STC6iFIhcqS3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464185; c=relaxed/simple;
	bh=UVc8h0JnraWWtYz5DfkgFj5wNjECQ41nprSWhCtjBwk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WUzI4dHXtggEdW/dS0s/drIDqgDcvxI3uTiBq857NV12RxlbpqtlzWLPh2Un4jyL9rQhbkXs654kgNaGEYxTfefPHwfcJ6wvKP9DbhZWUPk0+LmXv78ZKzgv29B71E/53FtSL3XGq/xz+J9VbnApw7zWiS59qo4Ak8nYt5zxzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2WFVNRh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2WFVNRh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224100e9a5cso6593415ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745464183; x=1746068983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b2Qm9neShRh2G0Dz22vP/FmvNCDHqvOZCKHCNaf+lKg=;
        b=H2WFVNRh79H8n3pl65Ko0ju2J6PXTJVP7kvyP07yQpLunJrUeaCHLq4xugmbam7h6n
         j5kheMRsLTfajNidzsnExHa6WXhnvIr2icEnhhKR8s1MxWTLItWegdRXh/Ifl17Utwa+
         BhN714G0m28/71JrJ8TFhkZAIYPP/rk0fkTEEMeFQ3EGOSkeyr6FYRhZ3agdmWAzVwTD
         MCoxoebuiEzenb2ixr9a0r+ahE1Ig1pky/b05kHVa4++YmfXnPyrGNce2jzCEXaHav67
         dnX/piWc83DDyv2rQbAko9P7Epsx/NZ44MKSs+FKdsBXndkfq/qSN6zzANSinosZt1H1
         ILqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745464183; x=1746068983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2Qm9neShRh2G0Dz22vP/FmvNCDHqvOZCKHCNaf+lKg=;
        b=jm9mUdiidG04IZAxJSywfPea0hDBLJ+M8yETkuzcfI8vf0lY/1qGi1nmfqyeBwSd0A
         TG05ptfvowlNwW19lZPpvCXaJvegXCf4tH/HDf1BgKH4vhzZuLfgjmDdGCOfpyDYzLhv
         lto00Peqth2fXaGjz0MqJ0+E1CwSExqZ/ke76DCtPVN2jICNxCb3S5yq/iIqAeX4k+Uw
         hG2hXfRMNWcriIxr5kk59cjNQn8Pl3M/qDNniVHBtm5KpyHfao3TENqMs2OFewI20ZiR
         o8q26WDdOyEQFuYb8jca9k8fbMJdZur390JVmzTL2qasMd9Ym2TFX9HXlD+iyRp83Yk4
         GgqA==
X-Gm-Message-State: AOJu0Yyl4SRv8eycj9pO3QCJLOew2T2HwIh1jaW1jIwQLVboL+V9qTLI
	RjSAqFoEB8wcPQaZn4sDPgA9HLA0iGJWGiI2uQZYUJMzP2KeY/xAfoFcuw==
X-Gm-Gg: ASbGncsidHIryFWkh10z0HKlthxjTP27ptsTFW2X3BVhGS5i8/nrAeuE9BWlR/cZwNt
	tmtxcN6ySQw6sKmH8UMb2t1eMMixFzyOtXXx1qAcfyRlacqmDaTZpdNvthiXlmED3VMg5dN1uyX
	64DbueOWG9+8EG4rQbZqKaa8RxsdOaq3SAloMO36xl1Dy5phQxENzNGvtUZZZ5lSGrsrJ1bxikA
	tSjPEVRgviNRyz1bOxTDmjWNIuNhMX/JF2xqf2+MEHFNZp48NQ9qImqjEHBojGu9mkHgiLmDayT
	TzG3Bohnngh+/fQkmfDnWZzRh+xWw5jru4fExcUJyhaEJmU=
X-Google-Smtp-Source: AGHT+IHeSnhToq3/oXgiybYLYaNBf81GXMnfIMvbdQaMP/ZCj+euXmhopkRKw7jhcfaLttGBC4xg2A==
X-Received: by 2002:a17:903:3bc5:b0:224:1eab:97b5 with SMTP id d9443c01a7336-22db3bbbd3amr12518595ad.1.1745464182942;
        Wed, 23 Apr 2025 20:09:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.13.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f84a233asm236251a12.40.2025.04.23.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 20:09:42 -0700 (PDT)
Message-ID: <6809ab76.630a0220.224fa0.19a3@mx.google.com>
Date: Wed, 23 Apr 2025 20:09:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5125762252887440953=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Dump debug registers on error
In-Reply-To: <20250424023147.257095-1-kiran.k@intel.com>
References: <20250424023147.257095-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5125762252887440953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=956409

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      1.88 seconds
BuildKernel                   PASS      24.52 seconds
CheckAllWarning               PASS      26.95 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      24.44 seconds
TestRunnerSetup               PASS      462.89 seconds
TestRunner_l2cap-tester       PASS      21.17 seconds
TestRunner_iso-tester         PASS      41.51 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      120.51 seconds
TestRunner_rfcomm-tester      PASS      7.80 seconds
TestRunner_sco-tester         PASS      12.56 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.163 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.201 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5125762252887440953==--
