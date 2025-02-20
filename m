Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890E286298
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055435; cv=none; b=FA3yBbcEs98ENRkMv5qKZNLuFpGbut6wnapa2zDU1keL9t6PdnDVtl/a8YhQVeOKST6AMiYZenmhopz/q0x6y3tedCd0srAqHUXfQ6WDaZpg8K/XLP0n3Kwnft0a8phYcdEazSe3Y/ago37rPDxqtPKIMlSNUFxLF/YPgm92Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055435; c=relaxed/simple;
	bh=E91XPZK9dpLUfjUaFwG2fHQH5KfYtDCeboVriq/EvFg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IDa1Q/A4FOzaV2nfbv55RJF0yDFOdYQNvkSX8bSYjU0cT8YP9CQlWCOU+dadjDnWAE4mrFXn/olh+DhJR2HUBQdKnbSjIworxPxsQRVq6ecoPXoX2RKVyh7yDihrY83wJCkmwxYLbNQKJJuqo0c4BLl1/pZO/MQyO20fk8ar8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSRFPmMk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSRFPmMk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4720a115d15so15909381cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740055432; x=1740660232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xOYLuILWNDlMd/9j9bjdRjBd4YF2GKj1EqV6xcuPFR0=;
        b=SSRFPmMknnY0Eb3FS0ePcqcIZosJoGc6V4yY7mOh3Q2dlZNQ+FDj9nyla5ge4vryYr
         nJjCX+ykSm9xBpTC2DYB8CqQpEnaJenlb90wJ+j723bySNOIv58DQXMhsHYeK4Z2lLKy
         +9zfhIEhjw844q1+o4kj1Z2RRGecE7sr/12b0Wg9ZY3odcaB8vAx2qIAW15axbmCELwZ
         JB5jEWi9b+3FTRSk+eRQ/YfAGH9BdsgJahvXBhpGkt6JcH7nQzrruxFzcJwQd4VqGRDq
         mjaYN+U84CFsTZMnRtbUph69dUklg12aoVI2Wh0L0Z9FGKBMgu2Kwo0PPkyQ+3r+J9we
         gdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740055432; x=1740660232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOYLuILWNDlMd/9j9bjdRjBd4YF2GKj1EqV6xcuPFR0=;
        b=MnSejpWMvRfrnT1wW/mig8/2qApz68Sl6mdvBKdF+G5Gm4JW72gogMF6d1yZRyObbk
         hnG1UNvvGuS3BsRbVLhrc65QLxqv2u9R6kkmdflPFzL4+Cow8D1WyXDxfJBfAK5lLo1w
         zCSO/77VGpqd9lKoJFc2JycVHW4VPj6gi/tr9GMgUJ7Ldj7jNACZiNUF6XYZ71dpbfjR
         0kAxAszsRcZ8zwYuTddZA9MxCXPogvR4r7OON0VFhJJKH2OLU56fijov8p0jn+KLT3uF
         /2xVDJ9IKCobkktZ1zbdAEcB4qtK42tjLX1CBDL2sjUnBUP6OrnhJvkqREXM3SzwaETn
         RGcw==
X-Gm-Message-State: AOJu0YxvsoxjXHdyc9C1YvuzvAcrrd+i/SJhBrWxi87T8o5bGkD026N5
	tNTS7Q9/TgwODOgMGRfnm+IlUy7WWaoyIWtI4sVbBp1xKq3xDDZG0gS0hQ==
X-Gm-Gg: ASbGnctLevdXQ07cJSK5xkWv9Q+cgouJNUAZRbejx1JkCw1iruf+wzwY9SWVxoe3c7n
	QEiWQZ5TVDLu+jaY9wR08QjrMxPNwY9voiYnTwEsvaL0zY3HCks97OK+vzFcnD/9+lIv4M4p3rp
	Ve0nJO1nZEnI/ZVeAGhx1+sItXL9INzVFpEkQn43kmfZStMd8Y6e8SfJP5aJoN87Ikb2Q/rQcPi
	58YPwjWynYKiaLm9pbLOx/8uuzg4QZamfC50BkdnaKOaxe9XXL5U4fJVT85xBmJzp9Yxzf8sVDF
	KIHe7IUwdOES32Ztn7dUBwU=
X-Google-Smtp-Source: AGHT+IGI/ICTHmI0iKd38CyiVwfNRvcfQz5ug+VxEE6vQiPMlvKC+tyBAPCRDI7La6JE8NyICV8KAg==
X-Received: by 2002:ac8:7f0e:0:b0:471:f43b:4831 with SMTP id d75a77b69052e-47214ff4af1mr33894691cf.3.1740055432103;
        Thu, 20 Feb 2025 04:43:52 -0800 (PST)
Received: from [172.17.0.2] ([74.235.134.185])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720d4340f4sm15702141cf.65.2025.02.20.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:43:51 -0800 (PST)
Message-ID: <67b72387.c80a0220.dd1f7.72c4@mx.google.com>
Date: Thu, 20 Feb 2025 04:43:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0419816194666094980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0419816194666094980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935985

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      0.47 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      27.61 seconds
CheckSparse                   PASS      31.31 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      441.12 seconds
TestRunner_l2cap-tester       PASS      21.47 seconds
TestRunner_iso-tester         PASS      42.44 seconds
TestRunner_bnep-tester        PASS      5.14 seconds
TestRunner_mgmt-tester        FAIL      125.21 seconds
TestRunner_rfcomm-tester      PASS      8.12 seconds
TestRunner_sco-tester         PASS      9.85 seconds
TestRunner_ioctl-tester       PASS      8.74 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.58 seconds
TestRunner_userchan-tester    PASS      5.20 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.159 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.170 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0419816194666094980==--
