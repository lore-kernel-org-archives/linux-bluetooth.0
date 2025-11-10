Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351701339A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783752; cv=none; b=DsJbEiRUDNWd+4qzWPKu+LkDRlMETSVgYl+mpUBonih6y/CW4ft4zk6I0p8ztf2d9OhSAEmcNnrc+ewwJCy6wfAnylN/evtVQB3nRpxZUVlMy7uvZc6+VT8/6V8nrfCS8NaowYrC5ikkSU4kQd9SV5EnwWEtNz+RUeUqjsQRSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783752; c=relaxed/simple;
	bh=Hzk9jzWLnnkgdfLWhyvUeXf0PiVhFvXiSSvOrlzqy6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RVOGaq7PjJudwvDNi5du/bx1nvltF7M6RmhUUKCG9eua7Fvc24MmCxEn2QN096HVGocwOL6rrLO8QC4k2I/iN0mwYhzm+cj+pDj1xYjpY4xLZJKL/gRfS2toxwMUNKzpn/7ffxGJgwkEO8hYMTtxuEyoWCnoS+2ihRBatTd2gOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwpdkdSL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwpdkdSL"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8804f840579so44217536d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762783749; x=1763388549; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=idHZRT/P4FgCqIy46H7o2KvwXqRw0hGtEkRs/4P2+E0=;
        b=dwpdkdSLDwoJTNh+O9saNLuhzjd6AObsjlyfX1ltzLD4ruCU8pFjXILiQhx/GTWb1e
         NuGVJef87tWlexzDCgWkUv1CoAHP5sLWeQmPBi5BCwb6O1Ix76KHYwM7b1m7W1NxSIyY
         EayMhDPVmUjWXqxAxDyn5fEAoNEiqGqQ3qUs+cLRirEV8Ka+f3yDJRILfyCIXzBMlZP+
         /82mBSXDmtkxdi+PQZiAMLLFtCZbomEjD30l+J/MuqZDp/AU4jtBATpxEM8h6cy1g1V6
         3Pjp2E21cCQ0bDx0smAeNMIXWW0YJC74qIdD2Lo0wG+PTd0S/f/nHTzKB7XUmbd+G33R
         DQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783749; x=1763388549;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idHZRT/P4FgCqIy46H7o2KvwXqRw0hGtEkRs/4P2+E0=;
        b=GNddH3JHPmGrc5ycQYycMsGC5ZYY+GHYUgzB0woh0qRcQ3Jfgha9uBFl9HLfT1nw+e
         FgHKdx4oVAiiBmWAGNeAAKozZKJZkC9Y6JBe5fwaKMnTCb1q7/9kAC+6zV87cRM3LOlz
         OOTqAY7fJJzBqwEeVzyb3apyDQyoMKF00eBHXPaMkJxu56lj3kLWDgK1ad2kfhtxBY1y
         98vFXSmA69DYHffB+NaQ7kLbmnhq3W7ATCL7AgvzJ1BP49l8dfTnE9PiXHqk9ElkDldz
         JneirPcn0GqbAiRz8IdM4Kqiaw5yHGQRzGTgCpnEc3kBx2wYFIArF317KSHFAF59ibEG
         FLFA==
X-Gm-Message-State: AOJu0Yy8yjXtS5/y3l7SG5m44PPQUDSatEVmKMtVhW/I3jvQOAYCFp1Q
	TX5Xt8sFqx0kcK2crUya99zXkpsIXds9WnpcpIiBnpiEnhB0mNpfpXRt2z/86w==
X-Gm-Gg: ASbGncvwH0t+Rn5Q7xow1qfhAa1d+/dof1rwJX+7y5ggINDzCZSHJQGj08O1gNUUEYt
	k5+WIWK95mHECYDnomLZuhd0mJjOtbhwxTUpvJocgNAcwW0vy0vSbusTeqEnsULmSVGMyHGUvNs
	Ux+wgisbXMkYohASOe/9j9GBD95+ZbaoF8/fG9B7/Fr1p2+oBzIOkkuOh3PrhXQp/bEGU5t3FvW
	FRmUzzNZ2yNmH/3HHH/Wduv1NebX/AavirLuFFMN6q676tUWSJy+CN2szZGJCRDsBjRWKFyHHyU
	KNp10le8tGXRUgrmI8kRaytNtjszkL66/gYvVZQFC6PlRLbhOvBJP9DRY+f7HDrJAJmptSwJfvS
	8O48MPYiigGFB0Vy7pmm7thjyb7G+RR33HHkfxKtqC7DJ5CGHCbfZvEvaMuf2/Ah4CuEMDDj5to
	fD+z/61uSvdo9UqFhJ
X-Google-Smtp-Source: AGHT+IEmq33HmY7WIpTEvF+QBJKPoOD/+vvEy1QP/tHBav0HgkWsYMR7E6KQdsmMRutJ7MNu1NFarA==
X-Received: by 2002:ad4:5f07:0:b0:7ff:7b64:840a with SMTP id 6a1803df08f44-8823873dd95mr112916446d6.33.1762783743435;
        Mon, 10 Nov 2025 06:09:03 -0800 (PST)
Received: from [172.17.0.2] ([20.109.92.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238969ca6sm54434626d6.15.2025.11.10.06.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:09:02 -0800 (PST)
Message-ID: <6911f1fe.d40a0220.24a625.a471@mx.google.com>
Date: Mon, 10 Nov 2025 06:09:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0155637244596529824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: ] Bluetooth: btusb: add default nvm file
In-Reply-To: <20251110132225.2413017-2-quic_shuaz@quicinc.com>
References: <20251110132225.2413017-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0155637244596529824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021596

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.61 seconds
CheckAllWarning               PASS      27.74 seconds
CheckSparse                   PASS      31.13 seconds
BuildKernel32                 PASS      24.97 seconds
TestRunnerSetup               PASS      497.75 seconds
TestRunner_l2cap-tester       PASS      23.92 seconds
TestRunner_iso-tester         PASS      87.79 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      115.63 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         PASS      14.32 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.51 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.153 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.982 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0155637244596529824==--
