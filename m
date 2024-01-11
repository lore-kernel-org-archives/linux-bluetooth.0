Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336F14F6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGtgbpgj"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-598699c0f1eso1797641eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969239; x=1705574039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1j4oNottpKajeSN6muBeorwkbpcoo6pZTmRS2u6z+Q4=;
        b=SGtgbpgjiNRmDZ5crb08rb3C1dW01lBChf0cyLXGsFmVr1qPt6TFCQ53EBhpgRQ5O2
         r6Qq5I4FoEgd7nOF4NgZhcYjR1nmP4xghiBGqf1RcGZPFa4LGdNcnGhMeuT0miOenET0
         XpejLDPNwvLhzOHLq0WcEfSYdJ+7axOzL61CQhaorH+8IIaFlFZktDvLdcGKh0nQfZLR
         OKL8ry+J7OX0KNO0ute8QLXxQ9s1I7q2bUw/iHDXiPRZkYezOIQ9hGmFbfj/Dxa224MA
         nW5bYX+sBomArOavMnLwKZx+crvSDdKueUAXBGcshyoPoDoAO68gaQDf2p2QVE+RPDiO
         ahLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969239; x=1705574039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1j4oNottpKajeSN6muBeorwkbpcoo6pZTmRS2u6z+Q4=;
        b=aWC698TsffMsfyaQ4WmxG/50IEC2mK2mbFCWgvQyjcOD1M8yVO8DWteGa4461jw187
         EyUuzXBI0LoKbV/4s4zR/yxsSwD+9kWBqDYFLEY9j0jbu+Nm4hrMjZCU5u5fk0mxDAyr
         P/Y5aL29CXGssdk5iJ0fFQNP2kt5TL6FhSXmweLpFHuZ5UahrRt7/98MlvrcmUhXdmD6
         st4Z2fgDYtRaXvFRf7cy88XDv1yrAdV6kCZfkwm+mVc/LkZg0bh+RTEGHKd2gYVcE59G
         xETOPd1tnyLTY+zRRFKjFTl/Jn+Pp06eS+Om/N/cmp721blYElLNuVEK8MCYmKLmeGkt
         uN9Q==
X-Gm-Message-State: AOJu0YxuhJpAKj+8PAbEkSVtsM864/X+Vg5KU0KO4+BuAvbqaki4G6CW
	fRPyUET+jFStQc5/Lq4B5CR7sfLYkFQ=
X-Google-Smtp-Source: AGHT+IHhokGwF48ZJRgDiDQGuBjOLeSCo/vawI1X9mAIcxIxUT54/fJbiMBAA9WdNRYz06HXkrtEVg==
X-Received: by 2002:a05:6359:29c3:b0:175:50b4:8ca2 with SMTP id qf3-20020a05635929c300b0017550b48ca2mr852076rwb.9.1704969238956;
        Thu, 11 Jan 2024 02:33:58 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.199])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006d9974a87fcsm825534pfo.215.2024.01.11.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:33:58 -0800 (PST)
Message-ID: <659fc416.a70a0220.1db9.1471@mx.google.com>
Date: Thu, 11 Jan 2024 02:33:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4530883066847924077=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Disable Power Save feature on startup
In-Reply-To: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
References: <20240111080642.270123-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4530883066847924077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816084

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      30.42 seconds
CheckSparse                   PASS      35.85 seconds
CheckSmatch                   PASS      98.03 seconds
BuildKernel32                 PASS      27.04 seconds
TestRunnerSetup               PASS      432.04 seconds
TestRunner_l2cap-tester       PASS      23.37 seconds
TestRunner_iso-tester         FAIL      60.48 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        FAIL      168.04 seconds
TestRunner_rfcomm-tester      PASS      11.03 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      12.10 seconds
TestRunner_mesh-tester        PASS      8.68 seconds
TestRunner_smp-tester         PASS      9.69 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      25.61 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed      10.353 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 1, Not Run: 1

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.247 seconds


---
Regards,
Linux Bluetooth


--===============4530883066847924077==--
