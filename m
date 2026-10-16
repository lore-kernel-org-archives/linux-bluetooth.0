Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63F4B99A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177136; cv=none; b=uRaBLvmNUTX9LBhOIZD83DQr6t3avM7FqNual3R9n1Hu9AAFZxAV6Q13zrqyL/H/t3Mx1o/cXkIwvr08mebKOHN3Vb+VbB/AVJiLKdTFwjrqgGt1AURQhMLBTbnGWhE6XpxxWiYNi2ri+SaTj8nzKD+2UYcbW41WIJh7MxJe7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177136; c=relaxed/simple;
	bh=v11AN0IbtEU4dZKVz/TDFe/CtQxfJkQQ7IuUoGdzeTQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ccuBbzhEdHdOtm4Er8AOSOFBLpk0Pjben/Pc4xqMPn5rLDy/0VGsVrBDGykfSODN3cv7+3IbZkm4p2SAE5qtdIBI1aECTnCrXq42/D2g28DFA4Vpjcxa/U6xm+ejY8ZrXlftLU+4PRuJuLh374Y5x3swZgE4pjrY8CfiKwqVnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkChrZDX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkChrZDX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so231705a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177132; x=1792781932; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FM8jX16SjXzs+/Eko4547pEhEQ2dBYNru7EkFSKJ6V8=;
        b=VkChrZDXd7UDqE8rlK//F+Ra17hqtn3Xi5wdKVFdIvyEu1FoqiG45b+tjg83rXuyEs
         uyGMv38MROBFxH4FvWl61+PhI98aCiL/qD5nPk3CkNj7/qhEb72s5Q1xfoFLVSQDOOpB
         lmBhXNKUrQiocS25BsCSbH6lSZ0LQXjA45yxrJenY0lF5KKB/GNSHCaolfaz3V4GfZCS
         qozcLuVI4C91GwKPy5KbZ6Il7x6LoRxfVQqVfzFlZA0sN7yzqw+xckUYCBIITtZnKNTt
         KitvUNr6vBnlUDChoSWk1mkt2wO2tPQbis6uQfqV8GiAeOY+RjGsbpBCiBS28nD46UP5
         SY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177132; x=1792781932;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FM8jX16SjXzs+/Eko4547pEhEQ2dBYNru7EkFSKJ6V8=;
        b=ZdacyQyzRtUxkNMGei/usmlDz8WDyreuZOPtS5jXZUBMOWWzVz0LyjKHC7eKBd+k/n
         p//NuVbKl7BISdcVHQTQM6sQDr7h/8hl++aqxiTQH5n74UTDfZazentnJa+aCAp7UQjp
         +EVKGHrOi3j3WPMi3CHe9wf1SzbQj/3VTxOftGD6rIwy8CImaJVB6h3Vw7U+NfXzg+OI
         X718aVQVo5aOtj7HCKry3I/6GgRax0xCVtx+MhV1MCIZmHO2kAA8dF9hTe1dPEO3Xghd
         AyEJi47anKKP6hW80lQv+weH7r4XJ+fJzcDy8IPD2yswx7jA6/iPm9xxLjuUJPn7q5zi
         mCyQ==
X-Gm-Message-State: AFq9FYJmduNsVWIj4PkbOVhGEw5Kq/b2r1kt7E6T0bAWme2lSc3GYs2+
	x0arcuLUkCHPwgN9hVXPW36yCaD4NoSc7iq+/sZgaedvyZ6J1PREVjk7AwKqWA==
X-Gm-Gg: AYBFou34tyLGMGEMy2ZNkcV1PZWK0BEX2APpSB+OoJ0tVqcMOkGybwE1mEzmVaz280d
	Wuqa0zdF6FxcPWs6/Iux6knMiI4Pf3iRrLvhgYLeYBofHJeOBmGo6FrPcj5rMN4jexoGFMmxa/3
	MKsrAwYhPO5RLdBnLGsiOdWAz/A044/a9cxBXwVoscwa8A0BfHz9axUoRgI9Ea2JFg2qeisQ7kP
	q1vnTrRDI9SLAs0eUSMWGHXb2J49njKqmAtUkR3RiHrm4dfHlhbvt2YToStvpaW4HfGgyvMQqPi
	BAZPgBGHMUlxNOFltf2iWKG+7+nVmk0JhU3PEfavQb1tNt/cc6kkevxI8lNoBt3LjVvjbOo5R58
	RcA1qOV4D+rBwWfM67SBKSLDwgVpCucFC9XppCQRDt+vF+WibK8J9G5y0CJozffTZhSKgXFITLe
	ZgSrQs3ANmETogMJyZ7Ic6ftiORY/PMni4yCHpX7bo1GmFd3elFEUoVmFsUChYsh9f6pmCRXrXM
	1GqrO2khAmYL5Yx
X-Received: by 2002:a17:90b:3ec5:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3aceec259d1mr630979a91.22.1792177131654;
        Fri, 16 Oct 2026 11:58:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.204.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm10498800a91.3.2026.10.16.11.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:58:51 -0700 (PDT)
Message-ID: <6ad273eb.a438010f.f3b39.fcd2@mx.google.com>
Date: Fri, 16 Oct 2026 11:58:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0000843482518840439=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: Bluetooth: request LE data length for affected MT7922 firmware
In-Reply-To: <20261016170122.27119-1-cochcoder@proton.me>
References: <20261016170122.27119-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0000843482518840439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1187540/

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      29.77 seconds
CheckAllWarning               PASS      34.17 seconds
CheckSparse                   WARNING   36.80 seconds
BuildKernel32                 PASS      30.00 seconds
CheckKernelLLVM               PASS      35.68 seconds
TestRunnerSetup               PASS      714.76 seconds
TestRunner_l2cap-tester       PASS      12.61 seconds
TestRunner_iso-tester         PASS      10.75 seconds
TestRunner_bnep-tester        PASS      3.06 seconds
TestRunner_mgmt-tester        PASS      87.48 seconds
TestRunner_rfcomm-tester      PASS      4.39 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.59 seconds
TestRunner_mesh-tester        PASS      5.43 seconds
TestRunner_smp-tester         PASS      4.28 seconds
TestRunner_userchan-tester    PASS      3.13 seconds
TestRunner_6lowpan-tester     PASS      4.34 seconds
IncrementalBuild              PASS      28.44 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/958

---
Regards,
Linux Bluetooth


--===============0000843482518840439==--
