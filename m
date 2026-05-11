Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF17477E58
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522709; cv=none; b=lUT6S56a483ByJCIbYLRGuCZkrC2W8z7gLgaEr0YYy8I5B+fw9/2TKimRLIMb6ExIIn4J15m0zKyk5f5aGk+SaEbzOKoVUA4Yt2X+IluvJKTfrQQN9Js9VBzlzjce2/ZyGxXtm2sDTpgcuODMC2iPzeUbRio7tia677z1CCN7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522709; c=relaxed/simple;
	bh=aogPCpuA0Z6aHMOimrPha/CXm/UaydJtnVQNBBRx7X4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZ6Oxnj65xrbW4+uLXAW+xmC5rGOR1h/p1/4afnGoSNN1xjfE1Fv1f8amnRnc4V4f0KpPuUsBgiJXQLwqqLWiBbY16Iu8E1UPpFyKADW3ccYh58LhJBk144eCmyhd1WHx4vpvNYRcoH/8NPbzIQ9xCDYAV5TYFkc5cyVlO5ElKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0qT3Vzz; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0qT3Vzz"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so6948255eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522706; x=1779127506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kel1WOPf9kJduh6zDYDC+xatMH0dry7AViFL3I4Sv6M=;
        b=K0qT3VzzD3rpUk6OpKAPRqDOxQZuQi4DT0NsBs4ntnj5GoO+RLBSY9c7lJDmAi2x0Y
         HsW6jynOiR8Iu/GgBfZRkbGv7QNunuEgKHU2lvjfezJGggc08IUeem6YLXGxCgmiVXA1
         XvTVITPF0bx98VRyc/OdpH2hhdjiemJGYNe4gkYbQOeCPpptS+VJkwrGgjUEJoSjsAiG
         KwOIxIyeHzasiCd6BxfKsAIlHtWPzeGZbCPPH4tR7/PFsH4ZDXO5xUjA/CuDjiKe6gUZ
         d91SP213V/h3pJDX5XKfwvQTBRbIu3K2Do7edEYBdptznUdtArJPMjEP7Dr0WBVowUs0
         XqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522706; x=1779127506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kel1WOPf9kJduh6zDYDC+xatMH0dry7AViFL3I4Sv6M=;
        b=AsVItiXjvRENyU7ajAQ/w+sXcJhy4jn+hf60WRbod4KC9YhHLi4ZgFoc5T76wBXjQZ
         K8x9XCp+r2AeX23algFHdOb62qzyARmVgweixcm6Gp3+cdH8GLwMNrE9e/ASekuOVSLI
         y1POSbHHTceLF9abwGOAZ/8SpN187N80Ih4LFL3zG4mrTH36gQg2uW/kOqspzWV8oBox
         1mZ0KwiYFV3nQWnzRZcUucgSIUeUjLOFxj7oGYKBXyssKEM0drK8wT4FYsXLh5kh82EG
         nwgTmBxScK0Bf2Dqx61Mku0JwaD48VWmTf3Xe0KW/UHGCTAagLxiieWoTQItv5RPy0gP
         5Lyg==
X-Gm-Message-State: AOJu0Ywm9oIfYNhsSsR+A27USOMaCqJTl0q877sUUTUVfoMchwecoVaT
	pfv6DYiVIlZDEb+RlL/oQ2kk+wArEPZyO5TBwm6IeZELUGXRhvNGfGuEQIx1Ow==
X-Gm-Gg: Acq92OFl1ZNxryh7fEV4+zkQ3XGRJtqcKT4zsTKql94bdsm7Nb6flD1tY00VPwc3GVd
	Kb3D/IV3xRNkzlEpF8KRYhyIevgqfghZuBftTL7Iwkuwfrq51cUU72gxqTvuHklq5RV1WpnGKFu
	C8bS7OXa0l0r6uKdeg35cBNPaN1ZQ9uzi2kMj3EfwupHSSFzWvqZkDVPVtEG64E/9nuKC3JjZen
	ofNcEG/OepnRhUfYyV2YBHI851MZV4oL2O5VdeuY7qyW4tYqyqf70RktRm1BgR5jL7YwOzJYJdG
	To3duudP6YvTQ2cZVD34fazIF9lZzxXa5lODuhVwzXCH9rLWUXcxpqBdAacdtqyz5AARMjpbNen
	jjTDd1BbNOocQi2AYouBZy2NQmky667VrPqd1iNXotbWG+NfwvLew/H/f4vo+08jB8yrdS1U8iO
	isWtKbmiweYAYbHweewSLkqzTwUzAYVJj/sbfQnFKX688=
X-Received: by 2002:a05:7300:8608:b0:2dd:6937:79d1 with SMTP id 5a478bee46e88-2fb3e7afa69mr5247869eec.15.1778522706400;
        Mon, 11 May 2026 11:05:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm18205632eec.6.2026.05.11.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:05:05 -0700 (PDT)
Message-ID: <6a021a51.050a0220.11fa50.6835@mx.google.com>
Date: Mon, 11 May 2026 11:05:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8971979075087559548=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
In-Reply-To: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
References: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8971979075087559548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092854

---Test result---

Test Summary:
CheckPatch                    PASS      2.15 seconds
GitLint                       FAIL      0.80 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      25.08 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      26.59 seconds
BuildKernel32                 PASS      24.63 seconds
TestRunnerSetup               PASS      532.72 seconds
TestRunner_l2cap-tester       PASS      379.10 seconds
TestRunner_iso-tester         PASS      601.56 seconds
TestRunner_bnep-tester        PASS      19.56 seconds
TestRunner_mgmt-tester        PASS      2024.23 seconds
TestRunner_rfcomm-tester      PASS      63.47 seconds
TestRunner_sco-tester         PASS      141.37 seconds
TestRunner_ioctl-tester       PASS      133.62 seconds
TestRunner_mesh-tester        PASS      60.51 seconds
TestRunner_smp-tester         PASS      18.60 seconds
TestRunner_userchan-tester    PASS      20.23 seconds
TestRunner_6lowpan-tester     PASS      51.88 seconds
IncrementalBuild              PASS      32.90 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
41: B1 Line exceeds max length (107>80): "https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/"
[2/4] Bluetooth: hci_sync: pin conn across hci_le_pa_create_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B1 Line exceeds max length (108>80): "https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/."
[3/4] Bluetooth: hci_sync: pin conn across hci_le_big_create_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B1 Line exceeds max length (108>80): "https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/."
[4/4] Bluetooth: hci_sync: pin conn across hci_acl_create_conn_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
29: B1 Line exceeds max length (108>80): "https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/."


https://github.com/bluez/bluetooth-next/pull/169

---
Regards,
Linux Bluetooth


--===============8971979075087559548==--
