Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FB2F3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006541; cv=none; b=ZqFzyAEnLCB5eMqck1BMRohzQT9w9HA5Orc3OMWJ2hzZeo7PTFqSRb/mdViaquWhjkQN1cXzaDtSk2I2BLBddpQdKfE1Wwm+STeMakI3DtvYLxPxplXJ5zFBRxOnFmxPCr3/bfdo6EzNLGLxSF+UO4dUOYaEN7bgHO//v3b8Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006541; c=relaxed/simple;
	bh=N2FwxIb7MO7daxPIpY0kVH78C/iaNj9aZhnrJFCGq9U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F8s61vrwor0tCKGdpK5YEzX36dogJgcVSvilEJIA5/YN743GyYJGkQqfcmupaIbydjazZ/B/pv96L05PuRG5nis75/m4sCygMSBeQAyJaGdjEJbZSSEGW8EsVo+4QqHSLdef4heqq35HyQliOuOyeB1kNMEFZCHR30ok8xmZhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4nUbybN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4nUbybN"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0ad74483fso17579336d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751006539; x=1751611339; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X33QDPpK+gqC08aJgsP8RdoXMW35qlQM1PJEoy01aHI=;
        b=l4nUbybNzD4DhuLDrMxxSzXSWZcrfqMQDEQQEj9fR8ooQ6m8Ektb1eXMRc+HGSOXLp
         yzu0SUKrCSYo/qvor9TQ5vUaqBOR/PdZ2AT30w/xZlog3bPGTaTepZbOUyTcMkvhtXBn
         ESVkiLGaI9BvhPMl0FNtGLPhLNFJSENvhFxhmFzuZV+SfPrPU9FWpBAgWtDZluA6sep/
         MljVYZ9r06LBJIGaznD6ei/avNWv7UyYbeJFHUjDrg1PpD0c6dzEwY6n5REZgRh0RVzA
         V1FUe5cEqz/7Uc/SaTusOfWyQOSdXLl4IkkpnjHO2R7kk/xF55o+o6h3sEASZKIlHa2L
         VF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751006539; x=1751611339;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X33QDPpK+gqC08aJgsP8RdoXMW35qlQM1PJEoy01aHI=;
        b=UZ6RBLMnDcwSfPzqN8KgvHKbx9SNP9ZDyiMMfj5QMPUAljin2Kk9hqNeEsmVrv2xCF
         ef2NcchtTXTsm1mhqjKVVi02GeFSmuB7lN8ZQDPqqHyt7tCAFsQALro2JFzTPgK3K8B0
         0U0GpZo373Sgc2w2THScpPW6TyDbZ1/TJIgn0pJddSd5tYDixIZ3W/8DF2CoHtNgGOoA
         kPdcuZJg3WMzr1aa7fnHJz/KBUc6h4o2+47yUHuMgAaBC2h6CQyMVuQxcAtFrdtf8acz
         QLNoBBuInhtjgSmyNkNnvF7upOu58vGQQ/4bGq2B/Gr4TcQDCwMdvz0fTA1bCmM/O6hq
         xvpg==
X-Gm-Message-State: AOJu0YwesLZRaNQ5JsV3kqg+2z1orl1teR8URK2As5CjNLklEuqvBMDr
	btN4bpKxsoQGfCuTmBMDDsIrOZft//ql/xNc+WBb8Ipvw0mfwkTkEBksux5QQw==
X-Gm-Gg: ASbGncv1DoZ084PH2VaF660lnzHpVV7bpXSNoiNCFn7LGR5u8g7o/WsyYP3CYv9CmTD
	7I1aWtPtcI3x5amgYteAoGMa9WDCfVjZMpckxKf8jhnQAsGnRvwYF0pGnW7rau/dYWl69dNJkYk
	5EOxisgaBSSK2Y/KLTyXHO2OQ0kLeikad4yvVj0/XbE8iIOmIRUZgi53nXu/U9n7HIZmoYiuJAF
	p2F65qTs/gcdqmdO7rFCmq4nliiKUB3DZzjMJY87ygmHI70iJjYbPz/TvWH3Z8mK8iGyS2So9kM
	dsBWTwQp3kJchD70JZKDfxnSO+pPbb3nXsEeSjuk6FQHDT5sXp/JjNNQBfK1EUq8Nw==
X-Google-Smtp-Source: AGHT+IGQp8r6X0RwA8/utUfnPN369VYJHqOBnRllTaH7+6Z1nwsC1hsd/wxNeP309V3HwOu1Ik84xg==
X-Received: by 2002:a05:6214:2e86:b0:700:bad0:1c48 with SMTP id 6a1803df08f44-700bad02330mr16616946d6.20.1751006538778;
        Thu, 26 Jun 2025 23:42:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.193.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e34a8sm15744056d6.63.2025.06.26.23.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 23:42:18 -0700 (PDT)
Message-ID: <685e3d4a.050a0220.267deb.50b8@mx.google.com>
Date: Thu, 26 Jun 2025 23:42:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8151388373879906143=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: Bluetooth: mediatek: add gpio pin to reset bt
In-Reply-To: <20250627055924.7716-2-ot_zhangchao.zhang@mediatek.com>
References: <20250627055924.7716-2-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8151388373879906143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976464

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      472.21 seconds
TestRunner_l2cap-tester       PASS      25.23 seconds
TestRunner_iso-tester         PASS      39.91 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      135.17 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.215 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.050 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8151388373879906143==--
