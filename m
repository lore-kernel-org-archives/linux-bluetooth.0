Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EA1547E7
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201422; cv=none; b=bPoZAPpOJ2Oo6yP5kwdmYT3dyqSwRf4MhACpwV4VcszH2+peo6q75lMzbKRWg9L/0sJmyh7D6/SDOJKA8hEfc8wmuu8Gm9/gwrLKQcWM3m/Fj+kiwM+KsSrfufVT045i363VQ8lhehbPFaF4c2mEKmcojAHBWd1mc3O2lMvWLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201422; c=relaxed/simple;
	bh=DNsc/ztCx2aWJDqQYK+pNJiQ3C0sJil6YmLt+8VWm40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=af6Dfgx3WEvoZPEyrqPqV8cLQv8wjl7axxOfSU82pMc3oucWX9rakJibqVm00QWcYKFWcBioBtktWy2Beiq9TXn5D+7/U/7dY5V7Ztyzj/SlVMT3hk98IblKrhvedOfijcb33KxtNzobHE0aKHhSx1B8sDIR7KOoi+JDyJ9CXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ1Wc/T+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ1Wc/T+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so16364606d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748201418; x=1748806218; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PQN6OYsCAST9uOmwoOEAU5Rik0kGgSnD2h0jbwLhk+o=;
        b=HJ1Wc/T+EzqCmiHvWFA6DaGYZ8S2MdR8oH8vy1M12XL0gdPcIXthx3eDmCethBc6sK
         kSJ1gxsQbMx8YAPUoXRLlCSSU9BznLFYEnakc6KgV0XrLpAUtTfaaHXHEKgInLpy+W3l
         0nDGjzTk9BTQIOph3EIDSRLikuow4I4Q9iQ+9YbTCWM43VUdeQYajJYsGKx+NM8QSSB6
         zJmZ/rePrRl+QUvnw6atJ6qfgG7ul1wTNQLUVmar9rcyy8KG63CtWJF0g3DG+IdOv4EP
         Ixvc6Euw/fqXOy/qpHf0eLeEJVjWwW7NqerLqQQsqE4xL6oiXwf3Ci3/8cU7dlPzQk+P
         zZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201418; x=1748806218;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQN6OYsCAST9uOmwoOEAU5Rik0kGgSnD2h0jbwLhk+o=;
        b=TyppOm7j8Y0aaYlPhBxLHW9XlobniYfwlWchML4SCeajBheX76tQQMFaKU/Yl1pnvC
         6rH+A46PKZgi++wtvVVi5ZwO0fp+rlVIvyYvf/OkIs7GP7KXe3VjMYXoyJ6hU9EYDva7
         KKt5yi2j93n4jNgL/OKDfg3Tf5AWga8GfKusfiIEPr+L487hX9GWzs/reXIQwwSZBCVL
         C3KSFeSb5YtIjraV8U4dcqI7ZvDNUgaXbYgovlOLc7VscS9cUuTmvL7r0I+Xu8rB8wmN
         NdduBAGNfjA31ydMiByvCV/R1alHPJ0I5DQ6u/d/0PE1+eEy/6kptdfFfYP2vTcVyegf
         W4dA==
X-Gm-Message-State: AOJu0YwpcRtGmImEDN749hLwjhXzeLuYHkGRUXhy6wHMp6ndk5asRxPh
	BtYB2zCjRQMwS6sQHGvFSu6NJrn/SDDZbb6seHjA1qF8y1lcsUhkOFDSApSSwA==
X-Gm-Gg: ASbGnctzdq6nm0ZSg9QLmoraSIULEzxNbp9v13wJa3ZQ4RgDuYnhHBeU+UPrW22y0dC
	hhApwRauT0t3mAEeA/qBma5rxxiTAwHcisLbQPBGHE9swcLPFZGgsDRTFbJmebAJ3DbZd0cs49Z
	sChugxLaiMKqVnIBzMTYekeLufWxt86VVZ3tPb+8xRnhga8fB6mEEjvsAjNlBCapAhrnWnjuWKY
	Ah/DjrHyu0YKOpNzVHulOa4QIUi4ChUOznfFqfDlMVj2ubeAMc72lidjCqwWlQNNzoRubQ3br9P
	0hZAuWN9LFlpfm4SWdUADyIsC6y03A/dELucHXQGEug9GRYSG7ne94kh
X-Google-Smtp-Source: AGHT+IGCCr7RQPQq26gak+XxGZlpkMCLYnNHrSxLH4/cPRAowrLPI8xCZrNiv5V9qstGrJzUasPaww==
X-Received: by 2002:a05:6214:5198:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6fa9d2c3b62mr118884586d6.15.1748201417812;
        Sun, 25 May 2025 12:30:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096585dsm143394566d6.83.2025.05.25.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:30:17 -0700 (PDT)
Message-ID: <68336fc9.0c0a0220.1b8b84.2f34@mx.google.com>
Date: Sun, 25 May 2025 12:30:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7555542517588974128=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: Bluetooth: btnxpuart: Fix missing devm_request_irq() return value check
In-Reply-To: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
References: <20250525190020.27286-2-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7555542517588974128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966267

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.25 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   PASS      30.35 seconds
BuildKernel32                 PASS      23.83 seconds
TestRunnerSetup               PASS      451.98 seconds
TestRunner_l2cap-tester       PASS      25.04 seconds
TestRunner_iso-tester         PASS      41.49 seconds
TestRunner_bnep-tester        PASS      5.88 seconds
TestRunner_mgmt-tester        FAIL      132.13 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      9.67 seconds
TestRunner_mesh-tester        PASS      7.33 seconds
TestRunner_smp-tester         FAIL      10.75 seconds
TestRunner_userchan-tester    PASS      6.03 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.189 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.229 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.160 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.181 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 51 at net/bluetooth/hci_conn.c:568 hci_conn_timeout+0x14e/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7555542517588974128==--
