Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DE22C9E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045234; cv=none; b=IMvb8nQdJh0h+c90wis8FyCM49C5ise8LeIYJTzp53Po/rJKVp3P5+7orOywVgdFD+r4Jjy96UNihbi43EFa0WrOXMVVx8W3ddE/or6Zm4XnxD8047QpkF8eY6aYGEAzf8cLGZ/IdZeeZMBNbtulEiqRmPWKeYn4bAoE9VuJrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045234; c=relaxed/simple;
	bh=/HOiWSbGuMK7L2lECLFZFTO21RkbL8+fvuHwx8KNxKE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ovHoP7aJaYGOtWAWzbSwJwKx+tF00LHpK+NmwI++HMRgrRzBMW4BO9nHLAmk9S8JU2EH5yWb/x9nnxb4jctfAPysBQ23OSNEvy1CZUhfbKt3tsyOYqkqItdhCBMNdDmCUbTALdrop9ybUdNvyscpVCEqgjp7gtpJn2LoUEAeS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK7RRHT9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK7RRHT9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be49f6b331so92060985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737045232; x=1737650032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B8O2Yj1u29ozHhNrXfAVvHW1bhuCEHkqFwVFy6jjWXA=;
        b=QK7RRHT9QHDIEDXCs/yDBPRYHHaQkyfKW9ZG0jco0wwSwexQvWnMU3ULW+3KYpSPT8
         cGZ6f0bOsi+CuA6e8PTWN1ewx7OmeOiSK79ElQ+1sUrLcmOilnShxRk7+XAs9Qn2s6W5
         fbFOb5/qAWFXqvj52auqtE6rpmgRSV/98p8vFKUZyz2w9GGUbK09356y2Orf6bJ/dQZR
         Vlw01P6daP6AGR8zNxqWPvUVzdSn69/71qb+NdFNsoozFG+Yw/rGwnAb6Tbeb91A9Hsk
         2dzfkm2/DX8jQKjamr8S0+WorN0tPrhz71hAydRj6QpooDTVMRtAfLhAeJ4+ktpEYeJD
         +bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737045232; x=1737650032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8O2Yj1u29ozHhNrXfAVvHW1bhuCEHkqFwVFy6jjWXA=;
        b=e5fXFXVt9SRHOjDjTxWirtMWRf4eYTiiUXiyY8IUBlNjZgSoNjTfC1uttex2ds9mtO
         TkQYrSjhAn4OOeqU7H3IpTb7haL53/Hi2yyXi8iyDM9+nxyMQNmEjIKfOoDcTP9ibVax
         jNx6KR6jEeQTEDgEEvtFl+HPwQfvOGQul6WXW4fX3YH4zWjGcsyeQzZOR9t2ok9saNcj
         GH5GPM4AGMaSUVg9ymEVrt25oh482VLi+OMTcTxmelyfeTIO9dZ7BgFPrsstEIROPbHa
         PIHteTymbTVI+InRxj7f8dTpCpwio4586lemnPf1FBWBsQ5lcdI+VZixGeEiquTjI11R
         9BEA==
X-Gm-Message-State: AOJu0Yyl8s7/1vUByxPxc4bZyTV0wpU2Xa85auYfNQkoZU/3u4hp82FC
	KfJ9oGdvxMkkCh7tL8fl0XQVN1t27Cqs2mipySrRGT74K4Oy5tUytMnTUQ==
X-Gm-Gg: ASbGncugivOKfY7joak8Id0XqbepCTh/t2p3Toh7lWtVhVNzX5lGaK5/5DQeDBEccNH
	PSLpE3PVp65GH0T1zuaC3bq/M/9iRCbS0X/z7TexxvbfwDXD77wuAgyNZVwoZ56bA9JkbmaCBcl
	kUB+uNkjzK5UismJuIW5MbSSH/lEiYqeGsbWnnH2SzzVnTmVsk8KlLlqmHDFO+Bd1shE3Q3ALSU
	QxL+zYUNykTN1lCMjaNnaDxvJhXyHSWZbUlQBevYlR3H1ow08wJ69vckL9Y5w==
X-Google-Smtp-Source: AGHT+IEXQYhfp2X2WG72s+QPqeUbIgtxHSHivVuiV+aH5q5ubpgemywXeErq0nRZ3LkSXDD0QE2iEw==
X-Received: by 2002:a05:620a:469f:b0:7b6:d4b9:b5a7 with SMTP id af79cd13be357-7bcd9727ab1mr5735232885a.6.1737045231869;
        Thu, 16 Jan 2025 08:33:51 -0800 (PST)
Received: from [172.17.0.2] ([20.246.78.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614dacd5sm19182385a.68.2025.01.16.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:33:51 -0800 (PST)
Message-ID: <678934ef.050a0220.114131.1fda@mx.google.com>
Date: Thu, 16 Jan 2025 08:33:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4147533279912821065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250116153635.3689890-1-luiz.dentz@gmail.com>
References: <20250116153635.3689890-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4147533279912821065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926129

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   PASS      30.08 seconds
BuildKernel32                 PASS      23.88 seconds
TestRunnerSetup               PASS      425.24 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      36.91 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      120.24 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      9.36 seconds
TestRunner_ioctl-tester       PASS      8.03 seconds
TestRunner_mesh-tester        FAIL      6.20 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
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
Total: 490, Passed: 481 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.170 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.155 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.166 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.151 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.109 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4147533279912821065==--
