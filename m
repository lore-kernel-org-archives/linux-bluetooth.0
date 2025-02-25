Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75923267F79
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484465; cv=none; b=T24AXBiCByjEJ4VVVq9Gn+bsoqBkASL/A54l1IftKOFJO4jX8oQhbPIJZcdP1MGFvJ67F9cqdRixmbY0TlAzxFJZ7G2gkcvWSWYfYXHQV3EdRxrnjGDqvLJh7Mym4IKJYlspQ++v+wdQXnhfFpG0+P4M/0cxPN3j+fbFHIhIAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484465; c=relaxed/simple;
	bh=jCHYqjROsZFhTaKv9zEu0VmFEt3KMk6Dk4ODmMk1AQ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QuGQYmwG+7RgC4HPpKb9HYqRahgkUyDDViUUk9H40NNXlbODp1HUHOhABYEbxZEDaKcAb4keZFy2UKztgVhUeEh7kuEdLz8RuwdwxkqAb8v2Ri0zqlk3NFv4Nt74OJ3g5sjtwI0/3ZswTC84s1T/V9hr6D3uD9/TAuOhhkLdWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbonAb5E; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbonAb5E"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so48927341cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 03:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484462; x=1741089262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0vd5aHI2pRuOHOftEBXJ7X7wnqB+nO4R19bIUoi4eDg=;
        b=nbonAb5EORZRtOzCUGq8CqyLHDaMB6/rBmvTYRsI8DF1AJHorCl4bEiRoL5tWmtu/O
         O09CF/IbkFQ1jBcGtrLL05TNtrh9EHhP8TRHK0TyZ+5czJlPGQLqnDLsegDRz55EqMMT
         MrV95xX43LKp3iT4kBpRplm+Kmpuqri4dtjH9sSHyDEYnygbJ9bhFeYCXAKrgEp1ZbC8
         jdiXWdoSZ7KO5bgW9mGKQ8UovPAlP7ZEbwrjcX/a8loB+Fj0jh/QSsjiEzO2EF9e/6yF
         BB6jzIehjatAtuClvyyS/BgPiaJlaUStdTBNr2nr/1Dwe4JW9zi3e3QnabpBbg/yLn03
         FmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484462; x=1741089262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vd5aHI2pRuOHOftEBXJ7X7wnqB+nO4R19bIUoi4eDg=;
        b=uuQhmHXj+JVM8jDDJ14uWTXXVUxFpUc9cYve94EtZL48sNJi9ILe6re82jvVTnEgLQ
         vwMeHOhipsv3f8kygb6FXxTU3f6Dr5cioSHDbPyt3R5i2ej8CUzHJ7DzCzyabREW64RP
         Iow0vrOO+bsvpVc8ziJwsu3ctTIKHK4oudc2uRa2Lls1h3LJeJjfWEfi8SqSwwtvyabC
         WVaEwUIbailjgFiL1/YCJIQQdtxSHk3kgApRjCMl2slJGJR9O4g4qER9qXhGX73LpUBc
         4K97zuAt2okSt4C6i6IL+HOW5ufYo5nOYdjT3TLPQFiaGH1/uKW+rjjes1+kp+WOMhRf
         YF3w==
X-Gm-Message-State: AOJu0YxymoDvt5SJ3xqUeJ46XJZ13RbMtrIAfbAg0kqpsm9IM0QRsWKK
	mpDVNMhJkAMaV6Xgtm4Nft2AmH9iBSDH/hQG8PFVPEirYqQwV1ASM/0gbA==
X-Gm-Gg: ASbGnctp/zOYh7/7v8j9w+NvAg1MfExh/uk1Ct3U7GNqGjuwc5Re8e+HKkHFm0bCx+V
	B3XMTkLNc1hzRHrTuKNayVgqTRwBnXA6//+emV1lSjvkh5yOQmaxPVcmzgvc3EelPksBLxDZmmi
	Y48/WD6dr+nuu92T5bSesIWuUDo6bAaOF+VokC6rbVARrO3LIkEWP5qbp/TRIuRCNrUtMltAEc4
	8bwK9lrCng35gm+vXNjkLgdoHFUGlSq0H8jnSdzuhNZGRGVx1/HOFwfIvO3Yd21j2xnBoZj5hMp
	bcSkPXUw55xHkr78Nc0Q7TqC0exI8fs=
X-Google-Smtp-Source: AGHT+IGMj3EacRqjita25v8KmmHJcSKn9d9mm34/Tz7g0pr7FgF7CMcZg8Vyy1X5R4ycee82O5/7lg==
X-Received: by 2002:a05:622a:203:b0:472:14c9:ecf5 with SMTP id d75a77b69052e-472228c7e59mr220734371cf.15.1740484460620;
        Tue, 25 Feb 2025 03:54:20 -0800 (PST)
Received: from [172.17.0.2] ([20.25.193.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e22048sm9344811cf.40.2025.02.25.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:54:20 -0800 (PST)
Message-ID: <67bdaf6c.050a0220.1e6053.2e51@mx.google.com>
Date: Tue, 25 Feb 2025 03:54:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7580896031018688816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel_pcie: Setup buffers for firmware traces
In-Reply-To: <20250225114311.9514-1-kiran.k@intel.com>
References: <20250225114311.9514-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7580896031018688816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937476

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      24.46 seconds
CheckAllWarning               PASS      26.58 seconds
CheckSparse                   PASS      30.08 seconds
BuildKernel32                 PASS      23.97 seconds
TestRunnerSetup               PASS      433.40 seconds
TestRunner_l2cap-tester       PASS      23.68 seconds
TestRunner_iso-tester         PASS      29.59 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      129.34 seconds
TestRunner_rfcomm-tester      PASS      11.61 seconds
TestRunner_sco-tester         PASS      15.34 seconds
TestRunner_ioctl-tester       PASS      8.66 seconds
TestRunner_mesh-tester        PASS      6.42 seconds
TestRunner_smp-tester         PASS      7.41 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PENDING   0.64 seconds

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
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.183 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.152 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7580896031018688816==--
