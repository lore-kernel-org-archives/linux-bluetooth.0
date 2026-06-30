Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68469283FD9
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827790; cv=none; b=B4xRGRCfScWdVI9zWN452UoSNv45HrpSq9h5k1SiAmjcjxhYeLBS+ccYNtDR1HZbSi3YiX+c2qtSfk29EuDZXMI7hKgnXeHaJgmNxP0PYnAC92S71K/7oknwDIvbvK/uOVS/FzlaGs9YFiwEqkpukEGfhDGdBMSv9ZXizvSfzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827790; c=relaxed/simple;
	bh=dRnHA1QoVuAbJuPHar2E6RuYJw41stBRUjrK65sEnIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GqjrEQHdt8WBL0nGwiwYZIsGVq/QboOnFm0k+gSioGbNEZpAfGmcxbq3bqldr9r6AvzvYGD1NbZbwvbFDJqEfTHK3qQhQewwH9cFag66uv2doFW8PmQKRTD464dCSpekzYWjfRRqgljsNxZz83xjAMrv+Uk5J61iBFzEi0XQddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6oio7Ce; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6oio7Ce"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51a837c8618so40034171cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827788; x=1783432588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YT1lZUN9YV045Vu1awOJt6moJwt7fh2iG8/dzsq9LE4=;
        b=K6oio7CeYSLLbAMnLJHkprKJXWYA3mMMRGrX2vIjqWzDsmD8IJgsu7vO00+oF5sMsJ
         wdI5SS7LpZkZU2Hks5lbhNsPGO6u82vRxjtmVPocMRPhUpCZ/81HZhcHeF9RKaBFCRTJ
         Rw9lkGhcBteclTytcyH9TRsqyqsP44kdFGnmdeN6LwNGZTMXpkvKUZeFO0wfc8ZFfHIQ
         aBi9H1dNKABpPHVNQY7ljrNnC/d7D364esOaz04xqjvwlFYJtieNxpehU9TnKSxMHJuQ
         CAzq7XVte8bHCPvrw/TlA2oFDmpJkv5f9ryCuApwJg5Pn7rPskbQE+e8wyQo1wHAusis
         yEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827788; x=1783432588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT1lZUN9YV045Vu1awOJt6moJwt7fh2iG8/dzsq9LE4=;
        b=DCr2rEsaTpRPfoou5xBM76qQ2r6yb/JO4f6VkjoJxwu3EYsHCw+wRi0lwkfRAU8htn
         uiJOiSYUdClE+oYK+jxoe4FKJAwcWCVQl5C892qbNqQpcm6xT6/JyxRN9LBFT1d4QhOC
         OzFaYLFmuytAzV5EMOVuIr28qEsozgHzLWsJFGKZxSCqrB4T4zRrOaKKG3Nj7y7tnnaS
         BDIjl6qcp5fdj9C81GVvxbkkH+BsJYFoqPNfM83nRt1iYs9/eK8MkLxz8ibhmphlUiV4
         euqm+vlSp6NkbydkJGwCCs5o0GHdO5gDoMMe5NN1VVhQS1ACS7pIrvyXu7tmUwBuiXUP
         j1PA==
X-Gm-Message-State: AOJu0Yw2uwYrezJ3Y2NpGQTMAvaQ4hY9VwOQ6wTd8EkeDP3eTn3Cmzsw
	VhPv+ewmgx0O+HfrhoN6iPVfKyGID4tqlg5lRqW3Vjzc5bF012g1FozCCZGprw==
X-Gm-Gg: AfdE7ckiH1yRfBNu17R+EHiZbRsh4gYrNmXLFsAt64XO2hAP5MjiH9NrIbdQ5YtuaBl
	2VAdkZI0m1jP7yeffEhxOqZEV1Xa9ALNW1wjTWjhYW21mLe+5D6SYDfkKJaGoln8mZ5w+MmndUU
	qKFhzJpra4qaO9IxMyqI4ZNMYAhL9AXwcX8n3vli89jHDMeJp5cSZ80DtRD+85XGNiZHuIVYZQs
	BE+OG21OLno8fpzOQSv7K52JX1+l42uTrHoIHZlglDxSFlGodi9jPuxHh99muLMHLJTtzW+nvYB
	LEeLvr/so7dwnraUo3v+cPUZZTBag8uqHIhEj9428mHwslnTBghVub3EQukQsr47V4nPULC61c8
	OasKWFhCdq9sw5tBBby3L+g687VR6Xhlti4w+73vuHrpg0r/U9QgtREmvHwYwLq54q1vVIc0Ukp
	lORX2sYoFMQ8phZXToopEW
X-Received: by 2002:a05:622a:286:b0:519:f420:d780 with SMTP id d75a77b69052e-51c10795bacmr43579921cf.30.1782827788347;
        Tue, 30 Jun 2026 06:56:28 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.216.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a360e0sm18705561cf.30.2026.06.30.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:56:27 -0700 (PDT)
Message-ID: <6a43cb0b.97717f65.1aed61.b923@mx.google.com>
Date: Tue, 30 Jun 2026 06:56:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2528050687471071054=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260630123539.668776-2-chris.lu@mediatek.com>
References: <20260630123539.668776-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2528050687471071054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118999

---Test result---

Test Summary:
CheckPatch                    PASS      4.49 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      0.29 seconds
GitLint                       FAIL      1.96 seconds
SubjectPrefix                 PASS      1.13 seconds
BuildKernel                   PASS      26.92 seconds
CheckAllWarning               PASS      29.67 seconds
CheckSparse                   PASS      28.65 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      489.46 seconds
IncrementalBuild              PASS      31.29 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,2/3] Bluetooth: btmtk: Improve BT firmware logging

11: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
12: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
14: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v6,3/3] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/376

---
Regards,
Linux Bluetooth


--===============2528050687471071054==--
