Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964853ED02
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079894; cv=none; b=bi56LBJ0WuqIF5POClCXLployDTJOEL1o1v6x4elgWnMwrEwZZ6unSV8wQ4mNOnDOAucLzHMPDxxcjpakGLIRcRdBa8GzMh1n6fuzW3Vor2NzgvBV9D1//4YY3VBcYKtZzAqASSqVI5a73VH4IKUGOKttGcFSUhyw/vZDXanSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079894; c=relaxed/simple;
	bh=PUMsQXaZYs7xx5th773q9fFBQYCMyMRG0DK/AgmfWP0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=utt3upqELpreWF6bTxdpcyAxFhwIxyTerau/FUkd8h/81FSxWp23Fls1kRduw0wiYNnioBKYl6TWweIQGFfIt27rNK1YunJdRdEqhhDWqrcWpsOLVr4N2k+FXo9Pd2zI8y+7uxmJHWH6E7QMPjQvg4E59nQDiK8U/vY027dZLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue58P8PW; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue58P8PW"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a3a9768so3080440b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079891; x=1790684691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SAfAuQxxx7a+M2TfY61qhc1Dk+t9B35EA9kqmRm0MTo=;
        b=Ue58P8PW9WD243O13ps+YxIuQAjh8uGyrIW/ChnJv3OTybUg0O9826a4FkMkc/eawK
         U091aG02oSACzhpWnZ1NP0j7uYCWSPe1loT105B1bJDxfL+jijSiMK1Q8MIDw+nBFYi8
         kqxTSrOohwM6mqoidRiX1k/v37rUZz+2GAsSz+X2FTXaRfQeztI+XOc7GX7MLiQ8zWrP
         aa9ie+37KvG+F3+mIDCJhLtcdi2ydausJL6Ka/iK8dNvzPKlcGAv7b/AncjJhPgI8p5t
         F3BqTjwKmPo5Ywf08w0wKwbnYDns03ohfwOq3s1Dwslxab2BvqDi024O2HBbxSPrH8dn
         aWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079891; x=1790684691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SAfAuQxxx7a+M2TfY61qhc1Dk+t9B35EA9kqmRm0MTo=;
        b=2CX9rHumk5tR6FChyPXCT9in8vjA1HEnh4wY5loZFZTvCuIgR9xG+Rpjc+4LdEQSkR
         HfsjiwHpy4WFOTeZyFppjHKgeESJopDqcRPx3cQDLoXOcUjyJskIK8tGAWmej72KFhkU
         0msspQY87BjsA4aSV9h1/r6L/YTHYzTcc6JS5C1yIVy98+3ZwkDoSuqu3YT2OKKPMOi7
         uPg3zQJfTzKyl6a44jjkIR9MHS6TCCESl9SJHNitl/6ankBYx9AUn++l3p39YCTXfPwn
         Pd7/5pu6iY4yvoBskPXlOEBuPmZuf7PFFnnJUZiADJKWcwa9q2fM+vKQBEAaEU1S1vEc
         mfEw==
X-Gm-Message-State: AFuF++ll0Ta5sGGE6kZ0Zdr8JV+96Sx2r00YfbhX/TPUgSjoE76B7JZ8
	5laJbBO2L6Uh+dtu40snBWOOq5gJqVCc+DFJaEOWhONAKsbVGNqUfTeUl+1l4+0s
X-Gm-Gg: AYBFou3OMRR6j3fXg+RVSFTGAGeeBUx1K4mAbeWGWFJhirWm48CvZuH8jg53jAj42Ae
	zjoOoR9hHfzhhkwPAk/D1n8XixNoBechywwM0H0fnN6ogrgsoZfScEfwBXo+OPdQlAQoI2M2ENv
	cX4dTQYme1Js7Hcs4l9MIR2FMCGczpGrudlj/JHKOONZknKpRuUzvNZzKL+wOJpIG6e+aJr+qjk
	BTid0nhNEqfHdwR7Pii3OKzmXdFGHdIMTFi4QIOHlzChP2hxgmNJINiOgPXQ2mVIINScwBLGWJp
	P1byhzeNMqGQNlrv70X4vFlJjcbBV8SNZ4acmXl8RfIXIeMB+OL1isXep9QTxRLP/7Kpg3yJGrF
	zSET1WMBQarPmcva91Na5FpPKrTX2UG2zyvtn4x+TzUgc60XmtenFlKchBLyItsIvdLG9otv+Qm
	m6wMmh4wy6HZZTJcbTSYiUQ1HQ1ZguCSPxGMCHHRTbjz2uOHoVKITUmDdgwC50d4unhH//d7O4C
	nbUNPc=
X-Received: by 2002:a05:6808:199c:b0:4b9:e5fa:890a with SMTP id 5614622812f47-4ccf893b4dcmr15744864b6e.29.1790079890647;
        Tue, 22 Sep 2026 05:24:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.230.153])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d4c16c7d2asm1130778b6e.13.2026.09.22.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:24:49 -0700 (PDT)
Message-ID: <6ab27391.dd457072.37cb9e.1e86@mx.google.com>
Date: Tue, 22 Sep 2026 05:24:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8988439245234866007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: [BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
In-Reply-To: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
References: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8988439245234866007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1171262/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      14.57 seconds
BluezMake                     PASS      228.44 seconds
CheckSmatch                   PASS      176.03 seconds
bluezmakeextell               PASS      65.22 seconds
TestFunctional                FAIL      909.09 seconds
IncrementalBuild              PASS      224.88 seconds
ScanBuild                     PASS      635.16 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"
FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
    searcher: searcher_re:
        0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
        1: re.compile(b'(Device \\S+ not available)')
        2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
        3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
        4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
        searcher: searcher_re:
            0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
            1: re.compile(b'(Device \\S+ not available)')
            2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
            3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
            4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"


https://github.com/bluez/bluez/pull/2566

---
Regards,
Linux Bluetooth


--===============8988439245234866007==--
