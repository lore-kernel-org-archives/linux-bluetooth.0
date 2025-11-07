Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C912798ED
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522101; cv=none; b=IBDR8/U6Q9ZW/FLuqpSmfwVJZBgyZqZEH3kIdDTTaECabH5MDieLZSryQm4sfqnqwRlqngj117d4mdRzk5zhpUl9nqFTE6YPCeT2C/8CLYybb6i/u7M3wdgZ4XPXPoim8cSCTGiA9CJ0YZUxApJS/RzTLRPItlrYS/FwpboM8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522101; c=relaxed/simple;
	bh=jez9BdoxU8TcASQGE3M7j2PgKHBv5i43KhXREUiyRho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h+RTDMqiZt5Z8XPrwywl7uIJ/pVqb/d0YfvK6dHzgxUCuNGSQwI+Y1KPZ6keMgPX1FEQMkOmJDnGHx6F2bzKHuL4t3E95eTBVouyM/Eyayaga/FAE79qtnOSfl8v4hvO6mzjiM6zMWZLs1YmVqI0Sjo4Sgp2D2BMpW9ACgFg7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeP0Lb8N; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeP0Lb8N"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9486d008fdbso27497739f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762522098; x=1763126898; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fWcXzYCYipY4PFx+e5YSCNVMfuVX02aNwPd7JK4y8/o=;
        b=ZeP0Lb8NFnClFQQFz646MSBTqW8TVG3Xzcy7AO2vnBI7X4Bm1APzLFvCFRoNelK33L
         JP8tP6lKDn+6hhHiYtAP1I6aUEGeVUbmrg+mmx+pdgq/1gWPVq1BnyMgkr5YGa9smkEW
         cMtnQIsaSvGO8mWnIh+vF2bghLEE8y5M0Qd9jDlj9vbvO2byo3Eh+PQGUFGTpBHaRChr
         N9rY4dc9OEuPZYYMkMsvoMofbthiOAF87MoYBbdZON7tuhNlAjWdf/OTD5Tkhbxc95xr
         aRDFv4edaRT8dBw405x2bN1o3j0bG96NoU74dPHesk/WoN1pbII1nlocny61JHwEqkZZ
         nVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522098; x=1763126898;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWcXzYCYipY4PFx+e5YSCNVMfuVX02aNwPd7JK4y8/o=;
        b=KVZbgs8GToIi8ML2ebTfvuvy2o9EOUEWrZjmauUihYogVdfXi89vrXNl+If8Mt1N4+
         WWHZiOmbIjwcfqQWw85v9FBKHlp+eH9Fi2lmpv1ldk+cdMBjx7dTS+h9FtS91he+BCsD
         6jlo/JEazZkhscAPsWpCyNGB+NnXo5yY3tSlJfzhsE3qxt4YefR1Kv05e0jnrIvKdWq4
         ssN3EQBZok0qHjCYkv9bqR34DMetBGVp247G519gHhuIBP6UejJA3rVOT6jNYcDW9W3Y
         bkLjEo2IbnNk+12n6VykqfQ2RJcd+kuqIMbBWGIPrqN/x1Nsom8bXa8QAmqxziPAYAqw
         Lx1g==
X-Gm-Message-State: AOJu0YyhItBEJtE+Rtb10ergWuDJlt8GKghHi0b1rg9NYv66yOyK0nCZ
	OWkoSDWS55FJHPcQ1GwfzywOJjO1NGP/mEp8FmvBr03VQJKJBO66eYr+0+p7bw==
X-Gm-Gg: ASbGnctgTiUGxwUJZCCcCifmB9q0NrW6Kw2QsYPMRnYDj2mg+JZtJQ/J7meHualoFvo
	Sn1TnZL6kry8zHTOVEhZo3KdHnpr7/7EhaR21M29ULR+i/DQRW3dHEYmGEVtDbSJSAwE5FVm8c+
	k1efSVXri5P9W17+6P5ltYp9WzYCe4xzoZ4JNzWplCEBX7/MbNGR3Ynls4MjBIHykUYF64OH8As
	ZVc0h8xUCBL7vIVx7AvkUQvLXP/+Wl4pNTUW1CDJX/TZt69Q+UqgV2RBVZTu+Gest83FkAR+wQ+
	YBZIisFQnPkVnK5urUcpPM8Zq9C+j+D3JT+/Ay+IEDPLcVm2h+n7gtLsL3TJA9i+lgjHLZs6iV4
	qXXp5Fh5scfEvezjfTw+aTBNyeD6OVSq8kogLjkuVZ5iM9JDVoewJaUkz/wW9wDLj7CUpwk/u7u
	UxehX8k+s=
X-Google-Smtp-Source: AGHT+IGXTj4swFwdWrZyJNtGJonm8mLJbKbwFQLtqueo3/gAsW9FnfJxClsBOI8XQuV4awJ4oMGspQ==
X-Received: by 2002:a05:6602:1544:b0:948:7163:9b2f with SMTP id ca18e2360f4ac-9488d8f2c2emr210565739f.3.1762522098096;
        Fri, 07 Nov 2025 05:28:18 -0800 (PST)
Received: from [172.17.0.2] ([64.236.142.131])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888d8bbd0sm90064939f.18.2025.11.07.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:28:17 -0800 (PST)
Message-ID: <690df3f1.050a0220.2afde1.17a5@mx.google.com>
Date: Fri, 07 Nov 2025 05:28:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1083434099908741285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Bluetooth: btusb: add new custom firmwares
In-Reply-To: <20251107125405.1632663-2-quic_shuaz@quicinc.com>
References: <20251107125405.1632663-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1083434099908741285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020879

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      29.96 seconds
CheckSparse                   PASS      32.89 seconds
BuildKernel32                 PASS      26.50 seconds
TestRunnerSetup               PASS      511.21 seconds
TestRunner_l2cap-tester       PASS      24.08 seconds
TestRunner_iso-tester         PASS      88.62 seconds
TestRunner_bnep-tester        PASS      6.10 seconds
TestRunner_mgmt-tester        FAIL      116.07 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.43 seconds
TestRunner_ioctl-tester       PASS      9.84 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.40 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.970 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1083434099908741285==--
