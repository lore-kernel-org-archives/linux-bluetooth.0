Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456C1F4292
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263617; cv=none; b=UffsExt8iE/B0Wba7tUlj2+B7NaXN6Yk5TyL0otiutDxHyZNO5BXMFASlMNd/PpseE7i5BGAi4ypurt6PTQfBFBtwsLhRfmhcoDU+sgPASTG/rBEuZz8YsR1YYI7kwARd1dJEcv6K01z8y+o2WmoSUYRKmhzQkeolCwsjzX5/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263617; c=relaxed/simple;
	bh=SxNre7YC37P28xhNYmQzTi76eovLdJLs5CkitKwbelU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hwMEAnuWNR0H1EBiEH6V4QAgATMptncIwcK5VuZ/1ybVLIAgceW27OFPK7om5Fh+eJ6fLmoCe3FYWVLweQI/mUO623Nm3rkoUbEx/iNw3nXNvnVizznv68MdVuvMXfgp8b178SS1s4ymnl/9r1mVi4yvHOVHjlGDk2pIDv0bYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ1hkjGZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ1hkjGZ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso132327356d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736263612; x=1736868412; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VcAraV4lkoI3GWrhkQcrOJfCI7VGFrzbXoTRX3LuozA=;
        b=AZ1hkjGZZJcVFlNF2vdJp9AFwz0MJHtdGCz81IdLkm3gyWBC/NfkoWCDpIlFpGlzdY
         kDwldi31sA+AKwqnuA4DCWk/ZTtmevf7JSArNhuIK/5n1zJSTtbzpQzS+pJ9YXmvtb8d
         Gehi6GsrPkpcOR8TdydFtJrCxMzVSl9IFKGQKphJj39EWiUroo/iz9cMvp4CsCTe7xU2
         XDQnKb3qB5Ak2jk7q+kwBG9+WjTKDSix2lalAkwKMYlYYIVm6OlBCyVA8KfUkHySyGrQ
         zZjlM8FnOxNqkaFyXTFFjA/mZn9uZd3FM/QlAPrK6zKinVX2DBZgY/HmJhl8F6w4JIZm
         pfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736263612; x=1736868412;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcAraV4lkoI3GWrhkQcrOJfCI7VGFrzbXoTRX3LuozA=;
        b=YP9NWh+hCodQX6ieMigr2RUmFVuEVENdwszU/NEzaNCGttG4eYryjFQZRVnTe0Kdy7
         L6ff9oQtz6doGcTKtigyZP5YxyOiT1Pa03RQ8qV5hYu5axmEn4Tv8lHNgdBiRqy2RE1J
         7ikdDhk8bA+takYfWTwnulZmeuyupe55CPbSLAv2eNk74OHF2FXgUeHvIa6eaAVKpVq8
         mMmdAXrdyMTMxsWCreOsBKCfp3ICn5BHnzG4yPrdwPBw2ykMs2MiqoJyYVvSxEfToQA6
         UkbLoI+dW29DD0HK7XWRNqAguz14A8G3zIf96kq0v0nPZeejWxHmXRFayJqCWvU8axyq
         Wkqw==
X-Gm-Message-State: AOJu0YwbjA+9pMSW4FBqUngQq69uTEdSFVr3Tktx24lubdatRZ0qqjS6
	60+X31udcTVqhd/7ecPPqQGmL+oibLc+9z8h5/wHM9mhSOcNhfXZ2QJ1eg==
X-Gm-Gg: ASbGnculdms5jjIvel4GvrQQOj8IwM3xpiW21SKIphmRJ0d0onolYncyovdATEPestm
	aVX3n1HifSl+oWnpH5iq+xYdqtGhL0BM8my9OVI5bBT3aJRnFhmOH0D+Tr0I0fNNCamhHOgSBHw
	livHFmj91XiS/v7qezvsR7wko0HhxHAESf1oXHJR3dzfBl+LK3bqMHlrPvsFWNDtbuInNVUdQjY
	YAZvndgXKcAXfydd9v+d7JNBI5CMGLJcpuqe5pIo6OXHPpcevzmO8aLm4Ye4zFgQA==
X-Google-Smtp-Source: AGHT+IEV5lp9ivV5yVXZ1iRdBdty60Ic72lE3UMV2jbZ5p/tqL0bp0xz5V44+/8cavyNnQek125bFA==
X-Received: by 2002:a05:6214:328f:b0:6d4:24cf:aaa4 with SMTP id 6a1803df08f44-6dd2333a1b7mr978302076d6.17.1736263612166;
        Tue, 07 Jan 2025 07:26:52 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bb525sm182009146d6.97.2025.01.07.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:26:51 -0800 (PST)
Message-ID: <677d47bb.050a0220.3a5b1d.c5ba@mx.google.com>
Date: Tue, 07 Jan 2025 07:26:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8347721553259445955=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20250107134157.211702-2-quic_janathot@quicinc.com>
References: <20250107134157.211702-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8347721553259445955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=922957

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      31.21 seconds
BuildKernel32                 PASS      25.47 seconds
TestRunnerSetup               PASS      440.08 seconds
TestRunner_l2cap-tester       PASS      22.70 seconds
TestRunner_iso-tester         PASS      32.05 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      122.01 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      9.40 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.183 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8347721553259445955==--
