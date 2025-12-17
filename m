Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14633B6EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972949; cv=none; b=CJwVdde9ViEcb7O//B4EJ70vj8ymRNqiE/TFcaGlI8vMYLMn52ryUL8Nd/AMdiBFV66ITIVN5YehvxwhvcLe+/glvNjx1Rswy7oxhkA3qQzsSjiMIespRK4gN7f9vrxB39MZlsszudD+obCtKS9uR43FqOKbTfdL30rCyN/zeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972949; c=relaxed/simple;
	bh=AFH/7FbX5zEnTWzSJ+hmCsfjGWqlwln1txTfhpuQwg0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HqRMGlmGZIGwvTnpCdtJandGt4Q4fXKW0JQzXJjHUZeSVQLYmqBFXeYeyJQEgS7HkiR6edL+qMvvAZ3CYG0GTtUahJWUv1S0tgbJQ8D3GSgYxSAF3RvBI/5BnQwe66eeMOujX48JoBCjn3gltanZ4XBrDJ/J1zpWtuf9Y5oWH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1UdBXiZ; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1UdBXiZ"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2ea2b9631so582835685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765972944; x=1766577744; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U6EhffOEW5SjkECFYijJ29Ttppkz07x9JuV6Gbt2tc8=;
        b=A1UdBXiZwJ7lhJkHfgV0TFDw4x/snzl24fsceka2gAUalvWscUS/66VlmWDxaMQBAN
         gxyRNm1zllIaU2kp5zCqnuKuo5jvj6ALV2OXW03EdC+flS8F8iMo+8PmwYC9nq/0CAxi
         faaBRZ0tIE0+Zo1feZCtBK6YSZHvrbs+V3e6oJ/1ipXPE9kCdWSKVPrUbmcnEmhEgnRR
         vmzxfXs4O065820HJl6zdjsC219m/4pUS794uGfgbiXiD6Wf/yiN/zjTsC/cjjUGwDAY
         zK7f8+4XHJpRTz1X+P2pOcAv3dioN4Q/AE6cEYBcRShJ78kMNjuEzXzPWGwkb4JayGYq
         5Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765972944; x=1766577744;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6EhffOEW5SjkECFYijJ29Ttppkz07x9JuV6Gbt2tc8=;
        b=fUtDiTavV4FjxayGfFS/JaNECwN0ja7LfYcZbgqbYiyC1CeWS6HKjhoUXCM0j1xXgm
         4Oj7+ETSrRgL31VKGN/2RbamgEk+PNgA9XYiHoMV27U4MzmYJT1gwX4hPw+dRToQUQKM
         X/xnm9fPu9Y727iX4ABgZ/0DzdckuloT8eja4jlTcm8fyJpzQm9WIUGpxp4q1vwFYa74
         2VmYUU5MToIW62xWr91DDO68jgIxBgQbrVVC9CH8JvvSXKcmUwH0P7HVwGlItBnh/tGi
         aI+3g4Ysb6fCnLDexLI2yes+9eh5uSkoARbhDWSsVdZhntszqtwaFMSmJtefHfj0nKYj
         Msyg==
X-Gm-Message-State: AOJu0Yz8ZqG/KRyJ3TD5Bqw4bM2MlozlBHxBVaG9Cs0SjnODCdmRNaOD
	Lr1b7ST4umMR4Y+uzDebuzQp7izxu9E9I7fWTxwe/wjTOPYbmrhmivmXU80PA57T
X-Gm-Gg: AY/fxX6IZgtIPXz2gDxkwDFa9XjVcPTYo6won7rb1UBuf63vdLQinBHEW7PGeRhYnaC
	5Xtnm/xHC2imqYj32S28bbEGFjeZMUpQ0SICXQvK9r8f4dnpK57F3jVzHjLkqkth8hcTBCbhiD/
	oAybADOYxAojt7jI0wlZq4Cl8z0XleUK9yQ87Zmz5JA5Dmf/BcUWbWRTGPFIknYLTifA2Fux9dE
	FAHWV4/hdRhwUaDjRY1diev62cnhFjd4swwP//A0vA6+SPxZse+t7eZeR/06DS8STUwPo4rRshd
	EwTBauK4JQ4c9NJSi1XKz0vcQd4nKuGmaIktzOYJxnLr1WLLw7SRurmSGDDdMQPyi4UxPrElS7F
	QgHfZgdRh652aJgGaZgvdgA2R/dmJJ/2+wbpRgmZQlmiIcmKJ1+EzT464mxRXQoCY1igkd7YSGU
	dkg1eYCeopU/Xa7KOf
X-Google-Smtp-Source: AGHT+IFWuVtkZX3flrpuoYqja/mrbzH0lvIV9I1mUzEl0nAFyaW8srk5yk6CRGprX2j7ZTYP/1noDQ==
X-Received: by 2002:a05:620a:4714:b0:8b1:728f:952e with SMTP id af79cd13be357-8bb398e2713mr2765889785a.31.1765972942096;
        Wed, 17 Dec 2025 04:02:22 -0800 (PST)
Received: from [172.17.0.2] ([172.214.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75ddbsm387680285a.51.2025.12.17.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:02:21 -0800 (PST)
Message-ID: <69429bcd.e90a0220.11a91.5c6d@mx.google.com>
Date: Wed, 17 Dec 2025 04:02:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4824100936048770305=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vivesahu@qti.qualcomm.com
Subject: RE: [1/2] DT: add bindings for QCC2072 Add DT compatible string "qcom,qcc2072-bt" to yaml file.
In-Reply-To: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4824100936048770305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034170

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.54 seconds
BuildKernel                   PASS      25.46 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   PASS      31.15 seconds
BuildKernel32                 PASS      24.88 seconds
TestRunnerSetup               PASS      547.79 seconds
TestRunner_l2cap-tester       PASS      25.22 seconds
TestRunner_iso-tester         PASS      81.73 seconds
TestRunner_bnep-tester        PASS      6.12 seconds
TestRunner_mgmt-tester        FAIL      116.04 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.26 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.166 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.154 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.987 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4824100936048770305==--
