Received: from mail-wr2-f20.google.com (mail-wr2-f20.google.com [74.125.225.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE754EEAD
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176801; cv=none; b=thKiaLjcCFRjz3Do3gDAqEHgZSNmHvnt9/9xMIux++xwsae8oGcbP9GPLGiFddVd8Yc1i5FG4/015CbVZeF5N7N+6veaP1XJNZIbTCSHAdzH5nAEREU3EHjOZDaKuiiAIpCxd1BZBtSvZthDS3Q5Bvz2OzP3HSmOLQSyRc79rik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176801; c=relaxed/simple;
	bh=IpX7s9sD2SJ6Vh3wv+PA5CUDmk+Gh5MmCtwPY+xbKWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=msOvLnf82ltCZV3KAidg2DO3zqn99rtBYyprL9OzzXXd/iL4LAeEIWfiTJGBUvPCzVYT5zN5WazKIIeVgZJ6wn/esZD7eeLq8ZWHkVqlrvQRYLwbNuaEtyWB92kyjMA9lS0CAH3wlPu2goEGLz+fXzTJn6ZHpLIOnhDp6oyYSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=IdyJpFgG; arc=none smtp.client-ip=74.125.225.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="IdyJpFgG"
Received: by mail-wr2-f20.google.com with SMTP id ffacd0b85a97d-482f6356256so390384f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1790176795; x=1790781595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpLtUIdAS32+TeIAyOIp7sheWUBHL/dS4EF5FKpV+ZE=;
        b=IdyJpFgGAaZFWUHn7cM2nwSHztR2hmqLqVQZ6eVkiNAqQhVyZB3PEtZfevILTody1V
         1EdpF9QOpfXALoZbSyexz7jdum6KpfE8QsFuaWVmjqmowycINUr1ofdVcUiA0wXFbbd7
         YLmxh6+54PgcnW5sx+nxHBS4ieMXF922Pg9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176795; x=1790781595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpLtUIdAS32+TeIAyOIp7sheWUBHL/dS4EF5FKpV+ZE=;
        b=ez1owQDi4YUhl73m0fw2QaJ7SfNrhGGZe0H7HgUxKjio+hzte3Hprhr3mbFM+SQlLW
         x6IR79vnYYUxUnPY9AJmCZY6n198MIZJd/DN7AKxc5nNdmrJf5creFrUcm+jJJZrJAQy
         Jm+TR9/6tcHyKN3iZsgfx9L0VTeCBkvXDaWQhthqkP9v5J5GqDs1ZW+Lj44SKK+DJDUT
         lR0I9s8bPf08rV20BLEoZjQBMNA52pNQ3mYMnF1H37GFueRszS2e0W5p7DRP2f87ejks
         X2/rauX+hJHYqGqM1xlReO5k+1rKBGFaDRnEzwkexCr8qHEj19fRs1VBPn7hWFy48lvD
         4SCw==
X-Forwarded-Encrypted: i=1; AKwUvBx9zxLZTq4BKzt2omy2cNF4h7wfx9k+398OzkjJcfbzCckhLDYlu/NJbCbYEofIZbEJjsXnWRpKzp0lPrmauEU=@vger.kernel.org
X-Gm-Message-State: AFuF++k8zt5HB+Jcu9C0+mm3Yr2O++yGRx8MSznB4/I3La20UsC575ED
	s1KCd5zPou3lbaIrx9JwKyPdqQZfOyBv8E/3IVzaEXli9cnIdPJsogyX56QbI+R6Pw==
X-Gm-Gg: AYBFou06h0KoEwNJdInh4wsQ55A0pb8jS1tMwCNTx2fEb97fDvM3SllGDVgvqmj/P8v
	LNhcnelJDzJw4V+abr2M1/gPcBi3UzbW0fJodCR7JerVURj0eENPwWgQH5xwRIxlI4ixRsmXj1K
	SoW0NhD0aAQZ3g6H2vh+EJKtE8SJi4R369xFxLQEdqY16npaoJxwULZamjePhmJYld3BXOuO6Ay
	wgVoo0fqoMsEIwURDUPk+1GhXtLRvuXx9GLWj6tbE9PLc/iok3I6n0nfsplG+wb/lwEFr1+6ZFH
	8EWJ0ySckWCNe9yZ7n3vM2053aohL7MN1N5QuIK6ysefQ6n8mK/9HVUvnhdO8dfPrCH7lcfjdhP
	rQAbxfos4QuDa+qDcQgxVT835mBTXsno9AbKAyq2UhcNYl0I7Llbqbe+OG1qAmvLlIb8rYJMD8Q
	W2Hsk2zas98r7j9OLAo9AW253+tcqK1YF+RS5xndyDSP2pcZy68EIpWnSdr2Mc0TMShCaA74Q8i
	xum9ygxxkC3G9+u9I636Y+ETnSx9MYArco74axhNAe35Fo=
X-Received: by 2002:a05:600c:1f90:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fde20e848mr45212555e9.0.1790176795253;
        Wed, 23 Sep 2026 08:19:55 -0700 (PDT)
Received: from [192.168.1.186] (public-gprs180755.centertel.pl. [46.134.45.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1a0e00sm72027285e9.10.2026.09.23.08.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:19:54 -0700 (PDT)
Message-ID: <0667c660-e0ad-4aba-a4de-947cb54bd204@streamunlimited.com>
Date: Wed, 23 Sep 2026 17:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BlueZ] adapter: remove bondable mode hijacking when setting IO
 capabilities
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
 <6ab27391.dd457072.37cb9e.1e86@mx.google.com>
 <CABBYNZJd83=-_a8=LPvfKSoRWZ_bYEDAYu1nXVrnDr4ezyAMtg@mail.gmail.com>
Content-Language: en-US
From: Michal Dzik <michal.dzik@streamunlimited.com>
In-Reply-To: <CABBYNZJd83=-_a8=LPvfKSoRWZ_bYEDAYu1nXVrnDr4ezyAMtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,
The worst part is that those two tests 
(test_bap_unicast_set_transport_created, 
test_bap_unicast_set_transport_acquire) are always failing on my PC. 
Every time, even on clean master branch. I guess I have to hold this for 
now and get back when I have more time to dig deeper into those bap tests.
Michal

On 22/09/2026 17:12, Luiz Augusto von Dentz wrote:
> Hi Michal,
>
> On Tue, Sep 22, 2026 at 8:34 AM <bluez.test.bot@gmail.com> wrote:
>> This is automated email and please do not reply to this email!
>>
>> Dear submitter,
>>
>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/series/1171262/
>>
>> ---Test result---
>>
>> Test Summary:
>> CheckPatch                    PASS      0.34 seconds
>> GitLint                       PASS      0.26 seconds
>> BuildEll                      PASS      14.57 seconds
>> BluezMake                     PASS      228.44 seconds
>> CheckSmatch                   PASS      176.03 seconds
>> bluezmakeextell               PASS      65.22 seconds
>> TestFunctional                FAIL      909.09 seconds
>> IncrementalBuild              PASS      224.88 seconds
>> ScanBuild                     PASS      635.16 seconds
>>
>> Details
>> ##############################
>> Test: TestFunctional - FAIL
>> Desc: Run test-functional
>> Output:
>> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      Remote traceback:
>>          Traceback (most recent call last):
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
>>              result = method(*msg["a"], **msg["kw"])
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
>>              return getattr(self.plugins[name], method)(*a, **kw)
>>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 441, in expect
>>              ret = ctl.expect(*a, **kw)
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
>>              return self.expect_list(compiled_pattern_list,
>>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>>                      timeout, searchwindowsize, async_)
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
>>              return exp.expect_loop(timeout)
>>                     ~~~~~~~~~~~~~~~^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
>>              return self.timeout(e)
>>                     ~~~~~~~~~~~~^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
>>              raise exc
>>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"
>> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      Remote traceback:
>>          Traceback (most recent call last):
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
>>              result = method(*msg["a"], **msg["kw"])
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
>>              return getattr(self.plugins[name], method)(*a, **kw)
>>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 441, in expect
>>              ret = ctl.expect(*a, **kw)
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
>>              return self.expect_list(compiled_pattern_list,
>>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>>                      timeout, searchwindowsize, async_)
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
>>              return exp.expect_loop(timeout)
>>                     ~~~~~~~~~~~~~~~^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
>>              return self.timeout(e)
>>                     ~~~~~~~~~~~~^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
>>              raise exc
>>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"
>> FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>      searcher: searcher_re:
>>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>          1: re.compile(b'(Device \\S+ not available)')
>>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>      Remote traceback:
>>          Traceback (most recent call last):
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
>>              result = method(*msg["a"], **msg["kw"])
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
>>              return getattr(self.plugins[name], method)(*a, **kw)
>>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>            File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 441, in expect
>>              ret = ctl.expect(*a, **kw)
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
>>              return self.expect_list(compiled_pattern_list,
>>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>>                      timeout, searchwindowsize, async_)
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
>>              return exp.expect_loop(timeout)
>>                     ~~~~~~~~~~~~~~~^^^^^^^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
>>              return self.timeout(e)
>>                     ~~~~~~~~~~~~^^^
>>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
>>              raise exc
>>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')
>>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>>          searcher: searcher_re:
>>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>>              1: re.compile(b'(Device \\S+ not available)')
>>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f081d63e70ae1f86')
>>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/pac_sink\\d+/fd\\d+)')"
>>
>>
>> https://github.com/bluez/bluez/pull/2566
> This one seems to be causing some instability on test-functional. I'm
> not quite sure why but I'm afraid it is related to changing the
> bonding behavior.
>
>
-- 
Michał Dzik
Software Engineer

StreamUnlimited Engineering GmbH - part of Bose Audio Technology
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria

michal.dzik@streamunlimited.com, www.streamunlimited.com
Offices: Vienna | Bratislava | Shenzhen | Osaka | Boston

