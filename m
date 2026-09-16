Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D29377A8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572523; cv=none; b=UfywYqW+8IBu136mBa95ejP6HKOElQ3u18jHaCKEpiDMnmJn4OgECyIzWbJs7uTq5LWlmdMdFjyJZap9WK/17ZMye2nE4GvJISSDkiw7cyopu7QAWbMjLKw6zwXLrDpZGF6ZStLIkO9W70OgMYBuQ9znH5wjW2X7Suz4UqgCGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572523; c=relaxed/simple;
	bh=a18N3DIg9ckGJv6IF15odfQTE+ZwXLCvkYNBNRmOk94=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LHiTiptd1RvExUoKOL/smaTxHudaDV6D6CA4RNuAhgZ5HGi88wAL6cvAkYOc6Kl3j94kYXHlCIRXGjyL+i5gQxI9M2LK/m7LJJJdC84oak+opFBGUBYbD1zWuVd5S74g5LxERP7pdd49uDCe909d6FPwKIHj65ZbvtJD115NxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqqvJUNu; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqqvJUNu"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c6so832404b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572512; x=1790177312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UibywPXccOHZDB/Z5/SQEmTq45qCAenbiYVgpmVNYpw=;
        b=lqqvJUNu2bEbX63Ix8kAmlJR5UsaRP/FqRJ1pL3dtDl5rgVg5F4Rh33eM0kYpSAH9N
         jQLgJsI0HuaV5FEWDad2cpYnWOGLOACSCUZAE9a6NWmV0hMDDh3HvSMK9jaGIu1Vg9mD
         yRpFR1gF/3/VAzXcbvSzFiLXtA7l7sQQPkHb8+2pg41MW61Yo43pmDpHlNmk3KYZD1Se
         yP/TUsamukaPxH6fa1QjKun+wuXHM+6EoHN06s4t64erkRjQdu2UunzetBP7fq9tc2Qa
         1HCa9eY7od6QMq/WNJ02MheTHOw++V8J/R1dgu0FsHH/kfHVkxTXq/5VzcZC9O+JgSU0
         RrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572512; x=1790177312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UibywPXccOHZDB/Z5/SQEmTq45qCAenbiYVgpmVNYpw=;
        b=hhBq7ElGMy1nJiAxsKihPufF3ZgQxcauZ1mx4gcAakff0G5/U7oKlVUt+teauvHnH4
         91jgb4+++BgPaBUJ9Kf1St7LqTvumTtu8hXO5C7kDd0wiVBxbSCmJNfHeUYKKfaZhl/B
         Z5oa7P6Q8SgefwsWTMq1F/I2xMz3jb/kNEfWg4rTXlf2yNh19U1fYW9+BCl1MHLxNs4q
         0HP40POtTj7qJIpUUhOclh9HPqP82YWq1hqk6KNMaVwHgGMs9oOAkpgSNGxK7BGtvu0+
         UT7UYL/ytLmwk7nZ9D2kNDt81JVPn657AcGkWpYN7kiEFW3LOrKjVNHaKI+Snm22bgMw
         iL7A==
X-Gm-Message-State: AFuF++kJCeX0qeRAUb0yjw35hjnaDlLIyaA3xrhT6gsZzm1tMNOm848h
	3PF3ijPPw4vvZpfS2+m8M9gB9HpSS43IZ+wg3CzjoyvzkmQYQBx6Tl+jNo3wYw==
X-Gm-Gg: AYBFou2UPgVM7xtsXRLsVoH31b7nWjmBhC2paPzyb6lefHfOzZzb1pJ6gpUIZZjPkNS
	1hPXxzur4uPKo2Clo/X0lexhwpc1+k2xJHBkrChD44MYsKnlquW6bxk1WJ/qQr5UVS6jXQ7HAnR
	GY8lUA0wh0nJzrvFooxrNrd8ay6f2nWhtmXzaqo6av+GldASKkD2y9WZEVhzEik8Y5PCZXx8S6+
	ek4WRg0BNqkDy/cQCLwQdFhLhrst6PTXXZdiOD/nq+IuorkEMQmg2iaLrQMWiy0QYe1O4Cza7dx
	qXGpPRAdRAGudTcX25rZCIv1+C0tyHXLFXEWV1bzkoDKjw5r3RJYRvGuFzsBJHxlj83Viw/1F88
	J72/epUp7y23lfm9PoUYuBbL5BULBe4v/vW8eSmpQb11OADuLd5LM/hTRZjirKkoDKm9OZN+Hb5
	2uq2TyoZL/ZWnkAiORWlkXcvKVpVhD+AKr57qeij71TMHqLqretLt83yshJZjGJeZsZBy+gxzj4
	lZkWnfqNUlSEXby
X-Received: by 2002:a05:6a20:549d:b0:3da:c10c:6aa6 with SMTP id adf61e73a8af0-3dd5f3bfd42mr8497111637.1.1789572512173;
        Wed, 16 Sep 2026 08:28:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.215.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc1178sm1791487a12.30.2026.09.16.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:28:31 -0700 (PDT)
Message-ID: <6aaab59f.3071105b.3cdcf.0f0f@mx.google.com>
Date: Wed, 16 Sep 2026 08:28:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6054973129082073217=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, derektern@proton.me
Subject: RE: Avoid local metadata Config notifications
In-Reply-To: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
References: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6054973129082073217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166364/

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.39 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      400.18 seconds
MakeCheck                     PASS      14.50 seconds
MakeDistcheck                 PASS      140.91 seconds
CheckValgrind                 PASS      234.50 seconds
CheckSmatch                   WARNING   292.56 seconds
bluezmakeextell               PASS      94.96 seconds
TestFunctional                FAIL      1127.01 seconds
IncrementalBuild              PASS      423.37 seconds
ScanBuild                     PASS      1131.12 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f01af24ea50>
    searcher: searcher_re:
        0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
        1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f01af24ea50>
    searcher: searcher_re:
        0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
        1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 441, in expect
            ret = ctl.expect(*a, **kw)
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f01af24ea50>
        searcher: searcher_re:
            0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
            1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f01af24ea50>
        searcher: searcher_re:
            0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
            1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')


https://github.com/bluez/bluez/pull/2539

---
Regards,
Linux Bluetooth


--===============6054973129082073217==--
