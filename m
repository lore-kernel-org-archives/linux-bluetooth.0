Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DE283FD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230192; cv=none; b=EnZkLZGrG1JC8H12N0YN5Q2pNY80J7S7eXnF+nw4rEteFys5Ar17ExnrKisE9Gke+j0qbVR1auOFL3XvY9sZlyZ3LGgpwSh3Z+Lh/okXJopuVtrzkZN2wV1PNh35Khw7q2rAH6UgzIBnLaPiQmmREy63L1Lv98NebTS28vrZJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230192; c=relaxed/simple;
	bh=ZMfgx1nvgZSWusMhbKE/RQmhukxucxbfxHZdVLijTNM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bbWE0bm+5dpXtuoYIf/Xi8EdlNKsHYl5DKuUtnlPZFKpaeCdBDQgjvHi+EMMg+Rem2XDaQj0zLotaTYf0I7ZQtEFQYxaDQcPmfH9weoWBcnHNnW+KOiZ/d129n8i23rpaJtjScuChc3ciW1ndx9GbGnZvnWwJymzJns58RnejTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcmCq567; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcmCq567"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31c4a546cc2so956573a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752230190; x=1752834990; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fXOFsqP/RX3mQT5NuyRGm7Zb+6IVX19OrPHNIJglwpY=;
        b=DcmCq567vrvWHIsQFnScqqTHMEy8WNsMocRIgyyMIONOt4qzEfWlnZNjAhk8N58dkK
         5TOqOvhTnHCRyaTiPuyBXH0JuV7fHkDAQpDza3QmBe15blTNRHjSxtVrPJv3Llu3smna
         RGGMwoRtircTVDonjLCOOzivZmoaKbqBZZ0VBETsdzXARpK2eyB6z1ehBORPWC/ACkgi
         5P3XPPLNnLAmKidUc0MdBNc5vmsBQwunXYEc6RUxTx4Ae0NjKQLOiQp9/ElxkKzlkbA7
         sQ7+j2U08zKizQ71h5DFyFMBIt90Ft+n+By8p2SKiW9bR0i9ovTJ1FKYthEOmBxkL4pL
         pitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230190; x=1752834990;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXOFsqP/RX3mQT5NuyRGm7Zb+6IVX19OrPHNIJglwpY=;
        b=NiJiJ504GyBdaZ9cm2SbE4+ETjHQrKmOqeNvvy09byNWNOrODhKPvQooJGzjlOCsmd
         fWPgqAufe61q/+47CUujVvxYn/y1Rgob3xGTiuPziNeTwX7ZjJQcn64Ai/Ths3d3GQdi
         UoDarN6M5wQtOVT0LxI15awl7Rue7XW88Ewp/BvUJotH50i1ogZytdm5koVl0PfE56pj
         LZhawtalTobSk3KxESe9FJTmWpHQxpsY1ZMLxDD5XOJKgqWVSpPCXVreLogaiipQURMg
         NvN3U5h6A/9W1sI+nINGcEpPiNSKGtyeXureig3yhbPuYqBtvRt7X++iMCwcSk5g5tzK
         VMpA==
X-Gm-Message-State: AOJu0YxGu9jqxAeCsBYlpWp6wu+DbFXsMwHJJKu1zCyIut0MGE7H7rhM
	sKAMpayTNWLXvNREYBlsaBZjfnb14AnCNY+yyACrBu/GM+l2OMA9LNss2jZLaA==
X-Gm-Gg: ASbGncvxixZk57OW6NZc3LSTGcSCHleXLP9SmqyvEnPDUgiH3w59uwi3diZP8nKPXJT
	Mxwt75T2Rujfco7JRvdMMqRWT6tBZDebnbSe7G4Tz04nWRKR9dZ8jzbWzxOjwHviOcfkrPWx9Gt
	SrgfH9Cf4gHJDVVk+Zixg0Hg9woYz0ICNau2yFUl6W5sTgemwBDdm3CKD/jRP0Osuz8L8Kb3wXk
	47esBGd73OVztJRletWCYcax3QTzd5q5NCPIIfEQPkacnMKuft0QkdsLmRFzx4MdJlPyEVONyXg
	hUt544czHJmY8Rh6uDyGqASMSGZ9Hr4S2Uv7q4yslCBqHZL+2guOnHMSQCqgOwgke30+snqy7O4
	C0rNPljMwehI7iQY5AJ8yVK8EDeuKXQ==
X-Google-Smtp-Source: AGHT+IGoakX8l37QXMZpcmvnKfrt95yqMLH6S1w6wHKpppin1p+4/7Bz2UcnS1YCz6MQi7039zSMIQ==
X-Received: by 2002:a17:90b:2287:b0:31a:9004:8d36 with SMTP id 98e67ed59e1d1-31c4f512a2emr2183384a91.20.1752230190026;
        Fri, 11 Jul 2025 03:36:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.101.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220ed0f9sm8435768a91.0.2025.07.11.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:36:29 -0700 (PDT)
Message-ID: <6870e92d.170a0220.20a151.b845@mx.google.com>
Date: Fri, 11 Jul 2025 03:36:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2670883883483344547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Define a macro for Intel Reset vendor command
In-Reply-To: <20250711100725.956159-1-kiran.k@intel.com>
References: <20250711100725.956159-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2670883883483344547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981453

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.12 seconds
CheckAllWarning               PASS      26.94 seconds
CheckSparse                   PASS      29.95 seconds
BuildKernel32                 PASS      24.25 seconds
TestRunnerSetup               PASS      470.33 seconds
TestRunner_l2cap-tester       PASS      25.32 seconds
TestRunner_iso-tester         PASS      35.94 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      130.21 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      16.71 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.64 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.225 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.201 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.156 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2670883883483344547==--
