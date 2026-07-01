Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02C298991
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916294; cv=none; b=fVKprLnTeZmEswFApyHLbTSJBZAw5s8+XJHbUD0WRM6yFRLB7MCYKK2Zdz+OT69aEpKIhiai1sWhsOGaoLe/tHY+ZfBb+c9SYDwVqWVDoe1ABy8DAD5ckADqKi9nfiS4uuQ7I5JD5aRPH3N6oYIyK1jB8nwLzQdSYwxcB/ORPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916294; c=relaxed/simple;
	bh=d3Yt3evpOlTUdIKBXRBnsSrnWnoMi3mr+hdSPsCnkz4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m2d/aUBcqZDDzIoOiYKsxCYYCb0DSQDAQjQQWQxtHvXwfBNkWl4RnqLMVZXWyeXAWn4eOnMfcL8rM/Yznz7uenAsIuay1bBm6QUNFFimsWJWsGEos+QpH4v6376Nbn8ay308/2Yr68/J6ualb4HqjauGus6j75H+V1/GUZRa9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5XeCohx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5XeCohx"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8000e21f014so10713727b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916292; x=1783521092; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RYui4rwMevN5us/ns6ZOKvH/+rlfAQvGc1XJViabSek=;
        b=S5XeCohxT2RIFzDv+WUAQVT9v3yUuh5gIItlrbylWWucnWsAgZzmg9GedhSawXWRbp
         LGHfvChIFqQXrJO4hrsjmaQgu+HD9iIlx83mTJoWzxGWQa0dbjVVNwRBnoKsiy0l9WDA
         ftaFJC46thifAE2LUIsq0CDzbchwd5gycdErMQMsVjitp2WZCYim3vUKEbpxOqIwODL1
         iz3tRojFp/mGV40dxZgUuiSX584ghtcwDKT32zK2b/4aYaq/vgZLwcUEgmTbT6gh7OOJ
         ebqvdxjIgb/SMP11yqdZG3cnNMWbpiCzaOzFqi1gIUF+7h6SoNtJA1ivbAgiO/M+x2rb
         K+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916292; x=1783521092;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYui4rwMevN5us/ns6ZOKvH/+rlfAQvGc1XJViabSek=;
        b=MTGKkLgFJ8Govxuu93SOp4KfxtwQGKqXENHMpWSHcL3ZHu4sgodD+k1KsyAJJpKgUc
         nlFyt2KZv05zcIBFOF6DGsefje433NLHthwZYGth7Ie1gd+JOUe36YSrDibalw8jEhoa
         YmchOrliQtzBEFZwoGHLdJnPsnbgmUHHV2fSpqHcpYoXj4fdUZhekoJkFbT6bFAnJfXU
         ddtQiyt9W6coLN1ySFlBo3sJUAJQUXneGczZwevpRH90jpIaO5aa/d4nSgVVI2a6j6qJ
         leyBOBvnYkQqLqB+wGB0UmiaZayWbRy8X2x1UF9zbEM1E89iSWNY9hK4MpqhKc4L8UGB
         PbWw==
X-Gm-Message-State: AOJu0Ywx+k7NH5t+ln09+2emt83JJEEm7CJbfYjK/WMX1sSALU8Fb8hh
	Su+KVokCMYbwgkEYZQp3GTLuVewwmNXsCxmkEtj5tiBUuqwXYLZKSskBk4TTCvvx
X-Gm-Gg: AfdE7ck2IQVB0wqmDSmLWtpJSpEokNmou3QNULJUJ4wm/8pqcwJFz+HJUDa9v8t37Cf
	QgqC4zbSlHcXAwLujxi9Zx72my9xq1bfcaO0UwsN6pTiMJ3paycfjeCWGGT9aae3ldDWAAtFpz2
	RmxDSNpCQlsM3V9u0x2ha6qrMH2r8h3yNsaADKaZQuFngqQ3zpVPX8ohu74Gy56uq1Df3mtKHkR
	cQYQ7+cSROSffSndeuA9CNSaT7tb6Wdtoi0mpgxLdAZJd7AAET5fhjXFxjty6jL4Xo+SYlTE5ut
	4jgzkpN8UpUcwiyHToDAMWZRDffpX27ps4OXvSuWSfRrNvusonpM+iJBbrRPVd9hcpt+uZdC/Gl
	6VrH6+6/Z4ZIMbJAGYrVag3vvjO86YMnCciW5Tfl4uZ99oy1QK7FTZ7pz9VDvsSYr2w8dZ3ASr4
	ZWU8YkhLwWuTcIhBi03et/KNdbeY1kJw==
X-Received: by 2002:a05:7300:4309:b0:304:de2b:446f with SMTP id 5a478bee46e88-30eff2b53a4mr2078907eec.28.1782915864125;
        Wed, 01 Jul 2026 07:24:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.163.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300e4a7sm20481827eec.13.2026.07.01.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:24:23 -0700 (PDT)
Message-ID: <6a452317.ac469dc7.22d7c7.70e3@mx.google.com>
Date: Wed, 01 Jul 2026 07:24:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2033344892074157209=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260701121345.1231906-2-chris.lu@mediatek.com>
References: <20260701121345.1231906-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2033344892074157209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119720

---Test result---

Test Summary:
CheckPatch                    PASS      2.40 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.73 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      27.21 seconds
CheckAllWarning               PASS      29.79 seconds
CheckSparse                   PASS      29.10 seconds
BuildKernel32                 PASS      26.45 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.96 seconds
IncrementalBuild              PASS      30.21 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,2/3] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v7,3/3] Bluetooth: btmtk: Add MT7928 support

28: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
33: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
34: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
36: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
37: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
39: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/379

---
Regards,
Linux Bluetooth


--===============2033344892074157209==--
