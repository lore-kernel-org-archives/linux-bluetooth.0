Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818133F5BC
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789319; cv=none; b=NJmzvKFiLcHCPi9JsGQLNSOyaKO+AV9t9XOxDlVIj/HSKr8bFjsYrR9XYebV41F5NIhEvD2Zji3fYpF2wcx7odRy7wdVZtmXRXkh/vQQwkHqthTGKlk+rHL2Kqvue8NRDIbM35eKUwVr9vjWQxZjbvl/NbNY+KMMS/sLf4EYqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789319; c=relaxed/simple;
	bh=XQ5tp5JEG9jpGSfJOa81RNV3fPoiWm2GccoQcNoDaxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j5iWQLgrSUvWDhuKq9gs22pT5cTya1stMdEKr/dtRBMhqKbF9FPbe9BVjg2laScx4PyypJYBFxh9yWqL8tfCb0ysY38DO+YnWn9LWV6hx1Gw8rJpvyRS+mt91zqUPBcrMPWggUisQzegDnR7gs7t2x20mswmlv7f1cDtQLZyfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGkH/Lo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGkH/Lo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so16482835ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786789318; x=1787394118; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uop5aDYSCsA/7W+sRUSWDQtDQf2i8rJQd2iEthGQjxI=;
        b=PtGkH/LoK76jH2ezgEHR3IFJgNGxa2KgQ8wzmG31FLm6sXhOvSMGkrfgtroYplhO7p
         5r47pMM5FoPLEPAJWFFp9uJf4GcYJzQvOhnuVG1GU8eDFEMy2JtF4RBlmmTiUXuvASk/
         ijh7TqK8N+E14J0dHDKHU5bLY9ff/qNx4FPmx5Pb7Ved947jLVlkCWCUc9qQUKcM8D5l
         3oXcYTvfZMNwqF7vAJgRxrQbe9ZRe2uS+MjNpSNYlbs9H2thgq63ZjKrLWu5QmGSqX3I
         igywhx++VRxfr30uAksouOx9w0epL+RrksYZSmL1qPtUbWEYfjNX1P2i+tDJWpLiG/9z
         9nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786789318; x=1787394118;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uop5aDYSCsA/7W+sRUSWDQtDQf2i8rJQd2iEthGQjxI=;
        b=ZK/bwGaLkZu4Yiaj5fx2bjMhhPwQEyJsooiw5WfmqQ2THvRa5CdgFxgDUZ9QcU2JIG
         JgntH/edcqITiI46jAM2DarLF9wXm9BS+B69u/L53lpxqLx8NVYEKAdP2m8qYrbUIrB4
         WM1uCWTmbNePzDisZspmSx8bneX1xJzAvJ4yINUGeHQpZnOL29Gygq7//VGGCWrLVoDe
         +RZfM19QHU/phs6/E4Yj99aNs33anv3KNTzyhdVsi22/+piifGeaZ+xulnoa0zbRiMdb
         7hvj0lNATRTaE+q9SSam4H4quhd+p6+hxJZ3cI/NgGrF/FlR0hIw1aZtyrFO5+ZHpT+C
         ri1g==
X-Gm-Message-State: AOJu0YyBVq6ptmxv0WfF+NpYOz3LZ1ykkIxaR6HWtyw4NbzQ+ubj733k
	YCdRNXL6piB6rxuIRlDRGNPaw77J7R7jNfWnuRcaLQQ012JKgg4AO+raa7qDwiLL
X-Gm-Gg: AR+sD12KzhCtyFQR6T+ANN46ohZGLhUhOP4bq4I6fI0lk/wpMK1W5LaUsCmsroYh6kL
	BL5S82Tesp2UrZREGRtZljp0K9cr1FkWQw602IU1LQtABy9qeb4Ha73++t6bUnFdohF4mEGCcPi
	tHQPhL5MI2wSbL/w5CNmakZb6DhRCej3t0ijmjpOezVKum85wkq3sciMvYHBJH6Cmtc6stYKzyi
	q8RjYaKf5PgtgaZeu72YYeUUEv49ns9f75VWS271sDa+ZFa4mwOswK2ZLhiiU7o2k0JS20gB60f
	cfzRcIyrh90y96xMSsSpefG6AauRWhbXdmtl6yyAMl1ZiJm37w4EWAVfxnuDbXpab5AQVDKqCUP
	qMYn3faRIE4P++8lKEQwtJJkf+8lfSMB+k2OcnWTa+LNzbcbbbOox3rNvyjdhAOgFwHRe5itaZz
	aYWhjCxpoHLghDwnaynIrtxiltTDY7bLY1m4BNX1hrP1Pcspv5hj2sRJySQbjVhhpdwv4=
X-Received: by 2002:a17:90b:2810:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-3933b8f4527mr13404636a91.15.1786789317758;
        Sat, 15 Aug 2026 03:21:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.188.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea9722fbsm5773750a91.3.2026.08.15.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 03:21:56 -0700 (PDT)
Message-ID: <6a803dc4.2bb73dab.24690d.a6d6@mx.google.com>
Date: Sat, 15 Aug 2026 03:21:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4366805670788591797=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrewbille@gmail.com
Subject: RE: [v3] Bluetooth: btusb: treat 0bda:0002 rev 7558 as a generic HCI device
In-Reply-To: <20260815095127.29624-1-andrewbille@gmail.com>
References: <20260815095127.29624-1-andrewbille@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4366805670788591797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146453

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      28.30 seconds
BuildKernel32                 PASS      26.17 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.94 seconds
IncrementalBuild              PASS      25.78 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/588

---
Regards,
Linux Bluetooth


--===============4366805670788591797==--
