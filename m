Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDED1D0143
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276466; cv=none; b=YTOBRhvn+hFsirQAeMh0OXbTU2RWGlXaqggOnE1ZDO7PTKSBQ4B9w5RHRB17ChudAV+bhyt7EmfqFtUzBS4JDH1wAE7ybWZKMOET/4JWU5e1/OOK9QXJim0/Uj8P4Khf0FpC1gt5b1nx3j5q76ywbEHzPzhEvU2b3p/IYNViQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276466; c=relaxed/simple;
	bh=OKSA+aJzQQf0HszMgXVcNzPG17/u0R/RUMlkxH1se68=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z1BEG/Y75vslarMcsvt8aT8T0WM4BwAdoTVA2cqXiPWtFWwpy0hF5ZrlA8ntZQYb4ydXrdd8qbgXS5nM6TwWy7FOeT+yOybDkaxtrYrw+a6qr1RS8vax8UzWWIhKwfzLlA7skHkW4c5DQzIabBnkFM8yVynYVM5WSDZT/zI+ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlsmrE5q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlsmrE5q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1603636a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732276464; x=1732881264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7hs7NMfnnpGhx7J0mMtRhZvKyNe9WepV7IwvCo5LviI=;
        b=mlsmrE5q4PNJ6Vcn/VTTlkD9DZA70Wu+s0aZcA9C6jMh4Y/ojHojNB00lLtjWxybJI
         1de/kupZlMZgETKYcU96sDPiIFp2S+hCWU0YRvemroZ4mHgVX52ig1OTRCobneVhNxsi
         jkJnFvNtRdBRMcBW8hXWzhkVPE5NKcFtSwnEGQmCDllknMKJ1DFcS6y/QE5ITOeO1u79
         2r/35ABTfephlePD7Uqxiu8eDKNCMDR+rJ/QKyxIn6TdHI2oKFlgSohBsVaok146l3ow
         nGNcEznNfio2TZwAUUA/6jBqOjlv+BKp4LzQI92lGyDjfMGJwmDqa/Af+zkEKsIe/oIr
         zTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732276464; x=1732881264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hs7NMfnnpGhx7J0mMtRhZvKyNe9WepV7IwvCo5LviI=;
        b=wTUh5RUsqFLTweiG/CJNntD4NlBieUkRPyQyVNm9M9o0UEGy2MnfJ5dQMhkXjxJ6l/
         MBUylLpul4fXSeaIwT8PojzWnZ+UHrI8uvpoa0r9Tb/PEAryh04b2VTx8jV9tBrwXBM2
         RMPFwJ+dxajIPZyiokmVgY/0KrKfp78qswjyhpoC4TxPuFm+mT/dRbbznBnJ+oTdFr8g
         r9GgvDkyebRNfNRxVSTScv06nknHrBuPi2eBg6tB+SdRdS6P8nkxoB4+nF8vfm+ZO+F9
         C0rEMcNdZoRltyckww0+2PBAZ+y+vuHW8F6H+c8B2v0xSDmJuBmgz3Q0sS6ucK4b2E5F
         gRwg==
X-Gm-Message-State: AOJu0Yw6zxM1yqK/N53rPG6sOu7gVwf1TA1a42jRzeRq+jiN3lhWi9vV
	DmHSnkC3NBAteWf5eTwRl4bnI0SZriO9+iNCQIdmDysdZ2WV8QxHOo16VA==
X-Gm-Gg: ASbGncv4x8V24fSxLATxnOMNH72ulwTgjcLzs9IvRUuHnGo41+ZGwtHqP1ypAdTJBOr
	3edf9lnSwPbJVHmvNttxPfBJTsJG/ggb9raYruch/DN86FmW758fA6eDppoTD5phC4E4r5AZcaq
	3eExm+MPGZApzc6I5Vnu1Tr3x2g9YI296cvxd4pALH4FWXLq9EqY6csfc2r3BK2O61maU6z3Z+9
	ba5c8GfAlUx19yX14LRGvGnInMTq2HK0c2/w6youqyi4MA3J2pC8ngt
X-Google-Smtp-Source: AGHT+IGgO4cHcnELfrZC1wrVXFV4oJv492IAnCo5Bs0eLw38EYCbQZfaLyQqY8lg1iqt8llEa0qLhg==
X-Received: by 2002:a05:6a20:4313:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e09e4a7b38mr2977778637.21.1732276463861;
        Fri, 22 Nov 2024 03:54:23 -0800 (PST)
Received: from [172.17.0.2] ([138.91.70.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc20b7fsm14321545ad.242.2024.11.22.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:54:23 -0800 (PST)
Message-ID: <674070ef.170a0220.1def10.55bf@mx.google.com>
Date: Fri, 22 Nov 2024 03:54:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8514908988668982132=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangheng@kylinos.cn
Subject: RE: tty: rfcomm: use sysfs_emit() instead of sprintf()
In-Reply-To: <20241122111939.3799277-1-zhangheng@kylinos.cn>
References: <20241122111939.3799277-1-zhangheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8514908988668982132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911766

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.47 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      25.40 seconds
CheckAllWarning               PASS      28.11 seconds
CheckSparse                   PASS      30.81 seconds
BuildKernel32                 PASS      25.03 seconds
TestRunnerSetup               PASS      444.43 seconds
TestRunner_l2cap-tester       PASS      20.47 seconds
TestRunner_iso-tester         FAIL      30.93 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      123.15 seconds
TestRunner_rfcomm-tester      PASS      7.52 seconds
TestRunner_sco-tester         PASS      15.47 seconds
TestRunner_ioctl-tester       PASS      8.43 seconds
TestRunner_mesh-tester        PASS      6.21 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8514908988668982132==--
