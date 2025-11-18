Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9A357719
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478428; cv=none; b=Jf/3jtvHYlglxXnVXUyQSbwc85o3IIUF9UkPrfzXR7P3aPrU0l4VO86WrGS+WLh+EdS7IsbCMwztf1qBHdXdYYEP2+xEe0/yEPtQw6p8tntBjhYw7fXKjVp+xKCgtvXxYcz6Cho7V7CXofuqk71x+G5bnxMEb+c9ep8WXPA9bFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478428; c=relaxed/simple;
	bh=nwJ4HFaNLziPQTEc3Wvdqj+9IA4XGktwub7UD9sYHAY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PVzOIfEZ6KwLmHtb7sJYlaHU1fMu26hgbGpsOYz9HL17bPNlq5zjF3tMYFWZnPHhHZ4E1Rj2Hc4vCZYfrfGBVRPYiA7L5yrjwsRgg32ZqarS8Gg/KZOCW0yMk+PL9V3Lf5Cxx8sYqDIqHJCw4TLIEm/VVeYO7mC4eXxVbG2XPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+EIaYrn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+EIaYrn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297d4a56f97so62198175ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763478424; x=1764083224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uw4EIvPa1ub8R4LR1bTprf6ampjosk/EpWqjrMAPjw=;
        b=j+EIaYrn7enDs8+95BcfEJI2qBve3XBjGe4oTlJil63WTa3ChZ5bO8zaWj/ezD/WD2
         x0ABIoL/mh5aOAI4LNqoEU8wUJb/uDCKJNHQwM5oucOSDrdMINPqmSgPVjwnuPevQQ/A
         ajTEEtHOoZkx2wpQez8kBYG50sTvWu60hUw4cZ9Hg4XM1ekNenMSQiIB0omOKnznbckj
         h3rNnyeSvAiTX0JVVQyUFHO23HEC45zvdd4WhigwK+notrT6Qls2QG/VWfsyT5iP4IcZ
         Zce+bigb4Km4dFm/FddO5WjQy53FjcA1Qc3rvFKzDPcLVLORG8zWMKZBkp3KOTqBuszw
         yEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763478424; x=1764083224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uw4EIvPa1ub8R4LR1bTprf6ampjosk/EpWqjrMAPjw=;
        b=GyRZKxNnA+VQWl0NAnPwALYSsYWH0oNqge5mbPkf6fdS9uFDKlDHBdSKY0oCM+uT4J
         SGMD+NksSPnKhaNs/M4HsKKLRq92WQenK+jMQ84kOLZfcL1dbjbDm768tUDbuZXNwKaa
         B6Afo9bhS1BE70oJYr1CN1ftd65fTmQa+dIy+bfCXx8NQNLfDo0A9AmsmRa8e+NGGChU
         qPSR3coQCwPcWi3HI/Jfqm+CFtjbtUnC3VV65YYAFj3Y6RPakgZw9GtznlVroTtDox3y
         Xnt2r3tqy+wWTqpYHNqepgMayby91EQ4oKuzrDfE8GWET5bB6JhgaZbUzlHbQDhASvsl
         PuGQ==
X-Gm-Message-State: AOJu0YzkNIXSJSYKq7m0wsms1nt0ponpZQZH7Y1/JVrXZ9yUWOcUfhCm
	zXbeXeP+g755WH+RhXKvj9HF0ujz+fMoCUYWsWyhPB+UpPrObWm0R3+edeCHRg==
X-Gm-Gg: ASbGnctjQROb2hTAwC548jdhQYRi5g43oGkGKT7NIV9/F0rW7LWaU06ML7qmFRZuCxS
	VLf5wv92/lbjRYpdQisNEJ8/IXljURI6B1YTVbfYWfkpXYvciIgHhlyq3qINscPbraDSpW8VHo+
	rrnz9a7nCmzubd3bt7+HgXEZD1gCoYHykk9yvyc+0qeYYuxVQD26JawDZR5WA7FP96JZPwq8jjL
	6VdAzwuvz+u4ee736CwXvsBnWpgmKApopRxm+cvX2COi3rjpzKWvpmtFb9a4+qPiVay8kmZEkHQ
	J7kyYCfbaXI3LgErzhJmNzLbeMKpJ27gPguTcaF1Ma+jn8aTyJCOxCOfTMOSkWvi2UCmDOw5RaD
	wd1X3e3hrjsNZDb2O5Bq4+2mS2jMltXYzmEPQBu0R7jq7q6yrhijnFT/QsowO1pScjJ6a0AYhOr
	oYKyUM1BSxOOZ050kJCJN0eSF/awX0TdY4iO6vTw==
X-Google-Smtp-Source: AGHT+IEEPMDiQSx1j7gAGAul6BgIwxA/n9J43wQRP7L3dXpBOK+TqeTK8NnR63EW185oaoIElHuYrw==
X-Received: by 2002:a05:7022:e0a:b0:11b:bf3f:5251 with SMTP id a92af1059eb24-11bbf3f5610mr5231620c88.16.1763478423711;
        Tue, 18 Nov 2025 07:07:03 -0800 (PST)
Received: from [172.17.0.2] ([13.83.166.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm62131593c88.1.2025.11.18.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:07:03 -0800 (PST)
Message-ID: <691c8b97.050a0220.1a638.61a6@mx.google.com>
Date: Tue, 18 Nov 2025 07:07:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6078547874905157373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
In-Reply-To: <20251118142025.1982263-2-neeraj.sanjaykale@nxp.com>
References: <20251118142025.1982263-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6078547874905157373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024897

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      2.65 seconds
BuildKernel                   PASS      26.39 seconds
CheckAllWarning               PASS      28.81 seconds
CheckSparse                   PASS      32.64 seconds
BuildKernel32                 PASS      25.57 seconds
TestRunnerSetup               PASS      564.06 seconds
TestRunner_l2cap-tester       PASS      24.55 seconds
TestRunner_iso-tester         PASS      83.26 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      122.95 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      10.58 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   1.14 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.173 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.132 seconds
Mesh - Send cancel - 2                               Timed out    2.699 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6078547874905157373==--
