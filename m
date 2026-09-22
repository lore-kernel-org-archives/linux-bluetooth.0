Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64539F17F
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089962; cv=pass; b=jvlt7ucHEwVydNYBmAzaUGVDL4Rod9JDvAcLtVqTcFZ+DRSejQCVKLkc0MX+u34GRYwSd7IiC9NgSH496LOOc8WzlQFBiXl8I6XUGp2P+9fVv2sKDwwyZZ26lRgcpeggPVQaZp3AY+HGaS5LVl7BOa17puZslFjAEw9Zl2WWgBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089962; c=relaxed/simple;
	bh=lnugQV47j+2Wzy05gLx7k4Di1odZna+TuuTJZWGFv4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLvtUxnBs/Yy4peEt3uW1n7tHHY/Fpscsl6whyEanJ7W9XfeU3MsDHfOkg34u13VVzJb16FOJOhXfKGXb7QUAk9fXAc9B/GlMmAaGO25PdDpyx/hd2zHBpX75Rt2oL9BWn55KafbvwvoXHOiKOs5ich/FyB431nmtRbP5ofpZlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvOgIxlp; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvOgIxlp"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aac92dbso3617130d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 08:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790089959; cv=none;
        d=google.com; s=arc-20260327;
        b=NgzyZcXyz/g2qg3HcpArsOFpmd3lxqLDKrSu5weX1FkWK0NcX3R8jIa+EKNb/Q4aQq
         g+8mBW6dOutnFVzsJkVYt3UWhCpOK/BZzGfYSYWCqDw4iw+gedro036m//SvO+1C0/by
         BMQZJVzJK/kgpAzQNGW3gzl1QIC4NK0b4BHypM3SL/b71LVHG7yGqdEspYXfrW1A2rjW
         hBchd4TZpYPXUkwcw4JANvQXBYef6flDj2/DKHZiAsbjQvn/YJWVVnMhw/DHnXHCeGoq
         zMirLhMTDvKiRposFA8WWA0jP/62cvpE+ByuZyPnijjXSR6p7wyB7ZoWmYbyMCeW69X/
         +B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pByG0BDOcJ/NiMyeaXzJR4c48OoqSmQ9WsMWyqbLc1I=;
        fh=McCiAS8kuGDTbzCniZF97DH2PZzhiRZp0V7v2BiXfa4=;
        b=rH8MKei1G+DValdDpw7s7KKUh7Ig1tw2YKmuRy98TVgcutCkfIss6dj9tiGe8q3xQ8
         TTc4BAnuWHJT8WRSVEKME7A/f/gJAAYl03FTt6ZXBdR2uY6vQGCySHfW0eguz2BfP4To
         jjrH7Br3VTzc5pXakViNStocQLRGkdbI4ZKo9d30QtYjNJ+u7UTy3x47V5d3csNfsJbK
         4WKQQZixpXI8/MGIr7yinp/6uNTpIrF+yklfo264AIgdTbbGm7b8I53cNLBvZeaJPisn
         U5WAxD8ZNz0AcbUYR/4nTaxhQyCzr/X4y1NyJc53JjlNa/UZIiH0LfahUjj1verSR+sN
         Y4lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089959; x=1790694759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pByG0BDOcJ/NiMyeaXzJR4c48OoqSmQ9WsMWyqbLc1I=;
        b=fvOgIxlp0ZwIXExSz8Dt5MQnUPtFPVrCz/va7BgWq/2dpbyqW6qqzYVj2DMifDQ2T9
         N9X0x1eDAK2L9Q4EYz2fXfr8Zregxk+02QZJVbTe5eo8PuWTwQbuYec5YUltiq6RQVd5
         nHLfC6nYpRRB86QX/1kcdASIZ0Z9141RGo8oHr61DB4vHuoUZ6NNnn8bhv3Ki1BlTw5k
         al3joEhrWBA3hV0M8tk9n+BLYCDmWemIQY9lK2k2ai10RuQfeBdWVAs34qyMhoRBJ8kg
         Z8jwPSjzfVWiAg9jEuT+sZ0f7d8w5ZrBZxaIDprMOMz75TItCzAQ174HAfX5lEAKy+hy
         Yp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089959; x=1790694759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pByG0BDOcJ/NiMyeaXzJR4c48OoqSmQ9WsMWyqbLc1I=;
        b=iSRuq36Tl2k6IrgHyOGJ32+nucH7PhAPQWtEbJS2ru9eooiG5u2P+aXz6fpEaSayBV
         5deB82MKV+AmL/7zR7HE9asQHfUzJREnd9gSXJSyGWLCLIflfAs7fVrJaPTMH4GEE/Of
         xAXWTKnWaLS4AtJfRL1vtSkkWSays0BtEerD2zS1vZtRaWbJLc9oaLQJmNb79tBPAX21
         BJjk6Blv7xot9NDnEEG2Q+Kdd/rUj0iAc5KNnv3/FqtXH9siLKD8LYPTrDrf26xyqas0
         4FfEwU/+2Cd6ZLKno8Smo9Tu2xcwhaPs4ts2DiBOwfWhCoyADOki1Mb/HXzQhTDKFO7y
         H/Eg==
X-Gm-Message-State: AFuF++m812oBG3/Yw8YYWId8NtE8MofEfk5wUIVas49pSe5xKHqy+rsU
	Qk53dr3SaPJl1Mvj6FAEHpfuq52vCsygXdYJH5oHgwgl1zJ48nKmIh7YW9ItATnX6MEV5AqF3xT
	YNdk8RCXAkjUFy8ZTo2TarEz9VHGXGQz1LWzzg1U=
X-Gm-Gg: AYBFou3Oy7ZysGrNLZPmxwGIVlYBVo6goHtjXf7N8yVvc79Y1IUkBd6+bH0NyuoZcFQ
	T6JsSsYrFsf4a3oqazCcuvaloIQHTKoXku3uc2HVFSnVMa6JRd5lwSMJiMnOhoitramQ8k5pCXA
	78KSQY6h7WcHmIRq4qwmqWTqXg86hXQFhU973uX++iuD1dzk+Ww1Qlv1PyA8lzCbvVvXEuRZY2z
	QSGj8HfEwq+rHMLN6WLuBPnAs+0m6DkCb7I3x37gPTkUm9go2IjOLQIjKpCM/Byvw0/jeqyGlbq
	yiNzR3yd6Oe0g2WjEkMWxt7ZKPdvvJ0m0t7vKO5XFRPhBzlBxr8abD3/gSsbWWoasqwEvRODrLH
	Y3XFucn34WkwRFUnxL1no0iELExN7UubWABzRn520fw==
X-Received: by 2002:a05:690e:43cb:b0:66f:c1be:a65d with SMTP id
 956f58d0204a3-6717fdcc606mr3883133d50.79.1790089958679; Tue, 22 Sep 2026
 08:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922111249.415422-1-michal.dzik@streamunlimited.com> <6ab27391.dd457072.37cb9e.1e86@mx.google.com>
In-Reply-To: <6ab27391.dd457072.37cb9e.1e86@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Sep 2026 11:12:26 -0400
X-Gm-Features: AcwNN1XyqCispXHAHoGSkwX5bAHBpXR42DxM93X0kihGSo5iK5xrpLJlU8xWVrU
Message-ID: <CABBYNZJd83=-_a8=LPvfKSoRWZ_bYEDAYu1nXVrnDr4ezyAMtg@mail.gmail.com>
Subject: Re: [BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
To: linux-bluetooth@vger.kernel.org
Cc: michal.dzik@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Tue, Sep 22, 2026 at 8:34=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1171262/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.34 seconds
> GitLint                       PASS      0.26 seconds
> BuildEll                      PASS      14.57 seconds
> BluezMake                     PASS      228.44 seconds
> CheckSmatch                   PASS      176.03 seconds
> bluezmakeextell               PASS      65.22 seconds
> TestFunctional                FAIL      909.09 seconds
> IncrementalBuild              PASS      224.88 seconds
> ScanBuild                     PASS      635.16 seconds
>
> Details
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-v=
m3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.pop=
en_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 256, in call_plugin
>             return getattr(self.plugins[name], method)(*a, **kw)
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/host_plugins.py", line 441, in expect
>             ret =3D ctl.expect(*a, **kw)
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 354, in expect
>             return self.expect_list(compiled_pattern_list,
>                    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>                     timeout, searchwindowsize, async_)
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 383, in expect_list
>             return exp.expect_loop(timeout)
>                    ~~~~~~~~~~~~~~~^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
81, in expect_loop
>             return self.timeout(e)
>                    ~~~~~~~~~~~~^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
44, in timeout
>             raise exc
>         pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn objec=
t at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
>         <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')"
> FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts8-v=
m3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect=
.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 256, in call_plugin
>             return getattr(self.plugins[name], method)(*a, **kw)
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/host_plugins.py", line 441, in expect
>             ret =3D ctl.expect(*a, **kw)
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 354, in expect
>             return self.expect_list(compiled_pattern_list,
>                    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>                     timeout, searchwindowsize, async_)
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 383, in expect_list
>             return exp.expect_loop(timeout)
>                    ~~~~~~~~~~~~~~~^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
81, in expect_loop
>             return self.timeout(e)
>                    ~~~~~~~~~~~~^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
44, in timeout
>             raise exc
>         pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn objec=
t at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
>         <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')"
> FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts8-v=
m3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: <pexpect.popen_=
spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>     searcher: searcher_re:
>         0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>         1: re.compile(b'(Device \\S+ not available)')
>         2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc5f08=
1d63e70ae1f86')
>         3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>         4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00_42/=
pac_sink\\d+/fd\\d+)')
>     Remote traceback:
>         Traceback (most recent call last):
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/rpc.py", line 102, in server_stream
>             result =3D method(*msg["a"], **msg["kw"])
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/env.py", line 256, in call_plugin
>             return getattr(self.plugins[name], method)(*a, **kw)
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/.=
./pytest_bluezenv/host_plugins.py", line 441, in expect
>             ret =3D ctl.expect(*a, **kw)
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 354, in expect
>             return self.expect_list(compiled_pattern_list,
>                    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
>                     timeout, searchwindowsize, async_)
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", lin=
e 383, in expect_list
>             return exp.expect_loop(timeout)
>                    ~~~~~~~~~~~~~~~^^^^^^^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
81, in expect_loop
>             return self.timeout(e)
>                    ~~~~~~~~~~~~^^^
>           File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 1=
44, in timeout
>             raise exc
>         pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn objec=
t at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')
>         <pexpect.popen_spawn.PopenSpawn object at 0x7f83a2bc2a50>
>         searcher: searcher_re:
>             0: re.compile(b'(Failed to \\w+[^\\r\\n]*)')
>             1: re.compile(b'(Device \\S+ not available)')
>             2: re.compile(b'DeviceSet /org/bluez/hci0/set_fb34645b15340bc=
5f081d63e70ae1f86')
>             3: re.compile(b'Device 00:AA:01:02:00:42 Bonded: yes')
>             4: re.compile(b'Transport (/org/bluez/hci0/dev_00_AA_01_02_00=
_42/pac_sink\\d+/fd\\d+)')"
>
>
> https://github.com/bluez/bluez/pull/2566

This one seems to be causing some instability on test-functional. I'm
not quite sure why but I'm afraid it is related to changing the
bonding behavior.


--=20
Luiz Augusto von Dentz
