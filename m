Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E65695
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725870; cv=none; b=m57v9qoHYzGIsBQcP/gzqbDJX+oDBt0loraY4uph7YmgUe9wsKzBCnrVFakoSFo5S3p/mEoBVhxZnKQWyu25yuMFsxPCSYEdBai0Dns08ao8XipfjRe32MGwxMsFMFn4iPAcl6/VKT07i5bIrQwIuCk2MlM6ZpBKiH7myNJI/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725870; c=relaxed/simple;
	bh=7mjl9XRQj1T1jvPEPx2FIB1CudA+yUuDfWpe2U6KMGs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yiz0j+T+MAZVURyWug9UK4zEoOGTTMsMJI0CQOMWOFP4CEvZUyY7Ylbve/M7PlrB0CJWIfIiWmPljy3fG8ac8n9rJ00jL/g5ghfpGKnIcBb6EtFt9qhlAizdg43HXsSFj2hMYJID/HpUCb7hQOsDuvMVAbKxn0gdwqWXU4nV6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP2rL3YA; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP2rL3YA"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8907f0b447aso6986966d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767725867; x=1768330667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OhNzlZBvq4k6EOt92HYb53/KqAiF4HlMpv1aM95cJDE=;
        b=XP2rL3YABsFRssuluxVr+fV8dMbmKMXgZlP3FYWpHVLLA1wSr2qNefRQErCzJAjPut
         tt3EpS7NUz90XblE8iG5AwflRVfQJ3QPUdTAfgxSDtTqEkcA8i0Ew+NNiuswGhsR/i9R
         qkTCsjW7rqA8KNyjeCb17aqob+kjVGIipaAbNjjpNEm5xGD2/UzsLFCFEIcQemH6tifu
         yyZ1b8CzB9wM1kCmdypoGY4ChMWgp6DkaB1dA6brvpKus5jEVioKQ3k/0rVxo6LvCLqx
         42+0UDmnT25+4Lalj8gfVzPCDTyRALf6JUbW0bkud7YsBeXWVSano+ajab20Mn3Wwdfy
         gjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767725867; x=1768330667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhNzlZBvq4k6EOt92HYb53/KqAiF4HlMpv1aM95cJDE=;
        b=NeYViozpSNvRqW94wcNCw4gY3XPtYBaU/oeTkFkyPfUj2PwVrhVta5JYtFyi1aXKtE
         8MggKjAJWU/Muuu+Hsc5gfYxEJAEG7OPkjw7MjJQjcmGdns9vXNraXkEbvkLOiBKTM5u
         AP4F8/6yBiyxsPrbBlvnGdmlYr+nkSAAozG9TBu3FKG3OKRsTpAX2jJQCZqADfSDDcQy
         aGhL7QPULy/0HOSVyLXlNm96R+GyZ31pZYxXUfD2jboOnDA/74fgUco0RAs0NK2MMhLF
         e19sKEwgFl4Dgi8WQ57l6MCDVeKfZKae8FqB+BIaaXwnKpq5o4j3NwmQL4CeszNXTrg0
         j3iA==
X-Gm-Message-State: AOJu0YyJ38DKUdoqahq/KNvDWtQvOGbalh4LCuPq6yE5ytnSZESLlcYO
	hE8HbZX9flYn+SxvzclEnww6MIJzEtKvuM4wsdiyEsgq+vXbnALDEWg57svlv1wf
X-Gm-Gg: AY/fxX7q3Q0PchCN9erwb6SQfgYmB7G+5jIBoMnwZY47979NWT9POeDUtR9cTbG61SJ
	86AlByYl12sEMB1mbg+YdxGi1Ou7Yty+4xZy5Bad49ixXbjhoFQkAh21ln1CGqbQc2hUSLmJ6O6
	eFeBJs1LJd5QfTHo7JEhpHFVj3kQ8HGbBmgAAAenLBc2ZQBhhN7zsyMWZfSAoMJkzagVp8mwC/G
	Y7JGghmzEjK55+vfg1ixRIN80HbR9oZBpNAfQ4MxhBgeK0N8Bm6ZXgEmo3b0IuTVWTNFysR66sX
	DKiyAqRYh0s62UQB4LrZ1jP1ORQzZ8iA9VnbxX7s4bUt9iRc1rJbgPHjc98aERj98LbYqFkDqX2
	96QMSUPcQ51gFv+ldSz7p+iey+D1BW/3t8fLSS+xghn8D5BUSNqMHxiR6mNEyu+zJIKyXd2+2pd
	F45MSX9/Nfz2j3PYU=
X-Google-Smtp-Source: AGHT+IGM9IlUGTg2diGRJuyZlP1qsFJuTQDSF7CUZ4GKiPvaKnE7eLCvJXG3QdBqFCGtCKSyQJusxQ==
X-Received: by 2002:ad4:5942:0:b0:88f:e9f0:77b9 with SMTP id 6a1803df08f44-89075ed284amr59033396d6.58.1767725867247;
        Tue, 06 Jan 2026 10:57:47 -0800 (PST)
Received: from [172.17.0.2] ([20.98.23.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e4262sm18447136d6.20.2026.01.06.10.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 10:57:46 -0800 (PST)
Message-ID: <695d5b2a.0c0a0220.773ee.7c73@mx.google.com>
Date: Tue, 06 Jan 2026 10:57:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5173100255201634185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, katharasasikumar007@gmail.com
Subject: RE: [v2,net-next] net: 6lowpan: replace sprintf() with scnprintf() in debugfs
In-Reply-To: <20260106171610.124138-2-katharasasikumar007@gmail.com>
References: <20260106171610.124138-2-katharasasikumar007@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5173100255201634185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039078

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 FAIL      0.49 seconds
BuildKernel                   PASS      25.75 seconds
CheckAllWarning               PASS      28.09 seconds
CheckSparse                   PASS      31.65 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      545.07 seconds
TestRunner_l2cap-tester       PASS      27.89 seconds
TestRunner_iso-tester         FAIL      48.79 seconds
TestRunner_bnep-tester        PASS      6.08 seconds
TestRunner_mgmt-tester        FAIL      112.60 seconds
TestRunner_rfcomm-tester      PASS      9.31 seconds
TestRunner_sco-tester         FAIL      14.22 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.42 seconds
IncrementalBuild              PENDING   0.74 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.166 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.994 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5173100255201634185==--
