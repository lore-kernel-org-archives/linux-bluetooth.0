Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E032ECD1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292471; cv=none; b=u/962kOrUrdGaXK1m5YTXqnHBNvq47PlZnwJxYIkHOOARuN3YuVBFDaWSlugUKIq0v7V+bCZbJEARVbosDQ4DWgr/Zur76+m3PhhilvagT089VDyckAzdzPXOYSP58xzFtL3bEAREU2QchWBzkxWJDDmKSyvE2uczK9bDPqykJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292471; c=relaxed/simple;
	bh=apZwyhRlHhsDDETZ4GtAokl0tu0ytkkV9hEW9Iot71w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UeW29T1cfJAsHyGWph697zzDmGOkAdZDRE9OIIaqgkdKUd2t4f/BYe4b3vv3hH24GLvuyqqhwZx3jRF6CcV5KHu6W3Q+oLNrIoKDJ0f5URx3igP+8TcxEDqD1L3djNfOmhQbbLn9cK75SmQF2tS3870SVL+pxK3ZVVWNLzR4M6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjDoIupi; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjDoIupi"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c52cc5285so1129990eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782292469; x=1782897269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cZZN3eUOlEddK3dwJMqeQa/tSsGD/kQCfKlckbN584k=;
        b=ZjDoIupi964j3tVoUxDjOHnpbga8QM+RDcJT516qHQyFiKj4IoFjzEjKTAq6ySdxQc
         67EsBcawTVqpV7W427Y94pyww+c83QkRPqmvddEpoJmDUpcg1jPEkp9acWA6eZUS8ZUr
         wRorh9tvs86ZWK1+h03YuKiJaFhaZAZ0aJaGtrlO1EDI+ntwS2JHP78TVyXScMDEBNXW
         1QkAmQ7zvYSnyOBIEXxNABEIbxNFAB0ixbFIRF4JhQ+8eWEpf5rMAU6nzs7TRtQLk4QW
         9scqrx3NRBX7IfbnXIul+rKaRMmc4KMdkvb3RdEcTHX+CzbpuQltYnNEeKZzYK1AJwYd
         CPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292469; x=1782897269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZZN3eUOlEddK3dwJMqeQa/tSsGD/kQCfKlckbN584k=;
        b=Mfr8rwQFDBFBIx/FKS9nluEn8FIODM3/KieVsC+cXAot/HmAUgvrnX0zRrpThGaKmb
         uwmNOw8VnGJFbWMX7UyAXHXvyxegn7D2tsaGFSfkhFmo2BM8jgAuGw9KXw+2bKed4wAL
         IMfyyW8BmVaez6LdDyssbOQlF7BkdIL1wJtDSWYKUTXdnsycVTMF9Wny2U10Uka2kM6i
         pXCTxwr5PVZ1VRweqpbgt+Q+9UazAHl0yl5y+2xqfBj7kj8FRvBlBhZW/DtJj1VEOabe
         RzuUgillegdpXph9byn/IZPiVZVMwbFSVkWtuHW3ACbxF5/e8MI5xFP51daZTsMer4Ld
         c4tA==
X-Gm-Message-State: AOJu0YwRZuDbmcIhiNcxDUaHJX7/twtz3luzp2cg/Kj+U0L2JJWc4jaa
	Ur3RlxfJPK+an+3C6lhobL32lliiH38MZwAm9t3u6JQ3mFaE3vKCGb8naDHoqQ==
X-Gm-Gg: AfdE7ckN20TiKWLnt98kDgRw9XJlmqcG90rg+2xb3nse8X9+MfT8g4IJ3KBGIVvWeNm
	LYwWx3Lr84LdrwWZtm4ZJlfRM184vdcUSkD4Lg7t8iMMsyPS6VMsVb6tvi1HHCh/m5xNzYwO2dL
	9S9OpySsU2BGapOZN+2Olv09DtJ/OxHYTBnXrXp/o8cmpTk5N96J7uIOHLTUadF0j+2payKeTpH
	EvpCP35TibRyuvkmVjOunmYh+zQHUB0NxzH8IzTUi8JXKIavmNyfOEHhqjDrgVVL2kRTlFY/Urd
	2ac5cu3btAImQ75Q29IkVGZsxtav840g6aI8VJvEY9kEQ7BqoxQaXmIQnA6w1pKsotEP+rfgMCp
	arXthbcA4+JCq8ZmFRyVor2j+sb/bl8gFsRItGaghoUol0UU2PvE8AGR7jE2cXVK2TloRM+ZWqV
	DfmYAYnLaNsASuF4Rj2wiD
X-Received: by 2002:a05:7300:b58b:b0:307:287f:9bbc with SMTP id 5a478bee46e88-30c693386bfmr2200673eec.25.1782292468903;
        Wed, 24 Jun 2026 02:14:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c6eabb7a5sm2254330eec.26.2026.06.24.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:14:28 -0700 (PDT)
Message-ID: <6a3b9ff4.eea6ab6e.1b3c3d.0787@mx.google.com>
Date: Wed, 24 Jun 2026 02:14:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3973170215780046965=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260624075505.1318804-2-chris.lu@mediatek.com>
References: <20260624075505.1318804-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3973170215780046965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115762

---Test result---

Test Summary:
CheckPatch                    PASS      4.09 seconds
VerifyFixes                   PASS      0.52 seconds
VerifySignedoff               PASS      0.60 seconds
GitLint                       FAIL      1.96 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      26.78 seconds
CheckAllWarning               PASS      29.55 seconds
CheckSparse                   PASS      28.50 seconds
BuildKernel32                 PASS      25.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      568.81 seconds
IncrementalBuild              PASS      31.08 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,2/3] Bluetooth: btmtk: Improve BT firmware logging

11: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
12: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
14: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v5,3/3] Bluetooth: btmtk: Add MT7928 support

24: B1 Line exceeds max length (92>80): "[  159.784050] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
29: B1 Line exceeds max length (97>80): "[  159.795736] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
30: B1 Line exceeds max length (102>80): "[  159.807197] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+0800"
32: B1 Line exceeds max length (99>80): "[  160.143013] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
33: B1 Line exceeds max length (93>80): "[  160.152775] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
35: B1 Line exceeds max length (115>80): "[  163.242280] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/344

---
Regards,
Linux Bluetooth


--===============3973170215780046965==--
