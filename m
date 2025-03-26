Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46C18C32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979802; cv=none; b=BhiI+2xco7rz1NwFp5EAwBryz45G3cJq+XGvL4cEmPpTBXGUPUHc7/66XuSzB0PNmCWgG8Rbyj6KjqAUkodQ1lVimmw0ojiFOQVPPW/YBFJ7AB3RDgoabCf2xRJrYyzHhwnT/8Bv4q3k7yDiZPasdxKGUuKBsaI0kZbYIoehlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979802; c=relaxed/simple;
	bh=BnREW/R2ImqGIGUC2oTzESQa6/AI2cZNCoGiWj0vnt8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WZRAK6aNgLcU4MbTMqFKlKjnu0T7SAaYQ30O4w83bI4sUZfi82Z4SVXGq1umz8nGmq8XGKv1PWwqKDK5x/AoCHIKDNueyh/qb5vL07/nTB1PpvFL79U5qEtWs+5cEu7RRzkGfSaJucpSC/TORnEcJFEPcGxEdQcC6fGIw3dOV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU/Mi8lj; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU/Mi8lj"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f94b7bd964so4422779b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742979800; x=1743584600; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dPPDEbFHeM0mwsAq5nm6cNaV4ATRhGuCXkJy5VgwSXc=;
        b=WU/Mi8ljtf+jVSI2pKbqyaXozT6EGmY+c/i+YqUfepXNM1/0HkR8Si6hrRdlDWt7tn
         0OA+8USi4uizwrmgf/mKsvWiw/IMqsIVS145wcplMznxOpBX103ckyN4xNxI6Rr04DsE
         lUM4xs7l560E5hAklhELTWK726TzbITWQr/HPbVvnheHp7oQYeyMJw85hD0TKJZHGc9u
         5XAy7rnRfqaGLfcHE+mpTH4XIqAI/AUu8htOcU9BeXqWreRzKCirSYSxdDK3zukyLSHj
         d0DxwTOfjtNHakE2cYbw7AxVRvmYjX7FrbjTLcPmp8YvzCCw+tsexWhfH4mngTgA9tmf
         +zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742979800; x=1743584600;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPPDEbFHeM0mwsAq5nm6cNaV4ATRhGuCXkJy5VgwSXc=;
        b=FyJzYogm1okLwXSWxQCg+duTo/Dc0rZb/ow/36g8wgUzKGY3maVYuGyndXF8VcpRr8
         VrfmO5p5sBuZpeHhHN+1Q4QAMaAhBYapuzG+MJlgZydrOSXUWotZdt0Q6W8vWibXhSSC
         o9/CMV5KTctvumZfqW9RbJYOWcXZW0SCIrV8+OtDgQr6JAUMbaFDRB7XCRL+5lECfFZy
         RxzTFKWV8sTAltaAk5sEtjIR/SSd2sxWlemwuC+AQef+TpFPGktwOSEprCe0h1PBjMfx
         Ze9O1PY4VJT/cIvgKV+B+z/MPvlTW4KjpADB3B1sx/Ec8w4TyPyzcktrdhNmO4DKKuwU
         LBWw==
X-Gm-Message-State: AOJu0YxxPbzFxYda8tSXzPOJJtwQeODoSk0ySHQfi1W5XGwegJeYO9cJ
	601EbSUkOST8hKWJpMwufNoa524jevzzor/FHaA6pGP7KCcgmUTs6VXv1w==
X-Gm-Gg: ASbGnctbBVLJgb37h83joFUjdxoYEggAoRDvBkH7UdLQkgU+i7bK0Md3t5mLJaHvz6z
	xLBgU4ZdyJfFypyXNoHIvoqGN1pPIsulwvZlJWJjTTnOUbdXZf5/28I6bvu0iZ9r1gX9Gbmkv4p
	QeWIZ0tOs0/JDc0iWuiH/Kda24BKGBmc4e4XmSPYGkrKye4KJxZV0T93UP6hjDONAMogTED/LTA
	cy/q22pyjNt5PEoMyWwp/5IxDOZZ/n7F467rIOCRVgUvrB1EWB/3RFB1A4Mcev1Wbl7Cn/RqohI
	KGSEGBJ6U4V5JBEehRrbQA6DycvMgxbFRsHwZ7yiRfTqdw99ZQ==
X-Google-Smtp-Source: AGHT+IHmlB29CmYsKOowVAvh8AyufeB028gobtxhW50uug1V23IJrQKaYIyNb/jxAqKze2wG7IwqQQ==
X-Received: by 2002:a05:6808:1691:b0:3f6:d59b:805f with SMTP id 5614622812f47-3febf7919bfmr13446653b6e.28.1742979799858;
        Wed, 26 Mar 2025 02:03:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.85.44.113])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6bf683sm2306833b6e.10.2025.03.26.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:03:19 -0700 (PDT)
Message-ID: <67e3c2d7.050a0220.24e9a6.fdb4@mx.google.com>
Date: Wed, 26 Mar 2025 02:03:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3695529916237226139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
In-Reply-To: <933CB507F0C72912+20250326084135.18674-1-wangyuli@uniontech.com>
References: <933CB507F0C72912+20250326084135.18674-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3695529916237226139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947388

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.58 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.08 seconds
CheckAllWarning               PASS      27.61 seconds
CheckSparse                   PASS      31.29 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      440.13 seconds
TestRunner_l2cap-tester       PASS      21.37 seconds
TestRunner_iso-tester         PASS      35.41 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      122.89 seconds
TestRunner_rfcomm-tester      PASS      7.92 seconds
TestRunner_sco-tester         PASS      12.81 seconds
TestRunner_ioctl-tester       PASS      8.49 seconds
TestRunner_mesh-tester        PASS      6.31 seconds
TestRunner_smp-tester         PASS      7.33 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.173 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.178 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3695529916237226139==--
