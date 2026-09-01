Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726632C8B
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304077; cv=none; b=iBJonfeXUVTOQa2qjmu+vl9fx8Xs1nstlHBO7VDCJGuHdJf+Gkky5c1t+cY7V7MGT76CfaDxso9yWOqQs9ONCFGv3jQzXwHqZil8l7T0oq6yc/nchlI2pWmPAuRrC+qnga6+U4cM8J1Cjr3J3gnvgEcXbiV9QIMLR5tAhGl0yuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304077; c=relaxed/simple;
	bh=GIM52NehapvlUcdyCS8uka+DZJW9WDA6BBu9B82+pZA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gnn3LDLf5G69YQA5psBx2C4HXQZKxvvSy9GoSmUg0GxjvDyjD8YrueJxebq3j3E6Q44ORWaJKdwTbyUrGgIT1JAKnZ9macaQR0mR8efoKpJYDhp1waR0AHA5Vj5dkrj4A8CD/ZiFn4h+aPQ1zhwlJVnKA2e8vlVWDAvcKNra+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9nujckm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9nujckm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d9004f39d3so3965145ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788304075; x=1788908875; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pyYNJBuCCUvStjEEzCqjE3aTkGF5PvYlxpFUr0Xo8HU=;
        b=W9nujckmO7fU9RA+e0LV5sUAJNHtgLCdV6y+l7waHzqGYvV7oCPGo6s1frKmMr8/rp
         PImyARswO0RmyUEcA3fbwaRWl2BbuoGmRXUJ7Eq0IBTXQctiXd6MqbYNw1IvxWWM4LQp
         KpH2D5mrj9R4ipq0nlF9Lc6IWVrut7EnZp7Fy5+TjFcbPNpLUxJfAAHn5SyRXNegqARB
         PosU7NYMT1+3mo/JZ9OzgCcxidqsAfho5J+RBsx/JxYoUkKWuYg/OlM2dgca8FdyUFx1
         JwNNEyXbp1pq80qfr78zV3hfJ7dkwBMmE46VJ08VUj8HudrgTxAeoy4FhaLJgptCIQhZ
         eKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788304075; x=1788908875;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pyYNJBuCCUvStjEEzCqjE3aTkGF5PvYlxpFUr0Xo8HU=;
        b=ToZ2r1ojkn2ADYrdl+bSo695MjGo3A1keOPHaQeEQH809fob8kkRrs/UOVcVOpbZYI
         KKA0vzV+q2iZolFoumchhLLx2Ug83Y5a1M6WCxpY6NIPGB98QH1I+RuN3bbGFxffvnp3
         T8OHHr9SwQnuFKutSkK7r5ysH0xMyfSBHfxfZkFMBBipTqoI+EkuuPuev49q4p8u55go
         Thkf/Lvxmak3LVg9OH5RlzOoY6B5VcYb0HpGQ1VrJHjy7VaklV1YwEhtNf7KVE0Ovtks
         hLDey53/9SIczjmuQUz//m8gja3OAYkeWbgUEA5s/k/diBfo6iz3okyx2VfENuPs0utn
         BvKw==
X-Gm-Message-State: AFuF++mwF+A/MaqBSIoUK5pgf1SLMOXWibQFh0ivsN1cgrxpxNPO5bUh
	6GY4FbzPpxWr1GMR+gzM+R4kIsR5/bHZCmqQSz1GcNqE/tmsfAJrAOFxxi+2ZA==
X-Gm-Gg: AYBFou3kPCiKxo6AuU1JJWwGQPcx5Qd/yopkJ6BBnrakSJ40zZkkWIHQsrqzZkwO23h
	4tpy2OV9whGgduORV62L4F/zYIuyBkl81CXC8Wka/ItYa5H/Jv6MCX11jE+PgDJQO9Qyr66i9rY
	jXB+i+GtwTKncLjMOPmzUWhhCUP4/OTcpPQOYTstuyJLj8s1ks1+Mw89xG18t/uYksKFmzXV6Uk
	xiRYaXbsbDYysd+4sya2WGJbomKJmuQ42cf7rVDkm5+uX9A35Zq+3BZCdxYhxD4QYIVsRLo1PkO
	wx0NlYQi1xwe+PmA7GSmwjTI5pCB29GiT5ryBHJxpsZaIOnb9nnA1OoMHRC2wfmfbsCJykqKkud
	KEQsboUQ1tBA8LCq3L3E2RiGmNanjROaYoZITRtx7LcJwIk93Jjq/8qA//iPcN0pcgmFbWIFugg
	XEJ01eMMlBUBJb8uralvM4FtckPlHTJ7QCD3WnjkOKw9rdIJbIMYZ7W5phQjeZzgwm0us=
X-Received: by 2002:a17:90b:3985:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39aee22218dmr447719a91.21.1788304075320;
        Tue, 01 Sep 2026 16:07:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.46.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c33e9sm1284249eec.4.2026.09.01.16.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 16:07:54 -0700 (PDT)
Message-ID: <6a975aca.5003ab28.3a895e.e78f@mx.google.com>
Date: Tue, 01 Sep 2026 16:07:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3918495700016424394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3] tools/l2cap-tester: test closing sockets with ECRED defer
In-Reply-To: <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
References: <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3918495700016424394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155668

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       FAIL      0.22 seconds
BuildEll                      PASS      15.86 seconds
BluezMake                     PASS      507.90 seconds
CheckSmatch                   PASS      229.69 seconds
bluezmakeextell               PASS      73.75 seconds
IncrementalBuild              PASS      434.74 seconds
ScanBuild                     PASS      680.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3] tools/l2cap-tester: test closing sockets with ECRED defer

13: B1 Line exceeds max length (92>80): "      commit 62df5992 ("Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer")"
14: B2 Line has trailing whitespace: "    "
17: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluez/pull/2468

---
Regards,
Linux Bluetooth


--===============3918495700016424394==--
