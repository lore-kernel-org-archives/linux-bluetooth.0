Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792631CD17
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Feb 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156685; cv=none; b=hQrVHGoIDnL/yfDEH+feTKUiq5ditsMF/zFSB1E8aFHNlA/vRCUQ5CTDWOjSB0e9pDXT2C8TzVJEb1dFEELL6uG7ikvSX+2v6PmzT2ijecJci8lRHcyeOARPDInDrBVbpd5WLd0wkvk3Cb2TxeUXoc/XYa7rPf17yderd2IRe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156685; c=relaxed/simple;
	bh=DdmYevumfHG/toZMgGTCNZaD4YdplFcJXKpI3z6mUB8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AotXndNJcxHLnDZH4G2osHFemY8Z5W40zktLiXp8V/bpm+zbK74HMuUDpIpnRhvzej5j9EmkQj0ORxczxAnmY/ER4u3IyIGa7TwPXXFtpBQvFJul9i6MYybXPPcJeIXo1snXtkr2U1M5SzC1a5jfpdJsTReZR14bZrWhcDTQwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoGhRBsi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoGhRBsi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-429de32dad9so16408561cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708156682; x=1708761482; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SHIN0qNaFYB0hEIyMrK0fNTf2i5E0YMhliiENsYpNo=;
        b=MoGhRBsi5ju8CJGnS3U6rq5zRGbzNVv4I0z6e9LMkZSyu8H/vceO2pHvWQ4i/dFHsY
         nNaNZbtWMFU6Y+95aNYXCLNJ0bSO88MKovFHNsAPXBpm9Peb0NS3EZlYzdcBoDgV6Up7
         p4H+3wmbxQPyz+MUXD3kffucqX+IDG6gP483eSwHYwarPaeLbjUJZwQpT2tr/VuOI8eV
         pX7OjH6IQc3xziDULgAQTPsvoI5eRHLOV5G9wsIsZe3bTMEF3Uh/f7k7DJJa+4rl/P+r
         IZA0/P9g8W/K+LL1rOhn3ef8+zATeS+M045pdQuxLUQFz8rJE48AEyjDjNVvVXUlK2Ir
         V2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708156682; x=1708761482;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SHIN0qNaFYB0hEIyMrK0fNTf2i5E0YMhliiENsYpNo=;
        b=rRj/IC45Ih1ONSFMok6RbA1SzJ/HoQaqgKiRGrbA9PTblfUjKZv3/fMunNsHNsbmuf
         wxYsj2KlSLYwaKsDf4sJ4xfW4lrAWeJ2pqgF7aXPDdIJEhbbYgl1NwN6zYt7+mm8d6iM
         1Fiub7d7hPAvKMFhxbOkGTBO4K1gdMOVIE6PeSxUbYXBrTyclejG3fJLVVlT80r0cScm
         mN0DRrsFdkik2poG28J8eewjt4fvgxoPPYNeDY3Uq9C6Au08XLvxLNvtWbuwFNvdbmGb
         u/oreY/uIQCSUF5spT7qb2Chj/NpVf/GPa2a0t3zkGH89iND7eBrStqtHwO3PpPUlmo+
         67Pg==
X-Gm-Message-State: AOJu0YzpBEuc0mSagL17EGhV9VtzTNZ98fIqSDyRcyuCVGAdX8No0uhX
	zFZG/nUDwiuq6RNlTx6W9wa6IPpNffEPj4kTEFhXEQ3v2rHoikuWbJm5EsSZ
X-Google-Smtp-Source: AGHT+IF4tc7zDDhFbciLIPeldaMGCuN0blOOn2Bpv6mSYH3rsWOqmkkcAnPDM1C0iytAue8haa7D2A==
X-Received: by 2002:a05:622a:1442:b0:42d:ddc7:d9e6 with SMTP id v2-20020a05622a144200b0042dddc7d9e6mr5160329qtx.0.1708156682240;
        Fri, 16 Feb 2024 23:58:02 -0800 (PST)
Received: from [172.17.0.2] ([40.76.238.214])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a22ce00b0078734f18e3esm646287qki.80.2024.02.16.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 23:58:02 -0800 (PST)
Message-ID: <65d0670a.050a0220.5e1a7.3fb1@mx.google.com>
Date: Fri, 16 Feb 2024 23:58:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8948379648434155752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: [1/2] Bluetooth: btbcm: Use strreplace()
In-Reply-To: <79b9c9d9f86b4c573f0d3f2dac0a6fc9e6024058.1708154999.git.christophe.jaillet@wanadoo.fr>
References: <79b9c9d9f86b4c573f0d3f2dac0a6fc9e6024058.1708154999.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8948379648434155752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827028

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      28.01 seconds
CheckAllWarning               PASS      30.39 seconds
CheckSparse                   PASS      36.25 seconds
CheckSmatch                   PASS      98.35 seconds
BuildKernel32                 PASS      26.96 seconds
TestRunnerSetup               PASS      496.21 seconds
TestRunner_l2cap-tester       PASS      18.13 seconds
TestRunner_iso-tester         PASS      29.16 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      161.51 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      30.73 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 5, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.113 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.111 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.143 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.151 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.343 seconds


---
Regards,
Linux Bluetooth


--===============8948379648434155752==--
