Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20C1E4BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191360; cv=none; b=MQ9zA8pyOox+AIqDGop72eyzwtaC7pYSUw1iU7TmgbVf7waZ8MAvFDeybfQRoGWj1xax6yMTGli2opyOKbX8c4od/wdy7UGL3hbghHpAMd0MyWon76/hJ3B4wpq5CCaeqsDJF0hvgXEZdX5hwIBHzfb/TXHHLD76DNd69obbgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191360; c=relaxed/simple;
	bh=yNkEKFt61FCkFV+Ri5e5PG4rKEUrpuEByRtoSFxRVzA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C/mIrEA5OnnQnPszRFXi9U+WFQjntGNlaR+TgURomXT5VKt+P4IZXUmjLgG+eqtFIlEcC4peMV6Jv0t/t2fNl8uERfDZpswLes77NfqePy6sggKUsSz5gwgXgrhM9mOL5VBwjF1VeAHJINEkhLsUf2+3a6yWihyh7F7jO0lOXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG+MoTha; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG+MoTha"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445811e19dso10437405ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191357; x=1755796157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgtAnevqfFJrx/b+zWv2Ln+wBiTyeuGMQKY2PMQDb1Y=;
        b=YG+MoThaoW67AwO028U20q+YPoZxqleLaNrZbfCoFndweOotvV8k1ILp+At9kDMf4b
         ze17yFyjbufBBE5aZ+1J/CABVpGi0LEda0QZ3BOl90Lpn26cLjg8KK05pcQd8GUOU56h
         gH+H2urncoiKNpkWIeAgXgVYJ7Pdwzd6H3fTSfRVG+qmFuG1iQEYpOojPaPssWotSGhk
         TUufpvI3i0zpZ5VzQNiWbiBom7xlQweb55WMIBPagwbgCIcJaRMBbIdJXNnATk9pXZ4L
         MzdXLkJahCO3UVqmAfisXEgws/sTEW22/EQYZFyuUervxuWMAj/+n2shXld3NJsB8Qep
         IjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191357; x=1755796157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgtAnevqfFJrx/b+zWv2Ln+wBiTyeuGMQKY2PMQDb1Y=;
        b=i9IaUtJ5Oxl56odbEv+2pSoSmRIdXlmVYZMPfQIfvDBqSH8vVYFhJhQWg2bbTP+LDh
         LSHGBA+r9tqS1UVT6C2otiScA9U/09086t9TCBH/RgRdegZZF7/zVC2KFMw6HJ/n0oP7
         7q04MZRExp7RfPwpYgqPFKT5X6i7zX7HUMdTl42BIn5sejhugQ6D2w+JI6jrRvzdmfj3
         1He/2vui72WF+A4zAcy5Tb01BwAlcBYao5JV0guN5uRW3uNbxz1OlI+q7yVks7fWSxbU
         R8l+ZfEvWVoW/AI+vf1i2XQPRWZuxCLm2Vj7L9DdEYpEbRXan2tEfN8zb49bS9lzjvv5
         Gk7A==
X-Gm-Message-State: AOJu0Yydqhhq28+zBCmmc0BMU6voDGGj2nGy3gIJcpEr+uCcedOSmPE2
	SrOm4rFS7zNDrPh66IwUv9Cg8QnlOZOiAehAdF70JzkSAirRzO24nRQaYzQnZw==
X-Gm-Gg: ASbGncs+Q4uZxpu5XoBfppDG+4aUYrH2rl1jOjqfW7uMqwWk9QDjKL/qvgLMa6w874r
	2qYwtANItJGAuIxHv8e+hXsWqVyn5XF/jij1a0QglKKzB+GjptSoIz7+9jpgDC0J0uKmcI3peBo
	x0I7DatWG/hs4/hq5iDvHHACzvG0ZtCQ9ZHQAyYAw5zrbBEPh6zhTL4FY5JFDBYwECZ+op/hBFv
	OvgBnHDP3VAuhGlgt1AZO3vQ3o+ydUdy2lpQVswl2mwbM8iKy4uZQ2jhk/6eWR/kzHg6Vis+fEM
	dG4XUdEkOFc/IXePiLrP4ad4qUAhxgPNDpnlumayA0shYR1mzP6kTRIy8imLU43QC4fP8rypHOl
	fgI85IAg9GPsHAMt9qJ+Xy4TKolB2
X-Google-Smtp-Source: AGHT+IFV45InIhkBRxZpDN5oBjACIx4gZzchwMcXr/+lszFE0L7Byk87nzXQXuK9E5eQ+bwlSrvMvw==
X-Received: by 2002:a17:903:19c7:b0:244:5089:ff44 with SMTP id d9443c01a7336-244586b642bmr55799605ad.41.1755191357425;
        Thu, 14 Aug 2025 10:09:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243099fc184sm61162555ad.144.2025.08.14.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:09:17 -0700 (PDT)
Message-ID: <689e183d.170a0220.248983.d7a3@mx.google.com>
Date: Thu, 14 Aug 2025 10:09:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3991694008204236523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/6] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3991694008204236523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991624

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      24.50 seconds
CheckAllWarning               PASS      26.57 seconds
CheckSparse                   WARNING   30.28 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      475.63 seconds
TestRunner_l2cap-tester       PASS      25.26 seconds
TestRunner_iso-tester         PASS      41.13 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      127.69 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.65 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.15 seconds
IncrementalBuild              PENDING   0.67 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.146 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.158 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3991694008204236523==--
