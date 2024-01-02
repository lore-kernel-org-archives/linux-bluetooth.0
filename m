Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D810A03
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJxmM1Xd"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680a9796b38so18397986d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 05:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704202457; x=1704807257; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xKg47vgEFwXOpFzIpuDEQ8AsB66s2kNwkxJppLXmKNo=;
        b=fJxmM1XdnaUvvdv/N10mixnnGexmbGNG1ediXvggVB68rT8Tu67tbCLUNJg72bR8Ta
         kGuuv0KM1eJ57Reu7X9hrEwylXnm5nXJpeMJE/xp9wpmtA37JcW7AYTajr5yydxygMwb
         TwC/1taGC60n/oJdRMFXinlvF5CualhKbfKFuG2omdHmn6AblozwJKHDwdj5wsqo6KTq
         jQyB97pQH166jewlIZvuZQXGw7zLPHiFQAYawEUf+rUY828MjT1UqQxUI2JWCenASJm5
         HmJO5b1+AJ8dPeD4tEFnwLLI4qW2c93MlnqWV/aRJbzGOYcMauoX4KjBHF0HmO1pgnyg
         8/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202457; x=1704807257;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKg47vgEFwXOpFzIpuDEQ8AsB66s2kNwkxJppLXmKNo=;
        b=KvG6thEGiim9K8Ca1ZF7FsCGfOE0Hhbxowas2JEfpujTdzTYORgPgO7Q4skSP1s06/
         vMPhi0nE/WYwHXEIApeHMUD9/5O3Yk+N4Pqk2ab/AyTsKqO0+ZmYrzIPlCx4p8zgNT+f
         NdlRj/NaAfxnzb21qDmPndnurxPlLMsidD3ndnbEKrMUFFeUVEVfo/dKJUXjs8yGIjUE
         tibRxIegMA5Ml0RSECt2aKGRaWbss3r6SnHd2R/dayD5R41fmDJbOnWsLdlN/EqvMaL5
         7TLgQU+E//uTSAwWE3DWd6FVYAU+fgngKJwCka8yyJuvpW27TJ6uWFfunSwLwiE6Mjs2
         kIIQ==
X-Gm-Message-State: AOJu0YzEK7NP0kV1y7JFp3VfYUngil7/Ivqnl8HvoomqJSVVwO38fEr+
	/1RFw0zmPxrmaCp3+MJgRzgXi1cJY1o=
X-Google-Smtp-Source: AGHT+IHCBBdfliQ4lRYLhzwrYlT5LPWuJBFuM8RXdpDgDYVthfVvDUzB+tb2juSuwQq08Gya5lNOJw==
X-Received: by 2002:a05:6214:508d:b0:67f:273e:6aba with SMTP id kk13-20020a056214508d00b0067f273e6abamr31669536qvb.57.1704202457063;
        Tue, 02 Jan 2024 05:34:17 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.42])
        by smtp.gmail.com with ESMTPSA id ek5-20020ad45985000000b0067f8046a1acsm9495008qvb.144.2024.01.02.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:34:16 -0800 (PST)
Message-ID: <659410d8.d40a0220.d80a0.a788@mx.google.com>
Date: Tue, 02 Jan 2024 05:34:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8400856307541696441=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: [v2,1/2] Bluetooth: btusb: mediatek: refactor btusb_mtk_reset function
In-Reply-To: <20240102124747.21644-1-hao.qin@mediatek.com>
References: <20240102124747.21644-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8400856307541696441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813831

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      28.23 seconds
CheckAllWarning               PASS      31.25 seconds
CheckSparse                   PASS      36.46 seconds
CheckSmatch                   PASS      99.93 seconds
BuildKernel32                 PASS      27.54 seconds
TestRunnerSetup               PASS      437.60 seconds
TestRunner_l2cap-tester       PASS      23.05 seconds
TestRunner_iso-tester         PASS      47.30 seconds
TestRunner_bnep-tester        PASS      6.85 seconds
TestRunner_mgmt-tester        FAIL      160.98 seconds
TestRunner_rfcomm-tester      PASS      10.80 seconds
TestRunner_sco-tester         PASS      14.39 seconds
TestRunner_ioctl-tester       PASS      12.03 seconds
TestRunner_mesh-tester        PASS      8.68 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.10 seconds
IncrementalBuild              PASS      31.60 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.269 seconds


---
Regards,
Linux Bluetooth


--===============8400856307541696441==--
