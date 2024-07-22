Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9717BC9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631828; cv=none; b=Y7jH9rHXWDvznofV8VmjxeoP5QwAqZoM1BoUCRTABGvAs0mVIF8Z7XOmuGl1m29fM9zHjjfaves4T4gA74vRMGWY/RLohlRBZpmU5WMlxT0qzdmL4KDvRuDfC60vzqrYPOWZtdznZMWMasLiStvblxOVGil5lHP1Ue1pBflPxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631828; c=relaxed/simple;
	bh=gh6cVPbwLJq1a+1tuCEKc3UdlnNU3zX9G21oOCmdO7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N+IUtBqZWdyBoOWr2XYxuypkR0Via/V3wYU6/bExashjxI65V+isQSe9zGd9EPho/MbvGCGLqEtustsJBy/kTm0pbjtzxuVQk4lwCLQBcnMt9vYVU1fsqLxkUdaY46CVHrUrg3883CE1yi7NfWnuDF33rBxoQIUkCN2mlcSgE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZgbkBMg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZgbkBMg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f16c85da0so219320385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721631826; x=1722236626; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b02zZSx3eq3tHkmS+v/kqValvGb6AGpKj8nrMRt44Nc=;
        b=cZgbkBMgU8clyeyf+E9X4RznVDe/RkrrjQCJWiNUGQ8Z00hMb7ZaIpiX6glotMRcOP
         hSpLLO6++SfbwFUc/OL0j3fpXdKj0P0kTpjF72KN9L0GaKESVoO/48IpomHuK9poANH3
         d/L0Qp7xjE6Jm30aZY0sLXA1XvyPV0IG06VLilO8AyGVhTrqImN9sXA6zUHyvq49pNNH
         ZPkjvORNKuAdXTGFEwMQEBqO6rji6ToLZpbOj0LeACDXpMnrgNHLBN4Ub6PioLrJy1QC
         AL4ApGbNVNPg+lhlf5aBwDVUpf9brcTlWmUe8kSp1VWE5cBfn+51b6xXurq2xwnE5YGa
         wGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631826; x=1722236626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b02zZSx3eq3tHkmS+v/kqValvGb6AGpKj8nrMRt44Nc=;
        b=B+iURnkPmnK9gd4lhMBSdFCQusu0faPQ2875OqaDsuo2GRe6wok1vEgf5Zm+qXPxSd
         MakJk20GVd3FiNzzeQkT/lCpYQtljAnpWqLSBuAMI87ZxPWSrr4Hzxvl02TfEvLqMUPb
         AMVdwJSRcYBXB5y+ZHinBCHy334LmsoKo9PU7mcwpS0GWoTc7Jg/izlSRl340C9v6oaq
         7xpDczMWR5ZefdnOs9zMhKavF3AZ4MCHUDF7ZbmQ8GekBQSsw1ZNwqSbBr+HDtngV48s
         rvRzNyxrb+3DsfkWToqVQMLNVMOgyNSpE3yFVIvfZ7OQjul+apP6twGwm4jDtQtz6pzY
         NWkg==
X-Gm-Message-State: AOJu0Yxk+Xj3m1tgrrEUx340oF7jd78+lh4n7C/eGvsQzfp96GR3P4Cj
	WP2aU3/PkvbSljbyc1Md9Tyl71RMh1UVS09xQ4VI5So0RvpE0iOgwQEBv1p7
X-Google-Smtp-Source: AGHT+IH9+4zRLtM17rnEbv+bzbzCKsDiQwcwlk04+3HWWz2Aw/Gsf+5o2EhBAeuyJIEgM0KtrsZBNg==
X-Received: by 2002:a05:620a:f07:b0:79c:fbf:63a3 with SMTP id af79cd13be357-7a1a132bea1mr885346885a.17.1721631825945;
        Mon, 22 Jul 2024 00:03:45 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.17.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990781c3sm331768985a.122.2024.07.22.00.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:03:45 -0700 (PDT)
Message-ID: <669e0451.050a0220.405fe.97b0@mx.google.com>
Date: Mon, 22 Jul 2024 00:03:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2523023327501240778=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Fix function-declaration build error
In-Reply-To: <20240722062216.16090-1-chris.lu@mediatek.com>
References: <20240722062216.16090-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2523023327501240778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872838

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      29.78 seconds
CheckAllWarning               PASS      32.02 seconds
CheckSparse                   PASS      37.51 seconds
CheckSmatch                   PASS      102.58 seconds
BuildKernel32                 PASS      28.60 seconds
TestRunnerSetup               PASS      524.54 seconds
TestRunner_l2cap-tester       PASS      22.18 seconds
TestRunner_iso-tester         FAIL      41.19 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      114.13 seconds
TestRunner_rfcomm-tester      PASS      7.50 seconds
TestRunner_sco-tester         PASS      15.10 seconds
TestRunner_ioctl-tester       PASS      8.04 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      27.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: Fix function-declaration build error

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202407200904.hRqT3JKD-lkp@intel.com/"
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.215 seconds


---
Regards,
Linux Bluetooth


--===============2523023327501240778==--
