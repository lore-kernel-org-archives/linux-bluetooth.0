Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65770211479
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704196; cv=none; b=ALdiYj7xIh1MQ5y0oubcJ09t5KuzNIhFJp8DZw+HFrUBgL+5xd86al9BgNeb7b7W2dClULFWmy/eUezEC2QYbvdjMDFPWQBwEMh6WfANw/SAF0d6RvqoomgX6yZXCJ9AWiooj56/f6Gz7Gq2LmBATE4YaKeg08R+rnC5uRf/xAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704196; c=relaxed/simple;
	bh=MDgX+tB/5dMkBmhR6NbtYpvz2cvrWqIqmPPDm4wsaHo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sx6cwLVoPtyBSt0TJgO3Pja3SWbQyZdBeJQne8LQXUBSK6UqPWhdZHcGm9l77KGw40+rONqvkAjKPlRx5N71aPkTDti6fqYJg62OR7BKX4qareUni80A8yF6tsyAjvBfDPcCaASEx6n1d97EyuCE/z9JHYFjHRgdXOuEahy4xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAPEoJgw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAPEoJgw"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b133b24ed7so183001cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755704194; x=1756308994; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BaMp4rYs3o1is7JbL6WTgoP24Q2ovg23b8WOs7adbAc=;
        b=dAPEoJgw/+C4Uei3h9kbHdWgM2fJps93c3gpea8ExIXLe6yCesuF4bU8Aa+thUSKhn
         5p7r77iamT5DbUkIYrJUMz429AKmWQCbxF6nw1XRdCevoGfINNeT5lDEV9tJTL/fFiwx
         68fXVN6QkyMK3IdfKPGIC+G6DuxdKPOwAm+EfKd2CwRpVS8tIo50ZAy0oyRJ8P3knZMX
         ePIXo0z1rof6G9fbGQA6xGWA15yhNLhYkz9LUtNE5AXSzBvwp8BW6ozBcy7ALKcX/9di
         TiXKuh8ceDayl/5kuwr7y+QylrQYgexi1gPce153Mk2nDL5GXRsRKshbAIiI5uqdrizx
         aBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704194; x=1756308994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaMp4rYs3o1is7JbL6WTgoP24Q2ovg23b8WOs7adbAc=;
        b=l/Pp3rX/+F/b1EpOOs4/GF1LmKC8tQbYpLuUVF+8dgZ92sdSDJxTXs+7w7T1mdV9/o
         ETWYlLGB8HcZNvwtr24JBKBt9Z4fE5HN2mtjDGWDqtAl6EASbdd0GCagPT7FIqIMiDkF
         yZSfl85yf/jaWtIm1Y4o7G2X8YjiJEHLFfTSKkNohnGjRwJPtfxlCH50J6/FXV3cVCjx
         wVcDzj/cUvrzZhqHclzsQZW7QdWbA9xcPzLlFq9CdlQpC+lZ4GtpPN/sO9LZAxRsVSou
         DNzka/DVWKWHykCSra9cw4rfAEegz9Q8p0BVQONqnMds5IrEWFzdwUERXyQxULVCOa91
         tvxA==
X-Gm-Message-State: AOJu0YxYdWOwuduye56lYW3ejJRyXMC/FAKLzcDN+P2JeniW/P8cp5cI
	VbktoGU2SnwQ2TXKZMeRivBesUTs6svPIqBPgggaVPwe2T8zEcmzkTIqD+4kaA==
X-Gm-Gg: ASbGncsVHf2HaVlW379fJf2XcUin1B3zJgF76WFpEzwdkQ0d9pAR0pYcPRUzk0n0NkJ
	1xHwqlVjwLz1dGL8YjJLzlOVDMPLegLInGfzwDjLo9W+Xy0QGEgFA359qIRxVvVKY8EQcJrIqq5
	Qxr/Do3//YILwD7c2i4JNLF+lPKs2PK8xbvcTG5704Qk/RHQPUfjgE4j2LN3m1uuTzZOhjT8+IN
	Xz1eJ+23EsPL95JpO+Zb1MHz2DD8wyipWWAkCJ0Gnsg8CZBGpSH2iXvBYXGwm/x8Lcbjp8D+wpz
	pRiQoT202qlIo1Mi28/04R/ZRBFC3yDaVfrEFP9/NAClW+Ud9Znk9BbxJ9sbfaO34ky8+Ork8Ha
	Rt465TLZGNjW8a0GO0kESE0eHVSs=
X-Google-Smtp-Source: AGHT+IFgT+zSNTfIg+LJgQHfxpm8Rdlxxfo9xhNO1QCcfXO26gg5254OVeZIob7cq0Z19YjJYeHlVA==
X-Received: by 2002:a05:622a:2517:b0:4b0:cb0e:8c0b with SMTP id d75a77b69052e-4b291b13121mr42479821cf.21.1755704193931;
        Wed, 20 Aug 2025 08:36:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm86273971cf.19.2025.08.20.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:36:33 -0700 (PDT)
Message-ID: <68a5eb81.050a0220.335a72.7ebb@mx.google.com>
Date: Wed, 20 Aug 2025 08:36:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3584366177513033881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
In-Reply-To: <20250820145829.1766185-1-luiz.dentz@gmail.com>
References: <20250820145829.1766185-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3584366177513033881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993567

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.98 seconds
CheckSparse                   PASS      30.31 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      478.89 seconds
TestRunner_l2cap-tester       PASS      25.08 seconds
TestRunner_iso-tester         PASS      39.18 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      126.40 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      14.89 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   1.05 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.228 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.191 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.979 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3584366177513033881==--
