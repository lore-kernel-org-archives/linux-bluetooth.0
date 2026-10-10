Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879330F7FA
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626908; cv=none; b=gQi++8IfD0KVqrOoHUE8EmyalH2pVpeAQip/KFnUNH7IajqhG1QhWphAXunSLsGsUG/CMlSRnNd6HsTzhPpkxWcN/ZMu7P/8rzQHtjNzqJerG1v/SbsysjFp/YtQ7T5s2RVM6Jyh/Gx04HJ8jP4uLjgZNOpKux0E6rSAz99uPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626908; c=relaxed/simple;
	bh=v9O3eenk5fnoBgF+otNye3t1H/Aws+1j2Tr9WJL/vFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bq9z2LlXeGTAQ3PZ83TQOGs3soMhgDY4p1gWJ2v6xOZiRqWmx0S1HFNg6SFEd8HRgkn+YYt61cX3SC9BUK2nUCmd27QtVsKlLItW30+3S/J8Ti/9MGH7kVvhqD6CNhQdKlaSaVjb9gY/YlTexDk5M5RRfnXNkE/QWEpGojOQ6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVNIuuem; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVNIuuem"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1254182a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791626907; x=1792231707; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h8lTYSjvZj0V4+rrr2puTqeBaxQchQMzdafK5UUUg18=;
        b=TVNIuuemLh1Q5XqAZ8TftfayUZtgfcg81WJlPN7075qgqTVKwtMndLgBQO8MA0qlaE
         avH925mE3vCVwy48pQUPnEw9KorZN1/28q21pH/Gdk4ZojNpZXjFibiyLUN4/5y5fl79
         5smMp5eUPqnTr7152Xl+Dxs8Base81XciQ1+alUZRk8UUdxO6vSsAfem0kaPHGKBrdWU
         lWeOMHrV+fz7S6Ex2813WZ3wvfTtxJ+iRTalzN2Kb14HedhnDJqtGAd0o40ZQ7MoCL01
         kYFw4T07jDF92eQxOm8yR8vXWz1lUpKHMEIXz/dWScaSPIiXh2JiUbWBLeBXYfyAzfjL
         Tn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791626907; x=1792231707;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h8lTYSjvZj0V4+rrr2puTqeBaxQchQMzdafK5UUUg18=;
        b=HmxFV+IrBoZoMRaPW1fadYMBwPuhvlexYmHax7DlZJN65DioDmOc8CFu9JtRTjPAyd
         ZPwTVb57d3IyYHzqdn3RA7Pae+M8FVyHIB7UNkaBeVtvx/oEvIcGOEJl1KKQOCnw+OFY
         t1NwUNf1kneY1sVwkeKztRLdCJX2Mcl6ERvGH0ssGVTDhJI5+ciMarH3kprOucGvhGD7
         wR8CgITDhRY6gVSU4Dj5BFfBPU79GKzr49LZgmiNOQxh/IQ9dbe/hHB5i/zYPD9NynmA
         JEQpqLjt+Q78V1a1ye7iZkroWlJRdCedmvcATXhxzfBwCsvxazMWCZKIuIwyKDJ2fLQz
         wSTg==
X-Gm-Message-State: AFq9FYL7Y/P54qEnmOsxaNf/wuPecNgiSGMzvTWFKOTAcNaanyxQVpOR
	zvFNGdzh6kJnbr/v2h8cWpPJY3tjGHT8enhjsmuOFmNZRczz/fVddY0etoZEAA==
X-Gm-Gg: AYBFou0MaEbgQSV2aqwYnXhg9VpTtRT1fySB8NQHhh+kLzupL1Ksv6ef6iFpGWleLBY
	LS0m/te81q9bwxyhgyNOnDo5RBlmNlJFe4tU/ZVU4yVCX2Nq5lV63ACHPSluDeDlJWZ7LLz5wqJ
	AH/A5iJK0bprCoqibU6SCgiS78AUUcCN4Q/Iexj57ZxDRj6MZkofpITtA/tY14AW8wjimzfhjPG
	jeuKuM8KSyCiukp2WhQV4gPvXYa4qYWoSd4MF6AbnuB7C4w3NvMpQs5BVvTFjbbOlQg66oBccvM
	TPimEdpev9NhxIX35vSU6PQZ/3hOzsxriIQBbrWEJEF4murWHN0LpD/3P9rEsv0hM4H5bHSDfd/
	Z1MVL+64KOL6wmDsreU/jNHBjz4//ATUPkopoJpzWYGwb8gQRTkG6VsZI/O2yugoQieBqE1GgQz
	ZyW2vrsXKohisNs2+KiKiMmDNk/+Twptru2cLvANOsBBKZo5xbW9sngCnX3CGl+0FMwKZuf5HGW
	2WH5zI=
X-Received: by 2002:a17:90b:4d88:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3ab3acc7c8cmr3040826a91.37.1791626906959;
        Sat, 10 Oct 2026 03:08:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.212.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f48bfbsm7851535a91.9.2026.10.10.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:08:26 -0700 (PDT)
Message-ID: <6aca0e9a.bcb951e1.1b40d7.6634@mx.google.com>
Date: Sat, 10 Oct 2026 03:08:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7450516886402171549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: mgmt-tester: Add simultaneous discovery stop tests
In-Reply-To: <20261010031852.2842893-2-yaroslav.voytovych@gmail.com>
References: <20261010031852.2842893-2-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7450516886402171549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182788/

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      19.54 seconds
BluezMake                     PASS      376.19 seconds
CheckSmatch                   WARNING   299.23 seconds
bluezmakeextell               PASS      96.49 seconds
TestFunctional                FAIL      1234.64 seconds
IncrementalBuild              PASS      423.32 seconds
ScanBuild                     PASS      1127.78 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:479:29: warning: Variable length array is used.
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7fbca52a67b0>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7fbca52a67b0>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 502, in expect
            ret = self.ctl.expect(*a, **kw)
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
            return self.expect_list(compiled_pattern_list,
                   ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
                    timeout, searchwindowsize, async_)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
            return exp.expect_loop(timeout)
                   ~~~~~~~~~~~~~~~^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
            return self.timeout(e)
                   ~~~~~~~~~~~~^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
            raise exc
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7fbca52a67b0>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7fbca52a67b0>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2655

---
Regards,
Linux Bluetooth


--===============7450516886402171549==--
