Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEF3B4E9B
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831092; cv=none; b=esNbVqsmQFLrpgrHqNO81bFLLe8umZ08sv4JL3rGcsGk63QLUmVvNI3LUqUc5eR/eMksdvjoeKt25OGF0PUojED9lRrl4OrCslCXlPk4YyvDhULgnECsuYjD3B6XC6ISC/VaA4X7Ltus9YB9zUM1cerLMfVPC0eoXtBF1yrF+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831092; c=relaxed/simple;
	bh=IMmGiBPrwv7Qybq2cPOtHsQE3kpfRBLnzK2J9TL2Fzc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EPyujilGjY5vKW1c7ggL7F/hXzvmt8jhzgKcZCg52/iX81IhmWJVbdip8h4kWfgrTKJ6UcRMX+7vdt2jWx7DEtejEbMiP0UGXc0yhlOs0cyXSg0lNbNMVpwF7V77Cjq8LXgc8MeJlCacWasB9HkxZg0ejuwj8EFQGhzvx8M7ppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbwSild7; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbwSild7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so3909070eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791831090; x=1792435890; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tbZjUWJf2ivJnW7jMY2YzU2v1IqC8Pms1fRmNKyBgXs=;
        b=PbwSild7bSVYiX6KTMy6Z8IVOmibiIgd1Lsyckycynu6z+t8O+glE4Gf8/jb8Cy1dI
         x+XXF3/jwFfoFciUiUy6Yh3WvULJr2KpHsQRftGiy0olzxuqr7XX8QJXjVoUizm0ZvJO
         +qBHGYYjcOGixIp67MYSaGr/YdWVc2bCfHfzfYVGxULvdGzDmCiKnVtJ+61wHtzyW+Km
         RLN6F360LuEn61bhSC6osCv7BOT72lqBDMtJiag9k8Bw/b3rcW/wcp0tjFvz0YdBGqhC
         cq4d/Dsl1q8rE2CwglIFmbzsNN64ckyJsZnYEIcD8NvcjDRyW2w4m9xokaRuhL90Irxt
         MQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831090; x=1792435890;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tbZjUWJf2ivJnW7jMY2YzU2v1IqC8Pms1fRmNKyBgXs=;
        b=2H5yL5WKFwVSaTO6BX72S3LacavYfq1r604qwkeq/XoQA5GxM+pJTYhNTEX0An/jhP
         xBNistEY0W+tpCrJOZtwb8BnvamIMQoX+incJpx2KJq77gUkKbJw2wOmGqLNaNs6LXX3
         4nEXD1ZDmWJnbZPUVNuzx0K8LGfYL/97ym3S3rrcVIFNeFMdZQz2So0LD1AchLVAAd2E
         i+N634NEpWqwtueZE0penD+ClmnOzx3TfsFqe6REVC3LYA1Rba69mHQ9lPTYCR1iuzyB
         O8XYpgPRpMwGGiUEI+4PYfUyVbiGEZnxfeOYQATTMGHPgrnNYvsdHp4Ias2d8vOTOmvh
         KJOA==
X-Gm-Message-State: AFq9FYLj2Lw/L4VIDM4ScGXGJd4Hi+LZDNSq8iVmHivqEi4E1IOOICwz
	3Hk9tWUQDIaN/KDFCTj3f+IedF78CJICKRTJDyhil1a1Ko/jGes7IDsxh4SfzkoX
X-Gm-Gg: AYBFou2PKIm8oGdiiZ0zeQcgLnpQrstXKBFX7el0oPE7UnsZQMD3ixzbGUzsbNDWwFn
	tdI5agpN6yioAJmKjsjKr+ZzbQUzfpI/bEZVzdfCJ+nENOkhBQK/1q78CDVmdlmiRnEjJQwjay0
	R57p/OzRLEM+9flpmYaPKiPAKg23Yy+9rDQq3YTUubuCQRegMU0HozV1atV60pnf5NGbpDwRdql
	yPHBG98r/2I3cQzYGKDm6INAF9Sc5/ENUcZrqXrVcuU469aFEyp240ucUpUV/3M2T+YfCuM4TJt
	K5hto3Dl9HRrkWzGXtRkBn7wxCPlzvXZJdOFCJeptS3FYuPkhfwRHRbXl67i64eVTXbl2jKSJMk
	GoAmSD88uwRNhCz3UfudfCJUdk5biWN2fySnTXaF4sJM8ax9Mpze6au2UFidd1/LjCY8o6oJ1eT
	/CGEeHDnDIvDt9IfDNewl+QOUOXgL353b19QQH90dA+Z1BsQkXuY1Ca8uHx2sZgIRqD/ynW1TY/
	IQ=
X-Received: by 2002:a05:7300:6cac:b0:339:7b3b:236d with SMTP id 5a478bee46e88-3537dfc8fd8mr20657349eec.15.1791831089938;
        Mon, 12 Oct 2026 11:51:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.0.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm38341552eec.27.2026.10.12.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:51:29 -0700 (PDT)
Message-ID: <6acd2c31.bd274c6e.190902.1267@mx.google.com>
Date: Mon, 12 Oct 2026 11:51:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3500448025724738730=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test: functional: change the HoG connection rate from the HID device
In-Reply-To: <20261012152847.66886-1-luiz.dentz@gmail.com>
References: <20261012152847.66886-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3500448025724738730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184010/

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      17.83 seconds
BluezMake                     PASS      316.85 seconds
MakeCheck                     PASS      13.82 seconds
MakeDistcheck                 PASS      133.02 seconds
CheckValgrind                 PASS      225.89 seconds
CheckSmatch                   PASS      247.31 seconds
bluezmakeextell               PASS      89.05 seconds
TestFunctional                FAIL      1139.47 seconds
IncrementalBuild              PASS      316.62 seconds
ScanBuild                     PASS      1014.36 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f5ee76b67b0>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'(No device connected)')
        3: re.compile(b'(No attribute selected)')
        4: re.compile(b'00:AA:01:00:00:42 type .* connection subrate interval 0x0008')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f5ee76b67b0>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'(No device connected)')
        3: re.compile(b'(No attribute selected)')
        4: re.compile(b'00:AA:01:00:00:42 type .* connection subrate interval 0x0008')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f5ee76b67b0>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'(No device connected)')
            3: re.compile(b'(No attribute selected)')
            4: re.compile(b'00:AA:01:00:00:42 type .* connection subrate interval 0x0008')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f5ee76b67b0>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'(No device connected)')
            3: re.compile(b'(No attribute selected)')
            4: re.compile(b'00:AA:01:00:00:42 type .* connection subrate interval 0x0008')


https://github.com/bluez/bluez/pull/2663

---
Regards,
Linux Bluetooth


--===============3500448025724738730==--
