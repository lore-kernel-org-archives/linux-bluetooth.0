Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3161D7E57
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589196; cv=none; b=Z3hrzlBSQil7Hl2fbFWHYr+f2Fx3Fb5FtqGRP543DWHglHrM3Dty/sHXUOsDbm3QEd2tGLGm0++O8JozS2MELxZ7LbP1dR2Vo8kKmizXqPa5vNVNJTYczE4cLmrMjnnAXhsH/MA4J/QrAKyqBgx/2TAqnm4+o6v7xWEQds47hOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589196; c=relaxed/simple;
	bh=J8VisfGU5JfpnKGrIG5MGkd6N8ylZ+2bdj6wQmUjaFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jusrh1ONXnrT6LjYi/D4fUDTJl6OWYicj4+Q19FeUX7gw5e/KSj8dBpzXtaJaLtJcFDaAghpIz3wOzqXb/W2XPPndyDp91v1KzTaoUASmv6Sk4oM8wSveU36edIA63veesn3DtiSZag0/AFJnMAs1sGIvHsW2sfGPCNGcYrgKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5++t4J+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5++t4J+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a88b34a6so232447785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742589193; x=1743193993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDBXx5XhroD0Mmv48ovS/J6Ni23YAwIKFvfdFNw5W4=;
        b=K5++t4J+WCCGoGug0PlMqcpS5FROp+Goy8QWlpWZwYhtBpETxxOcwG7aofeXkynmyJ
         8TymZdFA4KL6rIsRxYSBc+/EvK8kZtny70mQ7CqqkO49BCmdPhF3pMYsui8dopS3GGW0
         Sujb6JvU9iuJEecG57sVoo1Zv89JvnlM9TEIQO2P1v6zKTXav6DqabObxJh/W/aLvMic
         o5GOoVgYjD0NGxRJ0E7saWg9qi26hBA3g1TAa0hVa4rCf1grUDe+gREQB1fvW0sz87RV
         WKIjsWH9k0CuZrZe7enjcWs+5u8oU3IyoUDbyVAP6EZaVGtYIij96vf7YvWZd8upu9B+
         TLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589193; x=1743193993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKDBXx5XhroD0Mmv48ovS/J6Ni23YAwIKFvfdFNw5W4=;
        b=scXCmSfb1NNun3K30NHNxwu18NaLjHGd4WOlrEeFVtYQxz9z3V0fxNwVbQryi5CI4+
         Te30g/PwXSLEDGy/kC+Kci+xDDxGyYdoLbOfQoJdZO5Nu0lyOtIHssHdxy6iTehcrCeT
         YC+PIRvZCEp1RyeHefkRfoxsE3O47n2E5Fapj+2ote6bWZZiAQtIZj0qR4OaDSV2gbje
         ZBZVaEsyMYaoiXA91fyvHWOJl6EEcGxzJ4J7mOhFSh1H/oYBaPtsZf7cHU0BE4IQdRu6
         MC2LHacz8Lgg8ijALSfH1WUqvTK6NT8Kr0re2Nfho8WqGMqDjRH5tPJhmVU8nMnUoEef
         yA/Q==
X-Gm-Message-State: AOJu0Ywzbs9SMV5tn02sodpArXrx1dhzMbY2FAj8aRcbanE6ONPSLM1F
	C8sxzgxAzrmc+c/s+ed1aWJF5ebJ9erC6KEn3DGW2/7mYJetqrYKHDhPPQ==
X-Gm-Gg: ASbGncv7NziB3yQz7RZCkHGBdis6I3zzRiBEccqoOMmLWV1w/PlrNLhvBCusMJQDQ0c
	jU1Kyl/0Fkb5t+x0fEVE1VLgeZIvswcudlb/HXLaaNLUPHAmn9xd0tmDYFhdUMFdMuNPlXmGl3A
	upsuASBKeMaHgLiXYbLOBQfijG3mfdFYdig4YKGdUBVe8i5TdGm1Sv7hQ/rA3Dd0AxGtkkU0hCW
	sjvZTzpjDe3g7CN8AW7ShH4ZBPtVN0/hgqO5XFAilRGg796PE2U05crYRtxkOX9sc2s36NI0FUT
	Tvy5yb1pS3BX5r+SG8mhcJ+2IP8hp3+5Wz44A4qfxzt/nSH0aw==
X-Google-Smtp-Source: AGHT+IGrZKJHNpbQI189gG5atzjsxv1xgZk/P8pqXwkRDTQEoyfIxeOQMFmq4mtf+MaONp/Sgrks/g==
X-Received: by 2002:a05:620a:2806:b0:7c5:5670:bd6f with SMTP id af79cd13be357-7c5ba1fdf05mr873882785a.53.1742589192942;
        Fri, 21 Mar 2025 13:33:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d6105sm172333585a.36.2025.03.21.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:33:12 -0700 (PDT)
Message-ID: <67ddcd08.050a0220.335548.9535@mx.google.com>
Date: Fri, 21 Mar 2025 13:33:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5627177468694044833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Add LL Privacy Setting
In-Reply-To: <20250321194627.1729246-1-luiz.dentz@gmail.com>
References: <20250321194627.1729246-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5627177468694044833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946405

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.99 seconds
CheckAllWarning               PASS      26.46 seconds
CheckSparse                   PASS      30.06 seconds
BuildKernel32                 PASS      24.18 seconds
TestRunnerSetup               PASS      426.50 seconds
TestRunner_l2cap-tester       PASS      20.69 seconds
TestRunner_iso-tester         PASS      28.38 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        FAIL      119.02 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      12.32 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      7.06 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 471 (96.1%), Failed: 15, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) Failed       0.113 seconds
Add Ext Advertising - Success 3 (!Powered, Adv Enable) Failed       0.105 seconds
Add Ext Advertising - Success 4 (Set Adv on override) Failed       0.128 seconds
Add Ext Advertising - Success 5 (Set Adv off override) Failed       0.136 seconds
Add Ext Advertising - Success 16 (Connectable -> on) Failed       0.115 seconds
Add Ext Advertising - Success 17 (Connectable -> off) Failed       0.115 seconds
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.112 seconds
Add Ext Advertising - Success (1m Connectable -> on) Failed       0.110 seconds
Add Ext Advertising - Success (1m Connectable -> off) Failed       0.115 seconds
Multi Ext Advertising - Success 6 (Add w/o power on) Failed       0.132 seconds
Set Device ID - Power off and Power on               Failed       0.104 seconds
Set Device ID - SSP off and Power on                 Failed       0.100 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.183 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.189 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.150 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5627177468694044833==--
