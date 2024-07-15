Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043213A89C
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025711; cv=none; b=FahR0+FcM5lRdQ+n1g/fyo5IIo4tR/vbT19n0KpIx/osRfykZb//duEAMTjK1Ux/KOhoimnG/iSdCgXjmV/nn1qB1ISCE98cLFQvIso8GDqztxjVx5QH8qtogjza3hPHrIJmPAN49rTnn5ELIofOpvbuV7CstJZhcON4ZKymHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025711; c=relaxed/simple;
	bh=OwhwmFf89GDN/EZV1KUSZ1jJ3Y57krOqcA3TYazxeU8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GFgOgkLdxYk62ePaNm4+HWYdQcGqQ0VyIuA2399jTZKq6fJWX8b5x8Dq7mrrbV8u+9X2S3VrHPNtOv1dIotGd8/mmp+J/j+8dVbeF6NkL5b9iy5QxSxqgvLmGnfS9prXhGkp8M02sboH/QS7xNIdqbINcXULMbNJMFBKcvTEs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loDOSLb+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loDOSLb+"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-376012bcc33so16150175ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jul 2024 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721025708; x=1721630508; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qn+DpH6PIokESu5fw/Jqhp/KabFL34u8+XqYVWJ2Ms=;
        b=loDOSLb+OLkXzheD0p/dAZRXimWb4+pJ5+sITnrYn1tbVoto13qeNrdFwc2rLoVpqO
         Pr//+XpBZXXE9fxiZdrajL/GSElwRnbkNHynPUxlUiJOHlMLvC8ap/pnWZ107lFkALGc
         bFWBmYPK0iOsM7dt3slrM2kg/ulSDsgJPCG4EdHiJco7Eanb32ohAZvIO38+m/WjlZbN
         f+k/wDYeGNg4eAGo/UlOHlJDPYptemPAYj+tHl9Ahsgrm1wfuzg7Cw4KTQ0u0h43xE/s
         AJGOzpXCN5CIDNnELxILLq0D8gddGxcvA1YBzyS0kRmSOJjSYVDAhpHN5NaFGLLN5BD5
         4HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721025708; x=1721630508;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Qn+DpH6PIokESu5fw/Jqhp/KabFL34u8+XqYVWJ2Ms=;
        b=JNIqw/P7C1YYNYftBfhjWllWU8CmhwOOxPoCSmf7BddbW6otxhYmPjBVGDdKC8SXZE
         m+VFMNTjtL2E8ajlu+ZpMZYDC0bb5LwSGnUrlmad1WW4TaNfmiPJoDCCcBcaBtpDyPCJ
         NBOe/MbgxpZxVFUQZCaf7fttkXspEI3upZwKnJFGDTQBECrBuJs9kA2bfEHFeD9RLOF5
         xGKFurG6v/XqdgolKvsOZRBYqYuDw8tnqOAQr1Pxq/kbPwgoMQ8wdav5huAIRXgqY65Z
         TpCB/UZayZxGKrX5Jtn6yIoZ/dsNYJh7YhtfamWIx9CF7KmQvB2t8NhzSr6ButQzqbGk
         j4rQ==
X-Gm-Message-State: AOJu0YzeZeKSjST2WiKJXhwafC102QVoRfKXSc3pTQHjbJkBzS+XGlnV
	H/9SBfVG/skJYGaUxeLVMyfVDLX/0275NguNNLezncNmq0guacRE4vSmwA==
X-Google-Smtp-Source: AGHT+IEzXejd6rdlbUfmmTrO8uoDqRW9KKg3rUgkPJP/nygoRNsWT0VGWxBEuRCAEqpUcMBut2CqYQ==
X-Received: by 2002:a05:6e02:2148:b0:383:5520:cc48 with SMTP id e9e14a558f8ab-38a5435e086mr248399925ab.0.1721025708531;
        Sun, 14 Jul 2024 23:41:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.122.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c974sm3698970b3a.10.2024.07.14.23.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 23:41:48 -0700 (PDT)
Message-ID: <6694c4ac.050a0220.44c44.7b4d@mx.google.com>
Date: Sun, 14 Jul 2024 23:41:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7807351094204341112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [1/2] Bluetooth: btusb: Add new VID/PID 0489/e139 for MT7925
In-Reply-To: <20240715061508.14077-1-jiande.lu@mediatek.com>
References: <20240715061508.14077-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7807351094204341112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871219

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      29.84 seconds
CheckAllWarning               PASS      32.57 seconds
CheckSparse                   PASS      37.95 seconds
CheckSmatch                   PASS      102.83 seconds
BuildKernel32                 PASS      28.95 seconds
TestRunnerSetup               PASS      529.14 seconds
TestRunner_l2cap-tester       PASS      22.11 seconds
TestRunner_iso-tester         PASS      39.36 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      115.79 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      17.05 seconds
TestRunner_ioctl-tester       PASS      8.06 seconds
TestRunner_mesh-tester        FAIL      8.15 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.25 seconds
IncrementalBuild              PASS      33.10 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.102 seconds


---
Regards,
Linux Bluetooth


--===============7807351094204341112==--
