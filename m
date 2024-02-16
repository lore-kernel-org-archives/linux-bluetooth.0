Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B112BF0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122759; cv=none; b=Fzvqfbue02duVMaAbHKLLH7PqArgFt+/U04T8W9R+Ix4N1Y6fcG/B6K9LYBPrw0D99FLVPrEHsgLegxqJDWb2Jbu+eF06vFU/hdWCX2vt1PbxabXEZZzDrq0BdWWVs+IiTw61LQrwCNOAsKGGT6ulTggYFNi0LTaEwSXImQLRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122759; c=relaxed/simple;
	bh=zb1P9RCZ2pB5erWBo65jUc8SY3N6GYAF8MGkliXNq2U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VSGfqzKgIX3L2OeDQEk7dsDUpBo5Xs9U2YnHvrou5oL3Hv5wdFZ6yfd/V2+JO4Dmf+6e8MFmX9DAJI7HQkTJw0QfXJ7z3uc6ltu7sTPwNAePAt1AsQtdyy7TzBm0nN+xXWBDIjhJdrO4hsupJ15UCDg+BwObENUOSJ0Nnf0VygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIwQndvf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIwQndvf"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c3ac1fdb9so10622336d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 14:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708122756; x=1708727556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DX50ZCYlnH4PZJaIl9wax5br8xZBqGo5cs7K85b6v5w=;
        b=dIwQndvf65+9GtWR53omGVrWy1Pv+bjEAlJ6YY4nP3N0wZV8J0GMQk9fEg7GnSGhY4
         weSP/rF6HhHjS+svpWcdBsalLh6WsAEqFwgABI0RW85lKUyIKGCS848DLLJllXucThHY
         t4eFlZau+JGHbnJhCcQGyHpyAZXnscVsHGpn2TATVH01/KFlDHcXu/8PQ2Q19oUoCZc3
         HLQSrFdFoce3rFmyPAhv6mdDko45rMuak0FHwsbUeiyfvoHePF0TTIqxoYpuqfMzD+8A
         iIy9HjtfQrbLrfP8gxpmrcmugfxvdetaKL8n87QX2S0yWOouTQB04QmXiM1jkOdv6Msz
         1fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122756; x=1708727556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DX50ZCYlnH4PZJaIl9wax5br8xZBqGo5cs7K85b6v5w=;
        b=jA3De31kSXQu6l5Yzd+dPs0oraw+Bnj0ydebZrvFiZ+6mIxPA44Bq4wBOiubHXHK2x
         tbhi3JP9JfJfx84lOHNP2RTF/cwQhCgH4QqGMkqCd1k7JdUK2DbCWmydLP9DYybBcJBs
         jff1BxNBblNr+f01zaLsHtMBPbFLqyYLVrd8kZ1RFptTUSCnjb5vtER8guxRbgl1XQrc
         IIfHzxNUu1C9HM1ZhfRKOAIlOiOXeAcz8y4nx4Yer+ttJn0fx3PaDbhFTExxx5MbBQxq
         ztKO3zcwUScuM02Gfxg4whtrzJt+eCDPJoS1Ud7JPK4eXTyiJeSKuAdpaabs3hmhKtlk
         Wg6w==
X-Gm-Message-State: AOJu0Yw/EUtv4vK8gykUfOttLUHTNNFcEZOeWRxspGBHRBfw2ExEjYOF
	GNYBipjb7KD9IL04KOhsheusPK2hnixZ4E7dbdlhCksdscN94VHM6AhOg2Ee
X-Google-Smtp-Source: AGHT+IH2Je3seGbrgqHv5+Z/vRdZXmlN45pMbHT10f+MaN09h3OtIiK4Yur9TH4l6BTqDw5OCHVMKQ==
X-Received: by 2002:a05:6214:27cf:b0:68f:3c24:4744 with SMTP id ge15-20020a05621427cf00b0068f3c244744mr2245014qvb.5.1708122756442;
        Fri, 16 Feb 2024 14:32:36 -0800 (PST)
Received: from [172.17.0.2] ([172.183.52.222])
        by smtp.gmail.com with ESMTPSA id ml22-20020a056214585600b0068c776b01fdsm347534qvb.65.2024.02.16.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:36 -0800 (PST)
Message-ID: <65cfe284.050a0220.a412b.2f3e@mx.google.com>
Date: Fri, 16 Feb 2024 14:32:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6744902121693833217=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
In-Reply-To: <20240216214016.251819-1-hdegoede@redhat.com>
References: <20240216214016.251819-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6744902121693833217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826948

---Test result---

Test Summary:
CheckPatch                    PASS      2.29 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.68 seconds
CheckAllWarning               PASS      30.71 seconds
CheckSparse                   PASS      35.87 seconds
CheckSmatch                   PASS      99.61 seconds
BuildKernel32                 PASS      27.12 seconds
TestRunnerSetup               PASS      500.52 seconds
TestRunner_l2cap-tester       PASS      18.07 seconds
TestRunner_iso-tester         PASS      31.03 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      167.55 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      10.93 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      8.35 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      26.17 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 3, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.119 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.146 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.879 seconds


---
Regards,
Linux Bluetooth


--===============6744902121693833217==--
