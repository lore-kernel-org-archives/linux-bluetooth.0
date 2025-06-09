Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405663D544
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749468797; cv=none; b=Cl4bg6FaCWr7ErOUvgXDml+nHEMCI36hwuiZE7W0wWXZy0qhYBY3mSxGsbFDllKbModXP1Yf3rdr09V2P7/kAi1gRBsocO+A3VeiFO/IvPoWbfbpjKrwGq/yu0vgKg2X2jl3jDMSozGt22fnkUTP+C9at4+I5t8S1TQU3Oeuh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749468797; c=relaxed/simple;
	bh=coKdpqDJI6VC6ejw31JwaAtJfxlM6r2+OH1Z/bvHOtc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jiG8cRIX/zuksV+jNzcsiXrM5JzhnMH256KMWxdtAh7vD3/bQL47e5bXpyStV2TRIavDuJ9QDMRK+EQ9Vvb/MVrqREgQ/bd/ALmXgCQ9kcgZmVLF/AEkmcqptnnOK2g0NLpOltxfsIU53hhFGq5eDLd0nsuVSZkL8IQ025tYELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7X6qeVN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7X6qeVN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1fde81de05so2128774a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749468795; x=1750073595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aOy1fKREPXxGTmbkCtninVmAPLPVs7PHsuZ3R0JMScE=;
        b=c7X6qeVNVQFbf2Ea99k1koNgpz7oWAfTRFmPVUOUMNhAj0Nd3NPR7tjm7ZBkCW4M79
         lQfQoeeKtpYsEUMldftMZNFZ7UGxBiIMw5yPNLk2Z9K1QiQXDpZvHsYfeSke9/kMBBpU
         TfmLEz7SXW/M2VHm3GC+PHxWunpc9FXpqBJ0iD+sXm2TfyAiuJYFEL+wIFqH85MIh0FO
         nGnM7VJs4QOwMwRWnabxiM/3BSVvm4HVVQRA8oDe98gPIqXCxz9bFAxA2D5WauD5krpM
         d7cFbRSJsBX05r8/xxoc4iFWaQ9LFRfUOvRabCGYqF+orqyngvycLs3upknnIUzoMdIP
         tKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749468795; x=1750073595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOy1fKREPXxGTmbkCtninVmAPLPVs7PHsuZ3R0JMScE=;
        b=KqG+naua9xQDSzS1fUOkbFH0dleWJ0jKsLzpE4eW7a1ufYLnk1oQI2NQVDpB/7uS8S
         abZ7JPKmyeMPHEwgeNr2wQ1M2mPiQ2Wo849dvkD0QC94Yp1+3Xt8YrvuLpskxmDRPk54
         sQ1TxDx+wx/Wex3GP/QO2j0WtPob2zSd2hcLSS/QIAvbmN6B3bi276kxgtUcpkq6uqRQ
         zEpYWEMAhUgJgUhTr/0dTRhmf3RjnWfW5m61BxJ0zrccAq+2Cu4sZ+7UO/eWn2auWgs2
         WXHCTBZ7NgFykCFG5OAljUGOVqDYc3GSvodYexUSP5mfsWoJBlfAwmzizkKVCSZI1DwV
         MycQ==
X-Gm-Message-State: AOJu0YyU5s8k284wd65hKm9j/PlB9sTlOhpOsNRvgjrVGRAQXOTEqmX/
	+WGr886fOMGn+SmwuSX7Bf1fHbRq4ZQSvbOPj6YGnBXYloDllO7NU4OlEbnuVA==
X-Gm-Gg: ASbGncvVtsFL3ijFZih6UXAyO8o67Faf8b/oeGmtXLbV+iHuonPIXTOz/rUPKTgNK/b
	4zXvgoUuOFqL9PCXW0hp9oWzGQabpQm8F3dSxSZV3iD9dQMd08WuE0ADOEN/ZO2BMAnAeceJYWe
	wUukZVEgLlWM21Hs7vJ3SY5bD52E5rDXMEKLGSaU3RjZ9LOXlTqz95JoNcRV7NMMROI3HkaHSVi
	ZdFkL4SGnJjWyw/wGpu+rQHtuwujBMEjtury1QT0K+/f4wjpcZfyinhJagYbFsIR8JZiGmnX5U8
	iITzLkpuOHjqrBrHaIuRVtmkWuLUnrFkC96zBoYBfSOFCZsFOYgOyK9Hm350WW0xN/4=
X-Google-Smtp-Source: AGHT+IH7ZPLghjatUbWdiR2a3Vz3enkfcn839Wq7UDSykaeaqf1I7B1a8X5WLjHhrURYTpAHQwf3RA==
X-Received: by 2002:a17:90b:388d:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-31347686783mr15871823a91.26.1749468793627;
        Mon, 09 Jun 2025 04:33:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.0.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f32df7sm5475496a91.15.2025.06.09.04.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:33:13 -0700 (PDT)
Message-ID: <6846c679.170a0220.29afe2.2da4@mx.google.com>
Date: Mon, 09 Jun 2025 04:33:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8123917781103968686=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is pulled up by hw
In-Reply-To: <20250609105553.3756688-1-quic_shuaz@quicinc.com>
References: <20250609105553.3756688-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8123917781103968686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969792

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      26.70 seconds
CheckSparse                   PASS      29.79 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      453.00 seconds
TestRunner_l2cap-tester       PASS      25.01 seconds
TestRunner_iso-tester         PASS      41.39 seconds
TestRunner_bnep-tester        PASS      5.76 seconds
TestRunner_mgmt-tester        FAIL      129.01 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      14.54 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        PASS      7.28 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PENDING   0.73 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.220 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.180 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8123917781103968686==--
