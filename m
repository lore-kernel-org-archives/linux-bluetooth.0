Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097E2ED159
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262635; cv=none; b=YvizboWbLJrVDtMjDBqY8b21Zv7xU7+NbMMRFDwWO5MXGlqnNxYSFcEXOTrnvUlfYTuFEGZ8rMC/Ym5nqB5ptlj5k6LnMdAO6Rdzw7PNO1R14tsxHxyWKJQAmwfkNOzATPV6USn37qgoxD7Ybu1sXXmIZR+Rq7/JxDSh0Mz7IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262635; c=relaxed/simple;
	bh=M9UmG8hftSMJ0QN4kHZsOozMvqFqtzio7A3mImL5fxM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l1SZOTxmXbzI0k4UElMoHLoYQapJGy8f5NoQv4KQw7j8YwTsIOOCkV8GdnyjHkXNq0JjMplpT6W5XISSe7v7U5D3agnD/tr5mNwCxAVJoUaz8KhLPeUni+/ZYi7/b3obOUbIqRuRQ34OsogOhmi+irPLg7Sp1Z4xXpDDRmlaxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmP/Vvdx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmP/Vvdx"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso10231486d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750262632; x=1750867432; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXTGRlvv6un0r4TlRuhRM5rIelhlrlzWnet2iPLCfLM=;
        b=SmP/VvdxYPMkKKZsII6UJD3nbFVbhPf9vF7G7wZly0rnTCqebVh3pws5NEbfDf3X8T
         ZWk6bVOJVGXjbCd6rayYmnys6DvWwc/lnx3+49IYlZb8tXKuHcibg2bi4pWCZiC33l6I
         RNVEZDJFkAcBYyeX0wCWO0+RS72q1A/tY+N3PQt6xxH6EBdGGXn9bzTdedWEGNrM5Yd+
         oCbQaXienQOHwWmjsCqONgFHVwUpNAOrrpukNZaSIEd0iimF6072hjrScB9/k0SRwz3K
         FDRTTHbbSAF8I/iAGFTQHYXBNfADEEVrdZRXJ8x6maQvFXiksgXAUhn43bRBNHr2prtE
         RvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750262632; x=1750867432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXTGRlvv6un0r4TlRuhRM5rIelhlrlzWnet2iPLCfLM=;
        b=OUMv6Omz9sPaeAN4+IT6qveUL3btIjttlRlaNnvE2Q6/+glwlbyKivzMA4fADohwBW
         +hH5dDWRv5U559X8B3sxb65WagQpp0aLWF4dd7HxVmt0CsHxpliyVYK0Bo7wGEEhAguc
         5X7MQ+r+Jnl2r1eoLnxeX0rQ6/35yjsy3SNQdfBg//7N2nDHBBac0xIyUJK7B9SecwTv
         RePLzcvmrDzPykPer3L9AxZx/S+uvP4oU8HSEOYyGUiLvbn9C+HZwJ2H6Q5WEGWX+eJj
         ZOoBB0F4jqNy1uVBgnQeyJErkQDf/JFPQAVU8DTo/4tPYEYtI0wu6yeqssrXqsokGxTP
         y6/w==
X-Gm-Message-State: AOJu0YzCbGOxJjXBZQ0peKPejeDnskOBapCNcRmE2hQVMIy0oZ3RnE8n
	sgLL0mWkquG9Xkt+HktZyF3b7DnIC3OabrSt0fSSR4NZR2ilMtuHTg/bk4dyTw==
X-Gm-Gg: ASbGnctnvI4YchfA/TKqEfcrQOmDzOTSWDWZnvYfmkWMbXQNxNru7GbuempbHDxtM3J
	XA3Bohl6XMA6EeyTOGowowzHtXkuMUtjezx9sT3inRaexnm86hvZ+oTY3I+0zAT+Q4FBsA5md6T
	mLeu9/5mP8S4EraugWQH+T/kX0g5M0wNSGZ+2YWj6OWjM97sTPe0HlqkcYf7omdIWvzQwNaDnrC
	EdztdFt3tZrOfnmtKzUctJYdNstnn2DmrEV8ej/14Iku4ajtP5TBmSkstZuqskPHKHf3QenjeuD
	eEL1vvutTYvgeFFrShUoFCXVNdV4C0dIb3w5Ym969irM2ynGePwBq0uq+R2DyJmQW+TH
X-Google-Smtp-Source: AGHT+IGRHVpCJCETx5UZ8bCChZ4PqwNuBP4oI4OvRtV3I8uG3idqem1CAYl0q7/bVL/lO6qg7KQ6fA==
X-Received: by 2002:a05:6214:4d97:b0:6fa:cd5e:f4 with SMTP id 6a1803df08f44-6fcff6af3ebmr1606846d6.6.1750262632384;
        Wed, 18 Jun 2025 09:03:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.199.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb4ed60787sm44569766d6.48.2025.06.18.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:03:52 -0700 (PDT)
Message-ID: <6852e368.d40a0220.d22a3.409f@mx.google.com>
Date: Wed, 18 Jun 2025 09:03:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8584470090141148389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
In-Reply-To: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
References: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8584470090141148389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973495

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.50 seconds
BuildKernel                   PASS      24.76 seconds
CheckAllWarning               PASS      27.98 seconds
CheckSparse                   PASS      31.53 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      475.68 seconds
TestRunner_l2cap-tester       PASS      26.17 seconds
TestRunner_iso-tester         PASS      40.34 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      139.44 seconds
TestRunner_rfcomm-tester      PASS      9.90 seconds
TestRunner_sco-tester         PASS      15.22 seconds
TestRunner_ioctl-tester       PASS      10.69 seconds
TestRunner_mesh-tester        PASS      7.81 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.201 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.175 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.267 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8584470090141148389==--
