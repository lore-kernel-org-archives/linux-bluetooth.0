Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913414A4F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351370; cv=none; b=GQ/PVM0pxFLDWQtm6gbTBlXqq/H2/24ieJpQkceG9WVFBqlTuquBgt2SCHMHAWHRw6ALga5MpfajUceYG5fKpZCpAkG59H5fsMeasAiWskgEBKThXLQQRaTkTQliSuDPKofoNmxewbSCQwTRcNShcj9Njfgv2geNGaUKEcieGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351370; c=relaxed/simple;
	bh=6GouE/FTHr0xJdNkxW0BJFOl7i7XDA3PY4nHmI2+S6I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DxchChAIMk/o4043BE3HUUByTXgpq+RqmzmJaWsANtyIuYpuGgRw3LJ3y7jOpSKcNi8jsdkrmecuShQDS/5lIogt+ub78u1R+0Eh+czjbGbFxFB07lBO3hJbD0iLVYuHz9C7h/MU7ZmWbKv9gI8au5rgwL3H1QpvfmBPX0qGb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+U6q9S0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+U6q9S0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4750bc8d102so17746131cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 04:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741351368; x=1741956168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSxj0q57EkhOv9JIufCtC5RN0B38feRfbDhNEXxmmE=;
        b=H+U6q9S0ZblYtqz9uhKcDLZYKbyD7TgaiBm9iuG2E0hY7YYAAloU9HV/E2Q/wWwRRc
         E/Rry/48a96XuLZGLGHPPkqJ7JV0mYc8w1RMjQU26aqGVeRS7j7YJn97kU6Prq5bHWlW
         aQZSFQAWENDU2EO5fjeGF9M0qyzt77VUR1jn3NVyX4mzn9QgGQ0ILbovqItU/hSmdCFu
         WzswzcW+AUwlMOFPoVhsLW5ChLUaFmTEXIxcHEpCPKhWNIyz7a6w/oAP6/YCOIkgY+VH
         cTe9+ENVpkkCwIidN58LwfLxvtvFshbmZIlz3WhtpE9skcYYDrs7a5UTX4oE0DKbrs2Y
         kvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351368; x=1741956168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYSxj0q57EkhOv9JIufCtC5RN0B38feRfbDhNEXxmmE=;
        b=bWh2lw6RilRHVJVaclLRdgUjHRoUOns3xqHDxnVGaX9U6gbjkkm59DcyoUumuz5UZ9
         HObNVJwjR5OM89apM0Qr9sBGOJijOesT3OoSeBKQ7Wjg0s20xs0op3XKK//6UgZX34t7
         +3BxWwGKH/yxg6U6oEHNjHlJ/xwN6LjaVWQn6LaBb7UyrksZvstcuX5NM0niNAAMEc/R
         0J/tOyGEivD/tVyB1+x+fMXE107A24JkQAvatWLobKmxHN0PjcD+BwjIGug4ubY6ftud
         U/RM4u2lzuNrXUvWraxK4DZQDMXfl78j9L0yQpnC7jT0NMJEgJwXpZLq0mn1MyUvQ/LB
         dalg==
X-Gm-Message-State: AOJu0YyZW9QwYILg4rpy7p7MeGwDKfRy0N961uzWXdn8xxPjDp8UhQK1
	Ikgjye2lXoSqMczJNuDFHCD9pvrR9nEnNnZf65maf9LqPDuYWAqDNvac49FT
X-Gm-Gg: ASbGnctDx8Lo3CKuUFc8NPsjsxrpPznDe0yezYAOl7VRROucaZHlpuDM7TEkYHprGmP
	i2j9tupIx+HCrTH7nMt5pxK3yRG6j3Z32Z67ohSTOBtSC4znmGtM4S8vUOqY2DoCZO8JyU5cGIF
	3Nd00FdHOOSAxNGCi1r7x2Oyyu4Q9zHkK1MExwSyE4T2LsF6td9jIxkaLSiKFpP6PYMU8tyUXJZ
	uGX1VxHI5Mn0Lx9U9rOXtrEsrVRyIpZ9/K/DN+tKDKqpDDZfxf7fqYNdK4+gmBnimRJ2ywukyRU
	IYxwhVFm0b95lz/BaDvnTX/QR6sLm308DfesFNwMdMb/XVjU
X-Google-Smtp-Source: AGHT+IFBs+eIjmfGJw9wrthMcmzAux9+at30vaGzE/zR67zaa6Vel15hWj8GNiyL4KdLJG55FLojdw==
X-Received: by 2002:a05:622a:1a88:b0:475:3f1:191e with SMTP id d75a77b69052e-47610954be1mr44855641cf.3.1741351367894;
        Fri, 07 Mar 2025 04:42:47 -0800 (PST)
Received: from [172.17.0.2] ([20.42.51.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db2f896sm19803011cf.54.2025.03.07.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:42:47 -0800 (PST)
Message-ID: <67cae9c7.050a0220.2c583d.661f@mx.google.com>
Date: Fri, 07 Mar 2025 04:42:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7418715843682558152=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: Fix leading white space
In-Reply-To: <20250307113408.291310-1-kiran.k@intel.com>
References: <20250307113408.291310-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7418715843682558152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941483

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      24.00 seconds
CheckAllWarning               PASS      26.41 seconds
CheckSparse                   PASS      29.69 seconds
BuildKernel32                 PASS      23.58 seconds
TestRunnerSetup               PASS      426.65 seconds
TestRunner_l2cap-tester       PASS      21.02 seconds
TestRunner_iso-tester         PASS      35.29 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        FAIL      120.86 seconds
TestRunner_rfcomm-tester      PASS      7.77 seconds
TestRunner_sco-tester         PASS      11.64 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.53 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.166 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.187 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.178 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7418715843682558152==--
