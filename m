Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF21BBBDD
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739100505; cv=none; b=DnViZI4OsA8AFv2rDn/FPcxDh2nFHI2FOGxydtH8dx6rT2QZbk+H4ZWSivKxcKrIObSLIxJKQITm0+g/o/kpeSPqIxhKUNTVy3RQ51JwnCVqNqTfevay/W07+gY59PzhCeGUkjtjv7GVrQgil5zJO2H6jUBC6xTtWI64tnSr+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739100505; c=relaxed/simple;
	bh=4cChaYZrn+fvnjX6KeWYDZAYR5IB6IC4oMRrAD83XQQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kkJZrr+8v8MsUDP9MVcan9pOAlZYRYDK1uEQAAtppkZv7OFi75ns50Fm850rNfPAG8N2vJhHzzzJBB/ND5CeCD9fLReJ34b2WDEAVrgzE4cHV5VRJ+Q00eco/4b9K7fLumGgrG5cRu3nzlowF7qMTOd7UAXFGGZw/A3GstKRk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTHg4cD2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTHg4cD2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f2339dcfdso54416395ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2025 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739100503; x=1739705303; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9XvuwUYxyu0u191shFcSd8todW/2N5HBMiw23F3dYy8=;
        b=aTHg4cD2b9EMKXmprCRLRF/9bmlg5he2p8yyqmn27xlcLpzmf/QCuXXfk181A4KWDz
         XA6FdpmdpNzGtdigiABw6zkNQc7N4g+O/0z6cNazWcNMi9hjHX+oyhtLwlG6fSnaiHaX
         I8PO7iXQXsII+kWhpgGz5PfKR6xB8wjRgvIRC23ZJlLe1cqIAc6sv83NnD1j9M2OrU2A
         2IGvuNUBl9apEIL2UE9fxPgAAj0OjAkHszBeqmQKk0xqFjC5gpkX59eyrlLkdjlDyn5W
         sA3hZhmW/FSQUiPsZ2+E/PN2b4FWsSgYnURxVU22k1484cchvpN7QmHTOQjLQ3GTL0w3
         f3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739100503; x=1739705303;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XvuwUYxyu0u191shFcSd8todW/2N5HBMiw23F3dYy8=;
        b=hSuHCzhgfRMgkWCZYxwdy4l363s92nBVZMTl5V/epeKzIXOnYS36ntKdx7cTgNPUSs
         3xSJqDhoEJICr0AUM1HXIyL9mQ7GkafQ2ErW/hr+mli/SetmTesdg+gsM8nAOjQP3lRU
         8gxXMPUxk8JbFO4v0KxNwoF6Uyxu5glU/egWmrivFPfNAS2dOLaXtyiwQ3ptPwxoJSiE
         2inedBIRrL9qZiPTmlVi49jWPdq19Ls3th9o2PCMtCs5g+WCB2x1H/psZ+1/+SOIZhNJ
         Ow3h1XXJDKrkoRcRaZ0qM5zwjqcsrp/Ogng49iILfGL2JqNS8Y3V4GCWyAQ2N2S3Svk6
         5Erg==
X-Gm-Message-State: AOJu0Yzi+f9/ylqfU2GzJRhex/RHZlHHhDhK19HbsAxVAACwvvnR/DBH
	RwhRiUk12iolOMNjehaz7K7XOjC+Qg1N+nuO0ddTtbMJvu7PPun4qtDM7A==
X-Gm-Gg: ASbGncssf/mvNnL6PajKTa85IyxRFTBudiR313i3GWQ7tqqnXXLimZdwwk629bme/W/
	eFLOZd9is07y6vskdtMphSCZR6+vWrhv/W6mgIbdv08Vkz09g2uKWMXH9aQQtFVZZwjeIcuvMW2
	VE/BoUmaRgAQl2pmaZo54UJFNBbh6p8NK0pEGNNFHosABCU9bcd2Nv9EJW07HS5QxH7zPWcosYA
	9ZP0umgyF0girnjvicCkx1htf9kekNVVn4/bXIgdSH9r43i3FpLYiOk/ijOiylDjOM4FjB5SXCC
	Ptk2BkqPzgr4A0fDOl65tg==
X-Google-Smtp-Source: AGHT+IHab/pJFDLHSgRpjO/jsusNtG+YEJxnySevhRTAKUsQIO8cSUEbhs65xehv6Dml5rgVDqQG1A==
X-Received: by 2002:a17:903:181:b0:215:a808:61cf with SMTP id d9443c01a7336-21f501569d3mr126552055ad.25.1739100502567;
        Sun, 09 Feb 2025 03:28:22 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687bde1sm59317935ad.195.2025.02.09.03.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:28:22 -0800 (PST)
Message-ID: <67a89156.170a0220.299f78.562f@mx.google.com>
Date: Sun, 09 Feb 2025 03:28:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4240842246492531352=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
In-Reply-To: <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
References: <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4240842246492531352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931989

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      23.88 seconds
CheckAllWarning               PASS      26.68 seconds
CheckSparse                   WARNING   30.05 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      423.29 seconds
TestRunner_l2cap-tester       PASS      20.23 seconds
TestRunner_iso-tester         PASS      27.56 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      119.84 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      9.31 seconds
TestRunner_ioctl-tester       PASS      8.91 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4240842246492531352==--
