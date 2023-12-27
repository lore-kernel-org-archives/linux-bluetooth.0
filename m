Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DC28E34
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFos4bJJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e89ba9810aso41276207b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 05:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703685400; x=1704290200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUl2xi/xiQwmIqstWV5ZixrBp6V83VJ5lBIARJUU1Ng=;
        b=cFos4bJJa0anpvVRoXE5oqagQoZmce5JqKNWtd2KxDyieVUE6TrUPyfPEmXCXrqtYC
         ZbhlUCTjS+91RTWYncfVsKE9KsqlTOibzELHE5uumijR4wBNB1qpREgqmnTPMzYZUdYp
         n5KxKqIzOZT3DtlOArPEh5SVMtR2UgFbffVC1lOVvokqRgWCk7pXTDZ8wOUq9rPmL08Q
         yuMRtS8fB0noi1oQ+fTiIEf1ARlaxXAQ/oQIaCZEzTO06mMJ5GujNKTcyghPgJ6ggDAY
         CsYSdcI4FipZqAqCi6wnhKp9bAUpNB/kjPnfGVT33Ev++ni4PWihwbpmcG++Dr5vlS0Q
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703685400; x=1704290200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUl2xi/xiQwmIqstWV5ZixrBp6V83VJ5lBIARJUU1Ng=;
        b=hB27+C+8IC6nPe1fddjkoPw18UTeoXTqSoty7fjrTy/uGjtkZ5Y2f7xvBPFH0k/RvT
         wdrj6Jaei4Wv9lMSi26xBxnJY1yc2jc18rxe652lI4b6JvvudkVFAKH/ifOYRt8BCMe6
         RI3z05FzjFXzta6Ihuf+NRPKjejsv3EbFFeG/WQ0ZPoo6PZPD1c6ns1SC0j2KENTj51g
         x382AuAXLB+LkLzKiWCRdJVkUf8MqTDy9lDscCidxbK62qlAm1LLw+ukjpilTFKggiI1
         wL4AWEAE0B+942MiKGPwgVXxp9v9otzIn0StkkuBny4TAoRt/INbeub8RlAHCZS1BMbN
         9RXA==
X-Gm-Message-State: AOJu0YwGck9RozPhWwODYCvP9iBPw3aYchbc6HLGqxti6YPd+XLFU1M9
	MCt6hT1edsOdy870FULr4dQ6tfWyXq0=
X-Google-Smtp-Source: AGHT+IErOj2g2Q3e7SuABt7Iq3oAYC0ehW1RgJJ7mHhiSzHkrnJy9Ss+gmuE4ETzLqaoA11e2LT5aA==
X-Received: by 2002:a81:4e08:0:b0:5e7:a908:61a6 with SMTP id c8-20020a814e08000000b005e7a90861a6mr5527384ywb.85.1703685400228;
        Wed, 27 Dec 2023 05:56:40 -0800 (PST)
Received: from [172.17.0.2] ([20.172.2.97])
        by smtp.gmail.com with ESMTPSA id n82-20020a817255000000b005d3b4fce438sm6417451ywc.65.2023.12.27.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 05:56:40 -0800 (PST)
Message-ID: <658c2d18.810a0220.e4fe.fe9d@mx.google.com>
Date: Wed, 27 Dec 2023 05:56:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1040371619111179357=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
In-Reply-To: <20231227132927.3938396-1-neeraj.sanjaykale@nxp.com>
References: <20231227132927.3938396-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1040371619111179357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813051

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      28.18 seconds
CheckAllWarning               PASS      31.07 seconds
CheckSparse                   PASS      36.48 seconds
CheckSmatch                   PASS      100.20 seconds
BuildKernel32                 PASS      27.63 seconds
TestRunnerSetup               PASS      438.20 seconds
TestRunner_l2cap-tester       PASS      23.06 seconds
TestRunner_iso-tester         PASS      45.98 seconds
TestRunner_bnep-tester        PASS      8.20 seconds
TestRunner_mgmt-tester        PASS      162.81 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      8.75 seconds
TestRunner_smp-tester         PASS      9.68 seconds
TestRunner_userchan-tester    PASS      7.26 seconds
IncrementalBuild              PASS      26.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
45: B1 Line exceeds max length (90>80): "v2: Add 20msec delay after enabling UART break, cancel ps_work when ps_timer is restarted."
46: B1 Line exceeds max length (81>80): "v3: Fix build error. Keep a common delay of 20msec for UART break enable/disable."


---
Regards,
Linux Bluetooth


--===============1040371619111179357==--
