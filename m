Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895B346771
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509937; cv=none; b=k/zQZQn3AIjZcmTM7Eg/Aaf53/vFiblyJYLcsdMwdEX7aXi3oAwG2KjYoowLT4tZmIVhudqfMT3MtiL23HDLh0PJ1jqAErmqUDQTof7GPEK1qiqo7Dh5AsIB77ESki9JDX3sHcBLbkTELUsKj6IzyvQvpe9oV9pr5wpRU0aBv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509937; c=relaxed/simple;
	bh=fyIOP9ePUd2lRAvCgnLrriJHV+hbgrT1zl3TzdTwTxo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OxwdVYMDGd7ZaU6H9I+zWLxa5lVRaHd19eUsN02vkZ4NBjhLmI1CIJtuERvWl0dYijO9/S3uMyLbAWcea8FqGHiuUSXdlLxAnU6hm7BmPNPFvzyyexEzjrH1JrsSNppXR7JHJdxYQ0KqZ+6ghuz/Ke6h99ZTfmt1Bq8LnyWhfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9c8aR8E; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9c8aR8E"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4ee0084fd98so42675251cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766509934; x=1767114734; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DEPNBqeK0NItIjMStfmaWnjWVOYZohX+yoFcnqnK3oo=;
        b=b9c8aR8EttcYwLXErIsP/3rY1BNsMwwiQy6Op09NBXUYse3/sbDLi+dNCf1Hyex1pE
         YTyce2QZJ37tdkwM4CvzuTCb/SWOCFU1vLRd4+EJ/QS/mdve6Yin+NW5yueJmgUqijqi
         JlVB954VmV7LeoTEL++8m/Jo0/Xy/TBgtaqyNKsm5cKAPgwG5+qtJUO3x8deGmqlpTqG
         44tOO9Ti6fz9ZsLYjstf4iisKr0zW3G4rnpseiGeHYEIpQyrmWBTTBK0xopAxgqojyt6
         GEwwdrbsCVZxx1/skmPfDveNkVyhCvJbHp43V8/xGtzBXDwCYrF1BW4doPsHk6Ee8EQm
         xbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509934; x=1767114734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEPNBqeK0NItIjMStfmaWnjWVOYZohX+yoFcnqnK3oo=;
        b=VA0oNzOmzgcCJXIRgwhlVyRd1RFsWzlrt/nK05nKEi5g4ztfacHrKDL1KW62RC51Kf
         p2jyTrNDJVuFThqyGXKrRGdYDYXgc9Q1En3gUDTRBG6w/lg+P0hXkkVYNsrAJHYNn5JF
         QcA/lKnV1FN5m2AAD/4sP31UVTAYtw/1AIyllmYkmnhmG0nKH13gygzaOqOV7OFUF+Rs
         w17A4QIjw+ofJi2OUXprGhn/Lsd/O/TbwYmVsoVoJC+avGurQ08GUnsYoBUi8EIcFmBq
         Xecm//r0JnuZSRYJNlwoEGX7We6RcsVTkN5mDnAh78b/Cn7BAx6S/IAsSzqC7GQSJky0
         pyMw==
X-Gm-Message-State: AOJu0YxQg+lTuIxzmYN7GOzKXhFldcgi3iSzA8VOx6rCLMB8kWU8upiy
	6US6su3kuBXmi1rSkhi9c38BTn92qxQMoCD1AAYBcklCDooMJFiZfcn5YhzNLciv
X-Gm-Gg: AY/fxX7iQ/pZwvgJ7fkbFNy7qA2SvmBEdnCY8hHgZ7Fc6pcvnhATjmqCx/PPoKwO78l
	ZXiEAc6gQQ33ZCNvmFsE7s5x32ijLARlnodJ8AhNWw5CaRk3m7g0eYnxu2WjswbgW4TKVsrNck3
	EU1FQ8OGjynh36zuKvyjWglqedrabXPgB6xyj9zZAqaY0Gz0GYRQYSaOnw5wJiP4oz8OSbvhAVD
	3nbHJ/Nt7oXZdLuhUmLWa//K/CsicmZkXfOrq9zdGG0+2GRjl1wVFh5uKNpkJK79wE04txULmoI
	3VvGCVdxu2hlph/lVQk/iXYFX6ACXL2CeYVLU+Hpbk0/j4OBZWgtHACA+umel9CqU1J8Krr6n9O
	dsrfzSsC5Y9KxP0ng3xf2WjE+S16e1ldnpln4DFtvYgUr+DkvIYwYJuNGmStTYR0x3RVFqRbiAB
	Mbaz+uXg6X1Dagydo=
X-Google-Smtp-Source: AGHT+IGyNTGEIscH8tFdSlO+IS7cuYphWG0vhYhC1fN/rlVJ1NMWnrxRKKGcULvjm5fjk92MRxMiAQ==
X-Received: by 2002:a05:622a:1146:b0:4f1:abf2:54cb with SMTP id d75a77b69052e-4f4abd75338mr260054591cf.43.1766509934321;
        Tue, 23 Dec 2025 09:12:14 -0800 (PST)
Received: from [172.17.0.2] ([9.234.151.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4d5b4c975sm39183111cf.1.2025.12.23.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:12:13 -0800 (PST)
Message-ID: <694acd6d.050a0220.1b3c64.8f28@mx.google.com>
Date: Tue, 23 Dec 2025 09:12:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0735498290273094835=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, techieernie@gmail.com
Subject: RE: Bluetooth: btusb: Add Realtek 8851BE USB ID (0489:e112)
In-Reply-To: <20251223162838.42725-1-techieernie@gmail.com>
References: <20251223162838.42725-1-techieernie@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0735498290273094835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036121

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      28.32 seconds
CheckSparse                   PASS      32.46 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      560.09 seconds
TestRunner_l2cap-tester       PASS      28.29 seconds
TestRunner_iso-tester         FAIL      52.43 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      116.06 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.56 seconds
IncrementalBuild              PENDING   1.07 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    2.705 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0735498290273094835==--
