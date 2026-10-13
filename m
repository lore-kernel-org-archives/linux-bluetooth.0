Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89407481640
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867184; cv=none; b=oHO5Xpsuo3caiIB8lsa54PjrWRjab67skipQVxQNKVzqlbW5iLFkwawLWJLRco++9bgVRwMJwl1clB5VXz2B5ZfxxwFcn7psEKN3Gr/ockXi037G3ZP+2bDOrAxOoO+oWrSOvVn78ceTDB8piQuG62yJ0WulcJCbqCdo67MJnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867184; c=relaxed/simple;
	bh=aiR8RhwOBY2JAy0juCZzbdLtZCUhjYUNQB7H7mp97Bg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WsPq8ie1coQ0+gmOVnWZ8I+/7V3JX7EHw7Co7w2fiXTpFPLi7MurwL1c2uhcdtiQ9QqjGkt35n+aX4ycNP71RaMXvomunUegjB/wnQRaemtROnsJt9zMNvcivY17vc05jsMAmzmk1qhR+B63pb0yO5MIwJ0/KQ6PokQnSTV5ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlUWI690; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlUWI690"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cda9f8ea3so10871eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791867182; x=1792471982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eqFI9c+kvJ1AU4LJi8IcbhB48KP95t/WlH5rCPfCC40=;
        b=SlUWI690wS9TNII/0DO6lpn3E+2tNq2jw2bZQtyhVjztQI1kBxaOn6iM12zd4KNCId
         f0Ww0kIONKB9Tg5yJv6edgkPe9plNZti8Eacbik/oG3KmmpEvuXLOCk8mHwS6i1lmEI+
         hSrvoMLKzNvxdmgSNuwrosPYMMSoemDYZmugeMebL2y+aZmwLsw7TW9lxJATCuopByg0
         ZDnC5CWWMgdP39hspTfcw9NYuj4EViiXuR8LFE3EhRaCTmUai9Ubhr5qHMMM154j8a71
         em/MvOnQdsaXAo0wR/SrThqxeTsclLp06Su5zUF19IxMR5Ssw2ozVppUbbZwL3JQPpEb
         nBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791867182; x=1792471982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eqFI9c+kvJ1AU4LJi8IcbhB48KP95t/WlH5rCPfCC40=;
        b=SHUChjZcvi78GkmPnj1el735feWxV5aGjqlyoiQNp79Yu5kVi9pc99mmdrJMSUUs+h
         gNceAJlUEklVC/tPQRcrlhqd0zbAJqSfrg0U6bobiOapr8G8sEw+JrOoRs6WOFJ+mOSy
         dglhPYu+dtHU3dADO4Ysd08lIt5onC0syMRyu9ewvZmqvbIVl4cro6ZMHHEzSJXXdnYB
         UZagqcX4iR/NEE18g5lN15WG2wLpQGE1pRHtLN9k/zK+4S2MyCsGc7D2sHCvfCJNzZ3J
         w/8hwfwPECDF60HwquhNyDFGK7tiszdErvBEo+qNElhWRjeo8VkwQMnNmcP89JXLShVu
         2VBw==
X-Gm-Message-State: AFq9FYLmDGa9wZAMcOnIpElRMFOO3mWys//eJ7VK+ZrMrqDuOGyMkC9O
	SvcNFVuATSBQ02qcEh1PYTQI4fwhBLlZRZYlM6zZUg/nNi4PgjBNqMObMus+tw==
X-Gm-Gg: AYBFou1VHwYFqYGbldKxFc4uIiIbamXoFrBcUAACu71JjjiTXV/P8x+txZ7YatVzzAY
	jP1rmlY2in7iS8Qmkky+LTgMOAkVVe4jSjbV7JIek2KJbq1PzGbgChDvNd7hXJWVTRjv/Z6hb3t
	pSQulD1xemaqyNnQEye5Hc/U2S3iSNJ934sOK7vvDymGCy7t6JqDJuCX3aQm3+x9r7n2eT5f9sY
	/2OBGTGRRlPqg6VJ+ws9xShE/5N1RnWbbOgra2Q9C4/4rl6asaY2cTne/LdyEaTsxLVMe8LlP12
	8cDfWqst5yMh1vWqWWNd6prZdeK31g/HWlHXqIBbQfQiMW9g3+HhcnUtLItzUj0xoAbwuKAdv12
	whNjJKrZyBDx+4EnYPVJFwxC0Kzet6dwt0pv+Zu3yrC3pddwbY0/OZM4IOUYHasiRpzC5fvIOYn
	JG27xkSOR5KLfbzZR0wSVDjF0K2R8vlTdLF79Lv3T2ncDZWvIg316i68NfYxn/Xi5NcJAjVJBCj
	E6nhtGIEx+E3Zo=
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id 5a478bee46e88-3536c53930dmr18034520eec.13.1791867182433;
        Mon, 12 Oct 2026 21:53:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.98.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm38812977eec.30.2026.10.12.21.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:53:01 -0700 (PDT)
Message-ID: <6acdb92d.fb72d079.7c6ec.e9a3@mx.google.com>
Date: Mon, 12 Oct 2026 21:53:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2951873386861914338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] asha: Defer BR/EDR inquiry while streaming
In-Reply-To: <20261013035348.525335-1-cochcoder@proton.me>
References: <20261013035348.525335-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2951873386861914338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184362/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      18.38 seconds
BluezMake                     PASS      243.53 seconds
MakeCheck                     PASS      2.69 seconds
MakeDistcheck                 PASS      125.54 seconds
CheckValgrind                 PASS      134.45 seconds
CheckSmatch                   PASS      215.20 seconds
bluezmakeextell               PASS      82.08 seconds
TestFunctional                FAIL      1054.53 seconds
IncrementalBuild              PASS      246.17 seconds
ScanBuild                     PASS      833.58 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7fac44e56510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7fac44e56510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7fac44e56510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7fac44e56510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: pytest_bluezenv.rpc.RemoteTimeoutError: Connection recv timed out


https://github.com/bluez/bluez/pull/2668

---
Regards,
Linux Bluetooth


--===============2951873386861914338==--
