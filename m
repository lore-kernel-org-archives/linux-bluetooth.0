Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0F25605
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQF5Muzs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso49809945ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705083423; x=1705688223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UfiZdMMWbuEhj088kwO/xRszWcEIeM7xPC5SAXJv4xo=;
        b=kQF5Muzs9TvAiIks8rJKan9HlBx1NCdA6pOZ0ILiBBmfdShpiqh8dCLzP0ebk6HAvR
         nNxuT0zTh2VyVWhPIHHXq+fAjHcKLO2M5kDYrveFvXrQy429iXQUMHVwgJ7LwrV6iijo
         BEE5kCZYLJ/ijIwATip5+GZajONJduj3gnkBIIe06819TBtMfp6W9TDdxWVP+cw0roEu
         g75kEIWwqBMGfefPEnbwXyfSkI+JWnYSM201dUwxPb8Bvha5uI04G6Kg6KPaTEHey2m/
         XQUcECVoQJocg1oEPw9aPSW23WOnf7Swv1Z9RYVbW/R2Lr6zVEYc6aALtXqHmeCd/Lgx
         A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083423; x=1705688223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfiZdMMWbuEhj088kwO/xRszWcEIeM7xPC5SAXJv4xo=;
        b=H507Hij5PgJUhaIBmhVGLFKWYGMXLJLJiTq0ND3gzy4IU5ffnNLHwTbKI4DDtaFNTZ
         bHbtLTVH6e8tjwPTNDn8yNBkrhVGRPar8Cg3K1ygzVuBpdChFeBAcOX6BF3V64E95Zo2
         6pZ/Qv+u4ZboUwUZG+93XJ+qc3g3V550Df3di3AKYfAukor0x4B/Lda6xrxz2vNwmP3E
         smlYTQUcrSx5HwVOLJgXPlFfA3s/saoLF7ShhMWgc4QNRxFXPezbRnoljc2QBz8xVITK
         E5rXomlS4ijDRYFWulAXEeRvm+0fwSwUXT7EVXZVFGEt5J+7MIbMH1+uSSImwMxBefLZ
         KQqg==
X-Gm-Message-State: AOJu0YwdhFhHavC2yh5uvcvPM+Vo+LXums6U4wFFU/1P16keWQZzQxUp
	hcd3T/S4UIBIkG+jJGDLs1ZNfRKmoaA=
X-Google-Smtp-Source: AGHT+IEPsbXOBrWQAXVRc94rrvv5gUMgFip5WEFd+fPnYmnkvtVpdPcB4SdPF3XR5A9AtikBrORX2A==
X-Received: by 2002:a17:90a:7108:b0:28d:9e9a:67ab with SMTP id h8-20020a17090a710800b0028d9e9a67abmr4109634pjk.27.1705083423110;
        Fri, 12 Jan 2024 10:17:03 -0800 (PST)
Received: from [172.17.0.2] ([20.171.70.178])
        by smtp.gmail.com with ESMTPSA id pt1-20020a17090b3d0100b0028e120603b9sm1574732pjb.15.2024.01.12.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:17:02 -0800 (PST)
Message-ID: <65a1821e.170a0220.67c21.4b08@mx.google.com>
Date: Fri, 12 Jan 2024 10:17:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4839548195309258000=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add code to support dynamically generated BASE
In-Reply-To: <20240112165601.134073-2-silviu.barbulescu@nxp.com>
References: <20240112165601.134073-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4839548195309258000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816562

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       FAIL      0.75 seconds
BuildEll                      PASS      23.78 seconds
BluezMake                     PASS      699.11 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      162.41 seconds
CheckValgrind                 PASS      224.21 seconds
CheckSmatch                   PASS      324.51 seconds
bluezmakeextell               PASS      105.88 seconds
IncrementalBuild              PASS      1312.26 seconds
ScanBuild                     PASS      957.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] shared/bap: Fix dereference of null pointer

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "src/shared/bap.c	bt_bap_stream_new"


---
Regards,
Linux Bluetooth


--===============4839548195309258000==--
