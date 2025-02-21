Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C03FD1
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176184; cv=none; b=cpWbIoCNfUxM6FFb63JGRajonB9QjSzZXUYEyEjmyapo1SdHeM1YYF0tK9dFqna+FPXyDpfBhHWSAxr15JQuznUqkGwL9/2yMCOpiWGkujh4+XYiDtHd6F+/2kIanVxKGDCYlR68EBsRlf8h9FJIq5K6pU+EHcX7xbryRmWwlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176184; c=relaxed/simple;
	bh=eFKEdRaBoox7gW0mummLZaKGWfx7NukaIpBT3L9EV4s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WLGYKnwh1Kuw2+x+sYI+iaMobw1YuO/xx/zGkKu/Zvt6evSxwnQQXOQMwvJHQ2KMIRdLVzgtZiGs0crhY9HnST5AkbDhkf9Sjz0Ys1uF5xlLY3/Nxbz3P7R2e4APpgjBUebHkaRkgtIOykGndPwE24DwioXk3+YmG/JM1dIUIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/fHQy1p; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/fHQy1p"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c081915cf3so325532685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 14:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176181; x=1740780981; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lzNwf9NCvGQATt/MWjQDmL2jQkC5GPwjpWDrinQP4xQ=;
        b=C/fHQy1pp/u+KFi1D/FxZ55W1a1WMt7RSrY+p7hpdBaQs9HARvUT2uFawQgMlEuQZh
         pW3hql6Mcbo9S35Ol50YOu/8T/IlvIJtX0piVK7g78UjDObx8ysR4Rgvnv3d91O9LRJu
         bOQFnGXR4VMgwMQzKkHSk5PE6DvsZnkEj9SEsL+IAaAUDIRmgfqUXgSpatnRcZeFiPhK
         VtcP2UMFv6N/ojY4ev/HI1bICUzNhLm2bV2KovxjFh7MI05vtVfk4MpzJOSZH7syIKRc
         6CAG3nXqF/Lu5ckeJE/J2GZy+veu0FouNesIELRlU1Pb6TVRNXwzJL/c1+gyAEQ0e/BG
         mGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176181; x=1740780981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzNwf9NCvGQATt/MWjQDmL2jQkC5GPwjpWDrinQP4xQ=;
        b=E9aR+YWag9f5fj3PswcX923/4bJ0WoUsxdLFzkHTZnAm9wUjXMc2pVf29ToIDx+5zH
         lGc7EsecW3/UjmhI28l80+DGmMqYV2TVJRZAlmucin4U16AnCrBqZSn/WLQIXbdBQqlv
         TBgp/d7tieRnjGyubUCpmp2T2X+MXJJQ+38Xotam632eORDQH+3LgxE8lMfYW5SmafDj
         Fl42wCx8lwflR3jjwPRfXkE/6DiphgdYOAXhXKaRS/wW1OKX1rthr9oxd7+xo/cPzEBt
         g3a1g403FLND82mcUpvt9lEbmQxg00sPxe8g8CPpNsATnP1yYOHOxmjnBtx0ZR+Qq8qn
         +oqg==
X-Gm-Message-State: AOJu0YzfetTL1AbDAVphUq+F6l1XJR4D7eFo0ca8+NANLxycHfIMFEZF
	S6U8LC9V8dB03S7fA/jFTtPXZrom7T3t0giinUQgjFA11axP7GLB2m4ppg==
X-Gm-Gg: ASbGncuFa6a1jje+n18OhvCp/MFDh3fEU3DFfsocEoiQiclvQXp0xWlRg5JpF2zh5cC
	OJiPFz4Yf+5oZCceZjDqGUkXF8u8AMm5DA1BK/x+JyYeo+F71kU0uXqcYBmZF/LecnyvvXFDPqy
	u6JWoarVcSegaW3neeck8kMKyZ2eKyci+9giiuxzOZoNGT/9YfYhCVZT1OPyZMGXPp8zVpNcEOx
	gvelWo9lKl5V/Iq06T2Y6lncTpVd3dJNzRWImeIk6c22hB4zOraqnUtsBhwlOr3v/Gj0EnWgO3u
	JPFnrGZkj3DHBHEaHsE3MsKxpOvc2ZXm
X-Google-Smtp-Source: AGHT+IF8YXd605mIDZqY+azdTk0yEDSgoKxPkB3dqKK74C21bWiTBPmaK6UuP77lduTuwL2kFNqZ8A==
X-Received: by 2002:a05:620a:4045:b0:7c0:b018:593d with SMTP id af79cd13be357-7c0cef55fe9mr686754585a.39.1740176181313;
        Fri, 21 Feb 2025 14:16:21 -0800 (PST)
Received: from [172.17.0.2] ([40.76.181.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a1f089b2sm621554085a.53.2025.02.21.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:16:20 -0800 (PST)
Message-ID: <67b8fb34.e90a0220.2effd8.d9ad@mx.google.com>
Date: Fri, 21 Feb 2025 14:16:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5589522826914867955=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: bluetooth: btusb: Initialize .owner field of force_poll_sync_fops
In-Reply-To: <20250221213259.180833-1-salah.triki@gmail.com>
References: <20250221213259.180833-1-salah.triki@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5589522826914867955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936618

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      27.08 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      23.92 seconds
TestRunnerSetup               PASS      435.50 seconds
TestRunner_l2cap-tester       PASS      21.59 seconds
TestRunner_iso-tester         PASS      34.42 seconds
TestRunner_bnep-tester        PASS      5.05 seconds
TestRunner_mgmt-tester        FAIL      126.15 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      9.78 seconds
TestRunner_ioctl-tester       PASS      8.53 seconds
TestRunner_mesh-tester        PASS      6.16 seconds
TestRunner_smp-tester         PASS      7.42 seconds
TestRunner_userchan-tester    PASS      5.15 seconds
IncrementalBuild              PENDING   0.62 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.152 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.195 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.179 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5589522826914867955==--
