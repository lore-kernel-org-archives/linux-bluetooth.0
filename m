Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6E2F43
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064524; cv=none; b=bzHex2UZeuw7EEbSkxIpG5TjVRYZCQMjKT4xNVZtCCOd8Jjef3SFMmMEgurar+JrB8E19UuavIzE/Yhd4Gz7kAFB05/Lhk9lFT7HQ945JGa7Hr1NjeiCdqKz+v7v3uhO7sJxttyEFx7AAILZDUqINGEAvSf4XW3Xgscc/3vbdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064524; c=relaxed/simple;
	bh=lzUi4NUPjdtNQMVPjDKlf7r4vDS8FObDM/Zd7sBGvTY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dEIWQN5flX9eLa7o7XRcdYbLsT2D0VSG+4mfcYiJZA6Iiz1HaC4YJyLYOyvOTDup0t09K59PSc8gv8vmpOj2eMMwQYYmdJ0VCCMPmiPEXJGazN035eJ0y2CqKOiOwBRkhUiHtiyxf/gPCJiBkNX5iYP/eNnJKvmzQvjFu7735EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGOOKso1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGOOKso1"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15467f383so125757185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 20:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734064522; x=1734669322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/H1yskqsgwPiKjhCX1LYZTaBkYj2YWZsDbqE0aMtVqA=;
        b=mGOOKso11X5tE6z9D9+vODPPPzFqTmaSeFXAxFzSdhMjnrJxJ2wH8f1rDmgNEdZLYC
         VCqBRX+FAAV/x20JjL/bX2irUU81xLXTQwDy/tHXIOdmQcmoS6mWctGPMOXAqEIPjnSj
         nsopKBF4B8hrJL42S8kdDb7w7G5gHPXRQ4Hr7OKL5iNk3DRPE+YcQ0OEqpPqAFrDK3Fj
         7u3/PD2pvQrnzQsf2pgSxkPhvA/qlEjZE+A/8kg6XK8PFFUAwRiaMt45GHv43uu3vEvj
         wlqKhaupl2Q69DYGLzqfDWzdG7uiv5xI+4flLUyTCXeUTVcRB7mN70+2YQt0CfhbivF+
         immg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064522; x=1734669322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/H1yskqsgwPiKjhCX1LYZTaBkYj2YWZsDbqE0aMtVqA=;
        b=TzTERLjSZKWjfe/TOA7+Zsn3SZDrqKzTFn06RLS97yE3SHbSSZXRi9CILZKn71ixQ0
         C8hVS+0vwEYb8eHlCYMrwdmwafVX7Uze2Smyk3788IN18uhKPOQMZ520O8bnvHJsvsYF
         qdniobm6PTOli27X2/CkPTvbu+JTvqDGvF3KjI2HMjO+PnDK5Rg13XVhB3XzdHPI2xDe
         M9zT5b5p0tBXL9GrcZS+LUY9W4LVSVTlmN7tFJ15zmx7HnerdRzP7EnR51lSk/ZZqSa9
         1is9K5BUVqR7mqd4q/3uiGUYchmkx0i33ID+6ERwQvXv+opCzhcO1Lukuy3Ga4cXW07V
         Jb4A==
X-Gm-Message-State: AOJu0Yz+Mcf6DSfFoYnGQtaQ6BCoosEgWCOrJF4GVSYrnL52h/I7cUzN
	A66s884hIi7T3YnJE2hovFDMgZHWX6htDCgkIFUExEyUVBmpbFansDbQYQ==
X-Gm-Gg: ASbGncsT/w6Cj0MgrZGr33szPIc5mROQVtdEfpOXVXKEYvmCDqg0NsSgFmJRQX4HFMn
	6fMBaWTq/XV18Izz23PQUDkvQvZOWE7ZTmR0Q2T4oHW6/ct7wyyOGyzhxDvkaqT6Og4Yj7CLS/u
	zT3LC0LoPuhYarGyHIS4HxDLswEB24bOZnLZ34OudYw6oJQayMa3UhlhCj1GqJcX3ccTo8oTGFK
	6XHweJ3hoLZ9ADPjryNn1aOG0hM0OobZfVXncsTMnXRIQHPHdGkiRfpz4Ge1yNN
X-Google-Smtp-Source: AGHT+IEvU+m5pTmKg0XVgNP7hQfqgXFkfq4t0USOCgYBfqgE6IBidZHp/yG7imxqK3yR+zi2j/1zhA==
X-Received: by 2002:a05:620a:2729:b0:7b6:670f:b91a with SMTP id af79cd13be357-7b6fbf3a7camr182163085a.43.1734064521987;
        Thu, 12 Dec 2024 20:35:21 -0800 (PST)
Received: from [172.17.0.2] ([172.183.132.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467a9cdb836sm823701cf.27.2024.12.12.20.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:35:21 -0800 (PST)
Message-ID: <675bb989.c80a0220.55725.032f@mx.google.com>
Date: Thu, 12 Dec 2024 20:35:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5904953454850431455=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
In-Reply-To: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
References: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5904953454850431455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917446

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.52 seconds
CheckAllWarning               PASS      28.65 seconds
CheckSparse                   PASS      30.25 seconds
BuildKernel32                 PASS      24.18 seconds
TestRunnerSetup               PASS      430.44 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         PASS      29.42 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      119.16 seconds
TestRunner_rfcomm-tester      PASS      7.52 seconds
TestRunner_sco-tester         PASS      9.32 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.61 seconds

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
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.153 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5904953454850431455==--
