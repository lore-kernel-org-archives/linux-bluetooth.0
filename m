Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775213C3D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732255115; cv=none; b=D98hdVQ78xZVesQImV6O+cy38MsG+SogJknlGrcFnyyoArcjO7ZjPXGjnllArgJ/3VIxZnHmrLdJsvoA+yeGsXUGb7WDISLMr13OMCvhvrVOSkBBOmbMaVGaPp/JykKjODHkzFSgOFzDUeY1F3/iVBBD11V8w4sYmQOVKyk+T7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732255115; c=relaxed/simple;
	bh=OZ+p/2y3iQ5ssb+6ND2C/IbYxXQuPgKWj/UQjPF0FCw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tFtjH2XZ0ATFEziNGHW1+Hx0X6HG0M4GI0vtsBqWJxQTNVv7B+sEHWMdueEjAEScA0eFe+7CbQHfIRdlT1zHZWXQfHPyAgfg6gaKESEjbiLH52XZZ7Rr7++nbzzmoEezD32SOdFDivwayEhfXnyWpNVSJpjhGZFcrnHkxrfBcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+uifC/b; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+uifC/b"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1601e853eso105060885a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 21:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732255112; x=1732859912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b5I1c6kTNEGqxxuBGw3uE5uNtZ7Dq6gAOJclv+JEoPY=;
        b=B+uifC/bPjm6jD8nQ4P5UvWsuH2gdJ3bFv/9+bnv5SMPLe1ql6RMyOIYYpJMwC9dzf
         6eOemtX9luFc/OwkMDSxmlLsYAbf6pbN2knJKnfA7A606ysDGhyGk5+MY0dr6HAOe41f
         thr6TiP7fZ436JGhmhGzHF2gFFlac3f3JD/vbrl+9WvcT8lhSq93cglJq1vL/4LKCBMl
         6CTke3Zr6ux6eYAYpIfvwtYkxsRzRZnxGT4lunn9VaWdpCA1Lnvsrq7cRFKgnJLFM3m2
         v8lDOAjswOEq68uJ75K6vVFKFJ78t1S1mjVkiJlvWuo8DUObpCYc59SQ1bwvRNnJezrZ
         ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732255112; x=1732859912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5I1c6kTNEGqxxuBGw3uE5uNtZ7Dq6gAOJclv+JEoPY=;
        b=rp+rKOSuc0vsRZ92ADyfJzPRFjKgqxA8li+YosY+rv36TIwY47PqMWCzqbAmG6UUMf
         g7QLp/or79GcUsy2DaeZAZnIlH7buTDIWCbP7B7DdL9LpZz1pROJZcMztTknLcpF0kGI
         fXkvVTkEO4QQ8EYSGMDKQJE78e7QPIaJ5qezEWv6BYSmYCOUrcgmeA2lMM93hxb4dITx
         ugODpzWbVT+HEetfP48lL38lJK4EwXQs3imlzInORYt3IyNqyy5fnl2WajH6pMTn/Aia
         BWJWp0UaK+Isss0EsIkt9fHEwZ3u0zzaWvxnQZsRzbDij/7CAFXJHn7G45Uf8EYgExAt
         pxOA==
X-Gm-Message-State: AOJu0Yz3vBDM9rezL+MFC/Mxhrpkz+9Gzm3KFwQJrd+rprWw4ob4H0pA
	z3c1+k7AUZk1+u7bqk+o+ppz1rG+Wdl1FYakDnH9C2URPf/y8XmGDX8GYA==
X-Gm-Gg: ASbGncsqFqyFVWVEDEEDAbxhZC7VEFUaH4pXPNUco9ouIh2PnrGmgZZHbwRKUkKtJs3
	UwBhFptehwl7zfZ20mZYu/trtjUWfqHcwwvK6HeGyAKBVxAk6SXu9QcYnefTv4I43mRqkcReUux
	QCX89OWCGme2vGMoEvTHUekTlXcNFzqebWX6yjqKlB0fCLe8bJB/85bbeSrWxm6NEi7crQAONH1
	syS9LXF26F00YE9iXFMc6sqYof2n/RqmBa/r4+H8uNRgKhRVsLnJy7I
X-Google-Smtp-Source: AGHT+IEPpijir9k9G/oezUBGoA7tSW6PycD28j/VPfSOr85pm3N0Mfzf5LWLwSRbVRsLtF9xwtozPA==
X-Received: by 2002:a05:620a:25c6:b0:7b1:5143:8d9e with SMTP id af79cd13be357-7b51459ef0cmr171636985a.47.1732255112245;
        Thu, 21 Nov 2024 21:58:32 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f91e1fsm55176585a.24.2024.11.21.21.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 21:58:31 -0800 (PST)
Message-ID: <67401d87.050a0220.21ac84.1ca6@mx.google.com>
Date: Thu, 21 Nov 2024 21:58:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7874943698226694816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, j.alan.jones@pm.me
Subject: RE: Bluetooth: btusb: Ignore Nintendo Wii module
In-Reply-To: <20241122051947.716313-1-j.alan.jones@pm.me>
References: <20241122051947.716313-1-j.alan.jones@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7874943698226694816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911667

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.65 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      30.46 seconds
BuildKernel32                 PASS      24.66 seconds
TestRunnerSetup               PASS      435.06 seconds
TestRunner_l2cap-tester       PASS      22.33 seconds
TestRunner_iso-tester         FAIL      38.74 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      123.46 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      11.66 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.39 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7874943698226694816==--
