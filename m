Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF829B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807724; cv=none; b=OYitSsBdtEIuP7RaDuwdJgv+NFTDQ1jogSaQ/P38B8eJwvqz2FnzI6/YSv/2pjg3yBlZvybAV9Q+1w10S+Efhz+mCSDcKOOd4hAu1aKT+COVB5NC17AcNcjVBBsRe7hmTFtFqaTgHNu8yh7O68hYVmiLTtzwQ2WRAA+UOy/8TRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807724; c=relaxed/simple;
	bh=kbryyKCe8OfgRevg424U1T6wATkcMmX9VfpiovegRqg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hYWgxfzWH8tAi7qb40HJnGlm/vvFmzvr/dGXMptV9Bb5XK0jOOd+nZTwBJ3NWooQ3fOEvMy1gtXGsVhmOXQQL+fZGG2gaKCdp/dWUjMGpOuhC6kxGCjIkUi8mbvEO6x9EiHdf4vM67zsPNGIW8Nr9ba/rIUNOump3JeN9okTnYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRUl6GWY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRUl6GWY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso5782019a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744807721; x=1745412521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T23krcG3ul0+vaPMLHFyAQLzyrXAmMmds8IQufo7fvw=;
        b=nRUl6GWYZS4jTU6cd7AFuFJftlSdr7+JrpvVKCfRhQ1Sksq/Zj13asdC8/5fPnUZWe
         OBmX+7sr95aHVNdHUv1IiTzYXd9Vapq7fXzEQGTOBNMSPR2bPsVTN3M8FU0i3c4klCYl
         vcFq3u5YOIeTgFOnGPFS5V3Q1K2tvKaju9E83IItR3z8i+sEMg8ppRxyI8MIiXstAlvv
         oAfnYJ37/m2Ha1QDYgtJ3ZU9zOvVD26gf6idU055z18HRhvofMIlc9JyEL3SvAjCE5Vw
         VnXVlXQUUpGwWopD8lyDCQPJj0lEAVu6HqaoD27/DUa2lyvpRw1Md7hVnGQqf7aa+xI6
         a4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744807721; x=1745412521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T23krcG3ul0+vaPMLHFyAQLzyrXAmMmds8IQufo7fvw=;
        b=sNxMb2JVALYvLubeJjtX2qEtGL2WHdk2oVorN7r7i6JFNL5zSPe5JVPq6LeL32OC1c
         +7VWn3d7/K1tm9DRlosze8mvtjWft1q6dk2YvJKftquPSmq9EkUuXdtJTQRkAi6ue7Tr
         J34uyyBlYvQStoEvezSueSHzoMBmlKWL5E4nv+2QtOgz1/86/KsubrYUdAnOHS/LWfOf
         bugUII5jgdltIf1F1HoPW/ccanAKdSiYTtDvCwePD+7PsKaayGy/5nrAR+w0x1vz2eUx
         iHtHUDMwBkxnm8ET3JsRzcnSWukGhDxt6Rnhlk/Rm3QU11DPss7G6d9EHsPl0NucYjOv
         wR1w==
X-Gm-Message-State: AOJu0YxfWm7B4VXcirqAf6eRpA8oyiXDfuvW9THMVfgbxIxwk9GWxMVW
	Cl2oXXJZ3rHKuM+Dg9oXcfAUBufmU1TxREGzzzAgsuM8SxCiUtkYfl2Lbg==
X-Gm-Gg: ASbGncscKlhwYfqKpuU7bMy9jcSEXKxATbQizpZQx81YjPWPnjbC5Az8NMlzSVv1sE3
	bQ3LDmu6qcWkJSxCw0FR8ewkcik+eRG8XNj10Q3rupbW8egdlaRhUtZD6HCyuPV1Xwg41FCpJab
	e9Hd1DwHyQq2WvyE6SaAtN8VhgkQboWqvcXH/Pkd30uXAwDp6/MKhqsx4GYN6NtVfqtsGstRuKw
	KsMQiUthHpgfqV0R37O3BVMjOoSTY53cK9y7m4EPwmdy6o1lXzxGG8zobC0u0F+/tR1riSKDzan
	DaIjp6MJo6XDfeZg/VYCMOePgEJQQHF+240tGSQB7QcdoDqi
X-Google-Smtp-Source: AGHT+IHQVYpsg/hH4DXntx7WKCCOkHC40aEcVRXuvBbL629vRhzrmFAPxe13upNhNWOe1Howxb+9YA==
X-Received: by 2002:a17:90b:2e10:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-30864026c3dmr2997303a91.18.1744807721561;
        Wed, 16 Apr 2025 05:48:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d606esm1462685a91.6.2025.04.16.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:48:41 -0700 (PDT)
Message-ID: <67ffa729.170a0220.be0b3.5d77@mx.google.com>
Date: Wed, 16 Apr 2025 05:48:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0177767371982540813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: l2cap: Fix double free of 'skb'
In-Reply-To: <20250416122351.213894-1-frederic.danis@collabora.com>
References: <20250416122351.213894-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0177767371982540813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953999

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      31.05 seconds
CheckSparse                   PASS      29.79 seconds
BuildKernel32                 PASS      23.80 seconds
TestRunnerSetup               PASS      459.58 seconds
TestRunner_l2cap-tester       PASS      20.95 seconds
TestRunner_iso-tester         PASS      28.46 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      120.31 seconds
TestRunner_rfcomm-tester      PASS      19.23 seconds
TestRunner_sco-tester         PASS      33.25 seconds
TestRunner_ioctl-tester       PASS      9.35 seconds
TestRunner_mesh-tester        PASS      35.06 seconds
TestRunner_smp-tester         PASS      12.09 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.155 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0177767371982540813==--
