Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0E1C84CB
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762103061; cv=none; b=a5w1iD9HJLMJNkzsLndAvqhjxw2nTkovlvF+FKmVZiMiaNzZ5VrCQrEkQwpIgihhBV2Kjaxxxwgyba11kClm4s7aOGGkFGTaGrKvxPnR3j/UPa4BdwU5HxFnZwex/ysa2d30Umr57d6QKLHA44mcot7p7Q2LG7VozQzF7CgrHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762103061; c=relaxed/simple;
	bh=wvRlsBuHx7mRuU/cgRB50BRlsshjySzyZqudZUenMwo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TF1FKXSHqWliy+LWuiob0zZTyfJ6TChBkDFpaaAEVM5FC7JaH4XmcLoCzzyUruO1+7HHenCjUd8/RAQTGt7W0V1R9UfpIepovwl3TJ39T12+iYZuw7Juoe9NS6nHlnpuA/G65I1ysIgqa+UO6FEUKGuB2cHUbLNw1xwpkZhN19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGCfDr4/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGCfDr4/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2956d816c10so9345845ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Nov 2025 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762103059; x=1762707859; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W3SMoJRsvZ50OUnoHZm7u+qOISM2MdZG8WPQpZHL6G0=;
        b=cGCfDr4/3IyXmIApNi5yphTLWa5NECvnjaQffN5KFu9uAbhyjhwokBxXgYz1687iUv
         wcB6IubLFKxDRZNfOQ1gCFbVdIszlVjnPzvvQTGLJrXet9dRWQfKbpR5j5jCs0IbvBv6
         MYr/tkqe97Pc0svHvPdMvhijrDL4Ts+mcImSOEX4yCRDYDUXTmp0yBo9gWbF8S1y1ncV
         OxglGrxy/rVpE7JizmAaWef+qODLMDpBI9s+7xtWkY3DTbIU97FOMy+VlSFUjsR7O6wv
         mie+FT7oUiS0lp6eo0TeEcPW0LmXQDqbPt78cueDNywFulFXuABA68BrMof908qIBeJc
         ALAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762103059; x=1762707859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3SMoJRsvZ50OUnoHZm7u+qOISM2MdZG8WPQpZHL6G0=;
        b=uA1ZPabc/FVAtR8XFe6PLg/mCEtgtx1FZvsBaZVJ4EftFofS6ioDTrrv+i6ucYzBD/
         XMA3kuC4qIeBk2TkXgYbr7RiqBiCRJZ7Rn+SFy13C30AZJO8aS/G9NU+ygUrim4FXB01
         BEbovllKOshE2tsNOK+YJRD92m529yw0gjkxIa7lq3RB55JNLlhcSTs0KzkI4j9/S6Pd
         7TZ6R7x0pGsrroE+h11nyOeFX3ahE6SNBJhhZgNA19ry+QMbr0gyvtlyg+y/Qmt1Hab9
         l5JBlxUik/Lu8fKRdRu9TyIwrnuOzcXEBv8YiPvgxKmZgC01EhCAUUtoTelEfiyz5JN1
         130g==
X-Gm-Message-State: AOJu0Yy0jAeLjFPKr/pVGdLfv+bPnSE2uImWnDXG2bh1PqjuDoCKEJo/
	baRSWM/xwK0FbvXVgJGE6MVidUGUg9yLwviRzOEBYCNX0vTNOg3bfiiYDftofg==
X-Gm-Gg: ASbGnctPGHqR45sAnjgqbZMJXdAxs8xvXCPLGlI2fUnKWUD9TW+mxfdUn9uAODxFEbx
	GRZsBWwco3kkK/tEAZBsQmvQNuJBVG4R8cd12WwtC0E/ZFf8YU3yzP2gw/+jraoQzg6NznuAfa2
	TG/Mmare1a8vaw2R4TloYUeVzQ3xL5LEjncbh4AsGppC6DV+oOyVbTa2tqoCCvwY7T9+eFuP8VE
	8Nq+5GfqvGKqFt/r47Sz0fMt2kppVzTz3VtpHBYAsGZHWuWPkEps7UQ4HeO2s6A1QaNGSal/HaF
	zwfQPECQ58N0IROKNuV+vMlTh1ACZU2bl+PEmE/jhIU1lZuPR6lQ5p3JFdiF9or8vbImgvnFmYN
	7rI8AXFF/mFZkvSEl5AiQC9QYdMy3smpNPRFO0oWyEiB90IFVDT8J9Zd0FTiuUJzcXu/AHzkN1B
	alat/BQ7wL
X-Google-Smtp-Source: AGHT+IGUgnayG0ibPgRsEfLQSHsc16IgQzrMiQTaO6o4I+8sY6AMvqL1aa8S+L59iSsCgjKrW9jbPg==
X-Received: by 2002:a17:903:234f:b0:28e:9a74:7b58 with SMTP id d9443c01a7336-2951a497483mr114519135ad.31.1762103059225;
        Sun, 02 Nov 2025 09:04:19 -0800 (PST)
Received: from [172.17.0.2] ([172.184.173.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295512dedabsm63837655ad.5.2025.11.02.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 09:04:18 -0800 (PST)
Message-ID: <69078f12.170a0220.313d30.11b7@mx.google.com>
Date: Sun, 02 Nov 2025 09:04:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3812005602036163803=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: avoid concurrent deletion of hci_conn
In-Reply-To: <2486739e3daff8e4fbc0e7fc95fb2e86f866cbc2.1762100290.git.pav@iki.fi>
References: <2486739e3daff8e4fbc0e7fc95fb2e86f866cbc2.1762100290.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3812005602036163803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018632

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      28.32 seconds
CheckSparse                   WARNING   32.21 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      511.05 seconds
TestRunner_l2cap-tester       PASS      24.32 seconds
TestRunner_iso-tester         PASS      95.20 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      124.39 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      10.41 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.71 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x97d/0xbe0
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.130 seconds
Mesh - Send cancel - 2                               Timed out    2.672 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3812005602036163803==--
