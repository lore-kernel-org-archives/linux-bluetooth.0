Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FC233949
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178745; cv=pass; b=hv8399tjW/ouY/nNr7bWr3kofC1NCP+SbNbMzNIQU3VopHVOxtiSVuZ8v7/nv4jiiOx6ckUAbVaDFtB11e4SEMkFnv0mt19I9F+VtbCpQxBLghIBmlDYG067/FCYVq3UeY2AAD58RBB1bmH6AiE0c+9phEvu1r6DT5EzMtbe+/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178745; c=relaxed/simple;
	bh=CDVtW/5JEenEI7vT7y+SOU5Hvimn12td9muEIkb3kUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGGW7G+JIfphfAhpPZ5118Gx6FT7WnZyds/s7LVGNH2lvKtiXKwl6ijLRDwkRU4MrxkY1XKEVnq3pl0syTghrXofohpw8LG3uQcCJjLUznNalXhZmQaA0EPAZ0ysOXLx8E44MuvBqRScUUObidSjctqj4f/TYh92xGH0pjQw2rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbZoBSWP; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbZoBSWP"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011cso15434517b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 08:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790178742; cv=none;
        d=google.com; s=arc-20260327;
        b=oMzx7lf/0IwXlY/yI52Naaen/XM9QbPF8FlZKbE0DPiN4yq9wkfERT1MR0/0O4ya17
         ZoYFg0/4zKCe03HVrCU//QMD84016V0oV/nQcM/OyxMRl8/ttJumR/2KjO2xam1gD30I
         Fxzjpc3J7GjT24X2Zzc7lw3g6OnFUlECg58E9OMfQtq7xVeI0KHq8BFoLLgc+wSgnAzI
         q71gh+l8YUaxTHwgjfjAZe9eS56Ns8I9lJHeIibbFOzI5bH7WzCUoEDS6S4M5H0qQ0Fm
         r3b6MvdRYn4rb1CyIZkbJVtuIFIWKEyq2wNKbl13rDd3O3RWmwh1Mda4TdHV1JyTVzr6
         8ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RT4LT2fxym8AtTYgUYPLnZg+k1Li3caFJnIKnXFWfE=;
        fh=1K7M3FjntfzuPoN0fuUH3r7WVaWhgGUkd0CT0Qb+gKg=;
        b=qY9huDpyA4xJ1UiBIBEbogfjOFYFlVgK7rZxELtO2dMzaZB6x+gJVuto9+3Bi9onPU
         gP7xYdQHVCivJbhULJLwZrnIwKwQmqSFDadNUY0b/nq1EZtj9WS4N/az7/oXLOQ9zCpM
         HcsRcUY+fOfdp9oumlgYU++zQNSH46G5p9SQBRi99RojMOykyte3bBr7p4oFssEySTD7
         NLZ/TNY8jchb49yEDMzxzfCaIUzQj7tI+I5ixQk/bviVgXey2wLEc/p1f33yGK+Mxm5P
         8UNR1kjfWuSkDz1ekJm8Xt2U8gk5wIjVCaTA0IXSXxvcGu/RCfqZDoBFizmW48ZBtDXA
         Bu3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178742; x=1790783542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7RT4LT2fxym8AtTYgUYPLnZg+k1Li3caFJnIKnXFWfE=;
        b=XbZoBSWPuSwxxNh8iarOCQpLdLCc0mgiNgVpu2of0vPIYV0qmbCgbQAsUd5mFNSAjz
         g5qvT0EEr9SP3f0mH3CR+jjDo/i7Rzrc0PEK8Ro1KYro6E5X8Q2hKMM9KvA8jw54lBvL
         iw9RHH4OSvfjDCVJmY4xRVzU+sEb5CafiQ8ugW7iZ6Pc7+R0Laj0pEamEkzC55SUsw49
         r+Ul8T7rdjF7RAjD/CxSiwXEVuXA9WJC1g3Xb3mWdgUVwPABzgwufkgfbFa8QS/kYFe5
         mUNiLHuE1Qjra40gbvJNdzQsnUFAWf5Ua1kILgEZ92Dh6x7TaTAycbCC7U8mLeYvCrhP
         twkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178742; x=1790783542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RT4LT2fxym8AtTYgUYPLnZg+k1Li3caFJnIKnXFWfE=;
        b=GW1LOjlLjLqlO9IXJ9YMNUXhU/IWiI7p1joG9HVoC0eN7yPag0qtHFAUvitT6DQ5Y6
         5HVKElGVljmZw5UdgXghUotiv7RSc33evbLn/dVYcJVbVTRIx8fMNV0OudXuGRFI4XcH
         4U46Agntg6zfcF2qWagjJvLeykjVtB3DCn8L1God+ywJbDZFGIA2yH3taQx5yfBUwuuv
         szhrrtiNoBANsCXQycJkLF2KbTZMevWj7c9rdPLIHtF7n6eXXKv6NDM+WE/KldpubA+9
         oqzKTnI2+SLssfO15D71CHbT7WP5xnppMWTDYN85qXFzk9VoUTVOkTr+WYaTVI3y6kLB
         iV0Q==
X-Gm-Message-State: AFuF++njG+01mgrsWEBNZMOdA42RHFF6SuuxV9nN/PyNF4W6Enb1EghF
	xD06SPyjDrwUuMx1n0X7dt1WEWMDrp3Q2+s5ZFAcCAb3C/QqoHGnFNfcOOxB1Jr8ChLJs1d8wbN
	zgIVuuH1wIWjOMoqB4nZVVz8xKms+rXcz9+ztx3pvZg==
X-Gm-Gg: AYBFou3no0JORMvm4dak2mu5dSJ/wh9h54F2Ba4/SjgTpU40cv/K2ygBMJnKP2EJpsG
	G/4g2zAZolPnOFzuOTM53hI7HUEXhdiiuFaqhMwhQ9oelHRqZLVSop09XcZdsKRgMZe6G21KJ00
	3bwfbfCFDPquOT5mOznlwXzo1OkfoAn1O9KdOcJQuf+ggdeT8RFW2rUW01RBU+2fPL7guZQg85C
	8UBrTZGBiiWYATk7UwUZl0l8l5Xm7OX6OqQ/fkWGIbZQ/tSxjSaJispI6MpKgqV+tBMXIpraxEJ
	R0Y62o684Q+XCteJfN7PsfQ16PDxTk582if7W8WDf9bqJIL5oxrNI49DAXifT1bqujoVMYSCZMG
	QK66ndPMG8zJfg1vNtLRg0Xa7rJCWS1NOTR2HTTM=
X-Received: by 2002:a05:690c:c741:b0:862:2e2b:8639 with SMTP id
 00721157ae682-8a4599fcc24mr12131287b3.33.1790178742492; Wed, 23 Sep 2026
 08:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
 <6ab27391.dd457072.37cb9e.1e86@mx.google.com> <CABBYNZJd83=-_a8=LPvfKSoRWZ_bYEDAYu1nXVrnDr4ezyAMtg@mail.gmail.com>
 <0667c660-e0ad-4aba-a4de-947cb54bd204@streamunlimited.com>
In-Reply-To: <0667c660-e0ad-4aba-a4de-947cb54bd204@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Sep 2026 11:52:10 -0400
X-Gm-Features: AcwNN1WnxkaxGDZz4xfUzlb9lzXz7khykNSD9EKvQF6EtdknRVp0_YHWUoiW3nk
Message-ID: <CABBYNZKurtFG2eCa2E1dX9Bc5UYK3AvsjUZTMhwjZoKZsuJRhA@mail.gmail.com>
Subject: Re: [BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, Sep 23, 2026 at 11:19=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> Hi Luiz,
> The worst part is that those two tests
> (test_bap_unicast_set_transport_created,
> test_bap_unicast_set_transport_acquire) are always failing on my PC.
> Every time, even on clean master branch. I guess I have to hold this for
> now and get back when I have more time to dig deeper into those bap tests=
.
> Michal

We have 2 options, make them unstable, or try to fix them in your
machine, it also looks like there is some instability in the CI as
well so it is worth checking if it is not the same.

> On 22/09/2026 17:12, Luiz Augusto von Dentz wrote:
> > Hi Michal,
> >
> > On Tue, Sep 22, 2026 at 8:34=E2=80=AFAM <bluez.test.bot@gmail.com> wrot=
e:
> >> This is automated email and please do not reply to this email!
> >>
> >> Dear submitter,
> >>
> >> Thank you for submitting the patches to the linux bluetooth mailing li=
st.
> >> This is a CI test results with your patch series:
> >> PW Link:https://patchwork.kernel.org/series/1171262/
> >>
> >> ---Test result---
> >>
> >> Test Summary:
> >> CheckPatch                    PASS      0.34 seconds
> >> GitLint                       PASS      0.26 seconds
> >> BuildEll                      PASS      14.57 seconds
> >> BluezMake                     PASS      228.44 seconds
> >> CheckSmatch                   PASS      176.03 seconds
> >> bluezmakeextell               PASS      65.22 seconds
> >> TestFunctional                FAIL      909.09 seconds
> >> IncrementalBuild              PASS      224.88 seconds
> >> ScanBuild                     PASS      635.16 seconds
> >>
> >> Details
> >> ##############################
> >> Test: TestFunctional - FAIL
> >> Desc: Run test-functional
> >> Output:
> >> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts=
8-vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.=
popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      Remote traceback:
> >>          Traceback (most recent call last):
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/rpc.py", line 102, in server_stream
> >>              result =3D method(*msg["a"], **msg["kw"])
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/env.py", line 256, in call_plugin
> >>              return getattr(self.plugins[name], method)(*a, **kw)
> >>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/host_plugins.py", line 441, in expect
> >>              ret =3D ctl.expect(*a, **kw)
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 354, in expect
> >>              return self.expect_list(compiled_pattern_list,
> >>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> >>                      timeout, searchwindowsize, async_)
> >>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 383, in expect_list
> >>              return exp.expect_loop(timeout)
> >>                     ~~~~~~~~~~~~~~~^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 181, in expect_loop
> >>              return self.timeout(e)
> >>                     ~~~~~~~~~~~~^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 144, in timeout
> >>              raise exc
> >>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn o=
bject at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')
> >>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')"
> >> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts=
8-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexp=
ect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      Remote traceback:
> >>          Traceback (most recent call last):
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/rpc.py", line 102, in server_stream
> >>              result =3D method(*msg["a"], **msg["kw"])
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/env.py", line 256, in call_plugin
> >>              return getattr(self.plugins[name], method)(*a, **kw)
> >>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/host_plugins.py", line 441, in expect
> >>              ret =3D ctl.expect(*a, **kw)
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 354, in expect
> >>              return self.expect_list(compiled_pattern_list,
> >>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> >>                      timeout, searchwindowsize, async_)
> >>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 383, in expect_list
> >>              return exp.expect_loop(timeout)
> >>                     ~~~~~~~~~~~~~~~^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 181, in expect_loop
> >>              return self.timeout(e)
> >>                     ~~~~~~~~~~~~^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 144, in timeout
> >>              raise exc
> >>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn o=
bject at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')
> >>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')"
> >> FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts=
8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.pop=
en_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>      searcher: searcher_re:
> >>          0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>          1: re.compile(b'(Device \\S+ not available)')
> >>          2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
> >>          3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>          4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
> >>      Remote traceback:
> >>          Traceback (most recent call last):
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/rpc.py", line 102, in server_stream
> >>              result =3D method(*msg["a"], **msg["kw"])
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/env.py", line 256, in call_plugin
> >>              return getattr(self.plugins[name], method)(*a, **kw)
> >>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> >>            File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/host_plugins.py", line 441, in expect
> >>              ret =3D ctl.expect(*a, **kw)
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 354, in expect
> >>              return self.expect_list(compiled_pattern_list,
> >>                     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> >>                      timeout, searchwindowsize, async_)
> >>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py",=
 line 383, in expect_list
> >>              return exp.expect_loop(timeout)
> >>                     ~~~~~~~~~~~~~~~^^^^^^^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 181, in expect_loop
> >>              return self.timeout(e)
> >>                     ~~~~~~~~~~~~^^^
> >>            File "/usr/lib/python3/dist-packages/pexpect/expect.py", li=
ne 144, in timeout
> >>              raise exc
> >>          pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn o=
bject at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')
> >>          <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
> >>          searcher: searcher_re:
> >>              0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
> >>              1: re.compile(b'(Device \\S+ not available)')
> >>              2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b153=
40bc5f081d63e70ae1f86')
> >>              3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
> >>              4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_0=
2_00_42/pac_sink\\d+/fd\\d+)')"
> >>
> >>
> >> https://github.com/bluez/bluez/pull/2566
> > This one seems to be causing some instability on test-functional. I'm
> > not quite sure why but I'm afraid it is related to changing the
> > bonding behavior.
> >
> >
> --
> Micha=C5=82 Dzik
> Software Engineer
>
> StreamUnlimited Engineering GmbH - part of Bose Audio Technology
> High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria
>
> michal.dzik@streamunlimited.com, www.streamunlimited.com
> Offices: Vienna | Bratislava | Shenzhen | Osaka | Boston
>


--=20
Luiz Augusto von Dentz
