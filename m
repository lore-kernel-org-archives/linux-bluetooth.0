Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183126FDBF
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625970; cv=none; b=arvag5eeJQxlATjJp//TPEUSQWaxzUExKORlaNi56QP7DIPVribcRtNBF6gbadgv7kwD8VDjTJeFXrrAx37CVPHnrjsR+7oRv8TD2KZ+Erbv1IuKX1Eplmz7kBwgb0LShCHCXKOOtOZ2Y1sHDXCqWbHmBW16+d5JHRLPYc8tKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625970; c=relaxed/simple;
	bh=VbMLArFTXDT+KtcFsXeGrkC175uY/EHmeHd2N61rMmw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EWbxHQvpf3eWnr0RlCRnUyaIwwOPfVh9H+DJMlcuP87I46LitN4UfSiG6LKnjoApEzrXY9qhlgCpP8X5ubC4nfCF1DfAHFI8jROc0CdLWRLDM0P6od4VKn+QxLGxz80FjXUZbrhkxWs33bAHO+k7+tBdWRIuvD7bJ2OQYq+K0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVjAy1LS; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVjAy1LS"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15943c9c005so621368c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791625968; x=1792230768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c0SEKjgu/TKKsxoFPsrG7lBxjVTC2xC5QWWscnfFWXc=;
        b=ZVjAy1LSNMQg/CEFLi27FMqv8QIkD+FTmxYU0G4x4ca2DmuZstkZeYBfAtysfPPTWr
         aH0MaizZWfcIh+l+WOPH+q/kI/2UTqPJsKnW3YOgskqeLWI6OkOdv+THwB4yPaMaJRfF
         HGccOqfaGtCNdZoyjn7nLtcoI61ANlrEVOQ0KtdXG3G9fKoxIpiNwJghYcXQ2m3DWk7s
         JClLQGj+mIS5Y0qrS5IGkf7CUK+h8EJPhfGJuBrrdxWWGRkZ3tJL8tgTfsxNGoltCAGu
         Ng9x+qa0zh6CAY9p69pzYswbr67+bPj+hOzcZuaWJV4knNDvmQvSN9Uk2VSs8yAWx2gp
         uDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791625968; x=1792230768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c0SEKjgu/TKKsxoFPsrG7lBxjVTC2xC5QWWscnfFWXc=;
        b=vickONx1No9XXXqyloCnRAEIDTln2x1joiq6M31+Jk9ePTnW3hLX9Cw2JKeFQ9OyOC
         pLa4HK8uynVnEvvqWFbghkpoOfiHyXSXDhgqaNEL6N+Cu0gyGIVZYl54u1wrwt5uK1xb
         efvtzwWpNujlyA1aWLWrfUxMoYYoOTbPCscoTIAZagaBvTBTBjcY/oE/BN8bGfYgu+z3
         GZ/m6hod32/NgInaSAj/ErMpQI4uOcqp21x6NuO4IKKkmdqajbpeWP/2lfc6QxYNr78T
         BhTz0WzbmDGPeaG/iW9EWgneFcRIkB87G+IGwL1YTqSwIyeBqQuzzW2JXm3ZGwfddyQa
         9fkw==
X-Gm-Message-State: AFq9FYL0WQYd437V6P2kJYFJ36JLUlHXEr+qeZa6/NU8pl6LMQWZjB2y
	zwTlK5HFZgDXaCJo5ATbENtGTfhD4QtiBiTQNOvBpJfZjUDagLuFAkAq74cm9Q==
X-Gm-Gg: AYBFou2Z25WS3AoeUV7VmKgWdRp5igX1v2Rkld+RfSJxV5phKZ6jnNpKAM9JrqNHfnx
	ULqkmyXUOSFsE8Be2aJDTpzts2etnAdDFouAXgRmpyPg3tJP9rq+kEMDhP4I5uimiY3rqWHTEF8
	UbEIdrAvUf0+CLIkWneuaupMBbCZucfuIsrcv6G026acCR1NGVOk4WGiYfAy8aZgY5m6lsKsWvG
	y7XuQR/7Iz1SxyLHnJOV+U+iP3HVPte/83IcWzIfDhYo9VPUtOHhlGAjbF6BIq55VDsVanM/Gz6
	CjCCU9Q4lMySLDZabJHfSc4+xQdAYI/U4XlWKcjB8/ha8I2xg/nAPzs5b1OwsukRFMrmDOrL1Fq
	//HnP5V4lUP14tvvmvLrdAYyXyHgLmv7lgKxRjOG/2nH6v0VUINpOQkidmTWTI3zSueFLTHxQ//
	P6pxBVcU4XtyPoFdLsPhjiE0iui/9fGwPZ6aMs8NT5kU/6GFthnVBk9O2eFI9ylWUxGQp+OLK/J
	Qc=
X-Received: by 2002:a05:7022:f681:b0:143:26eb:18ea with SMTP id a92af1059eb24-16a638513f3mr7295460c88.29.1791625968106;
        Sat, 10 Oct 2026 02:52:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.59.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm25792971c88.13.2026.10.10.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:52:47 -0700 (PDT)
Message-ID: <6aca0aef.b153898d.8beaa.deb8@mx.google.com>
Date: Sat, 10 Oct 2026 02:52:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8340015974205474378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] device: fix loss BREDR info when merge duplicate device
In-Reply-To: <20261010-device-merge-v1-1-65e5e1a79d91@amlogic.com>
References: <20261010-device-merge-v1-1-65e5e1a79d91@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8340015974205474378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182833/

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      15.21 seconds
BluezMake                     PASS      279.65 seconds
CheckSmatch                   PASS      214.98 seconds
bluezmakeextell               PASS      70.40 seconds
TestFunctional                FAIL      993.87 seconds
IncrementalBuild              PASS      274.63 seconds
ScanBuild                     PASS      787.75 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f62564b2510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f62564b2510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f62564b2510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f62564b2510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2656

---
Regards,
Linux Bluetooth


--===============8340015974205474378==--
