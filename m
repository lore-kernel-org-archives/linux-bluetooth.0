Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795618741;
	b=e/PYSg+wSeKEJoavr4yZ+CojvlPTZbxpOrYME81kec01Zu6r7rDs3DTPMoqSEZzDoNV8
	 oHKYQLXdj6waO5SIDd6YTrt1gM7aJMzlllWwTBO1gNoG21ZGICf3fiufucW/kx7FoKh4/
	 xcgPrKuOo5wrwxSuADb0jaNkwnsEFYCc3OrtdBgwQvHylQdmTDF2zohe22pP1EnOhwFff
	 W1+0IF8dyYdeWzUzYtuZhuMIvAZ8n9sEuAGsPt/78zQc/mjRsZeWOTBaWGsizYWZ9/jOT
	 JsETZ9s8WB067fzJi7nWwif7pJBlJbWrVsAeykyr1t5taQlQOxmJs/0H7yLhXMEHIEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tIGW3Xzsrr81dqk9D4Vp8vgVx512oU4hyhr1tOSXM84=;
	b=wfYQ9ROIkS2Z0UzLJoFjoMvMroXjaNwbZEnHCl45F5UBi6TqeJQiiSJDx39kyPKjqAIs
	 r3S7mmsSEWi5lUGrgk+9UWcU78oLjTp87sWlLMWuUv04/RhUvcKy+HYASZScF9NK/B+Oi
	 tRic0raN0TC+hPdgnpIRPxkkel6cX2kgnSjCm4jn1LU3R4R3OS84i+RIbyUNqSBD4W+Gh
	 GoKMBMD12jesOXYu9gAQPJit6alr02DR55VyNPr6Oy9ia+psIOgFBIl5MoN8i3g2zyvnc
	 UT+lXowISEqmmbIhU1V+MC9PebVUhVMXhxStU8bJylM80K8hlzOHoBbK2avQVQpY98g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJkZbWWQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCB606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CCB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJkZbWWQ
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67c58f18765so4328669d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795618740; cv=none;
        d=google.com; s=arc-20260327;
        b=hokzHlXEnJlH+cKbbPcpWHoKPnBLIs9NFHi2OM2NGt8BNCjf7pv7FV3adu4kwKm+Oz
         RQlsr0OruIsWmqAG//zBU/KMOhaT2nwfhu4LofZf5JYigNdR1bLWYe9YrqnSk5+krmt2
         jQqF6JnbLGHZYhIoAwWJWbZJNr/sV1/ZFRWIhpH+VTePM2PhFo8AC7Ft5pPQM0NJzabO
         ZKW/C2nUORnPl0L1QJttdugQtGg43Tz5h7QU7kG9parPh7MrZdQE/n2dzBYpDXeoGxxD
         +frGr6swstnnSTVjMoW2PQ+9FAroaXth9XJwL8hG69vfGRdZ527rvtTrdAprQRbn6ZvR
         fNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIGW3Xzsrr81dqk9D4Vp8vgVx512oU4hyhr1tOSXM84=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=MfcohdH/tss03A4ALkhVjABcPCIeIcQFYqaVcC8mZiSewLm7aheP8RY2wwbek0OiAM
         c0QHJxZiQM5s8jsp8KMv5is/mkpj4l0mo7vWf8MJAQJIuDFMjDb3oerGTlgYYDteNz2P
         tPzb2/usPOPESKqj/mVL+ZOAgDlZDPSBhsMIbU5H1xfpvGNrwiLRGFdB+dGFWGNNM1x7
         +qe+oZE5YHiCLsDqhumItc08zcKelAmbnvKrYOkHJd+3pxyMVF6ek8K9VI2vp4XFEBUd
         QWiHUjsWKxS91yRhk7tQ97RI3PQ8ASyguo+D1Lm+nK6PVzun0nGxRfpTbvGVwQIVcDX+
         xYjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795618740; x=1796223540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIGW3Xzsrr81dqk9D4Vp8vgVx512oU4hyhr1tOSXM84=;
        b=OJkZbWWQsj7/x+8/jSqFhj61nHX5uYB0IivOWcjmQym6DbpdsbBMJJk4rF/nrftj9f
         CsYdhIQkNDodbOi4XTjk8kWjwrdbCVc2Kb4L4Os/fxqPEJp6TnW7fEpDumeSVR2pXSbN
         Z56eFl5ZpVmsDaS70fl+Xf23fUMYvGgw9wX162N11ekgLbWHhnEPZKi2zGkrhu9h5okV
         jAuqDzaoRIDiFsVq07xcSzhymbE/smGrZcxXLSjvBbrGXiL1xKUDVknxSJdKt2tcOuyk
         WH+SPeGFLT/iyXlLKHID8G/baTshtshb7PxY8TEt32OV5PZEIDb3q6S/D0GNVOAdZvOQ
         Sn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618740; x=1796223540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIGW3Xzsrr81dqk9D4Vp8vgVx512oU4hyhr1tOSXM84=;
        b=zWhETwrUonL+YoObbBKdsv23m/fpZJS+yD1dRFsYW5I0kbBCTU3icFaTSFCFMXFzFt
         MLmuChjK0D5X5G5dxOtZ34UjIbGgBAjP1N0RKk3hh/NVCoIJ2AabgJkMC52zCWeMB44d
         DAPufwp4umPV9FvmDHdSbJS5RQllz5Sj4shk8e6XbPugtUGNw6y3Tje42i99TSPCi5az
         oIjJhc02oydQDnRUjPaNc8mpQfs4990xQuiqoeWaPMF6oLrdzq1g8odT/iXL7J7e96Bq
         LOH6Wvyv6zp8gso2wugCNmQUwjnvPZZe1Mx6pN3vr7KfIebwkCpO2HP7nSSR8B6vG+n6
         ZchQ==
X-Gm-Message-State: APuU4Z9oGc2Q2SxvuJFN8msK9xV/QSCrEzKxE4YTLiaqtV5ZwETGyHX+
	/ie5FxeEl3V4M+tAggq73swFmaHt2R0qGOo2ostq/1SEQZI0HHaeVxEDEvEG/I3DCEZAWfa+gEt
	gt5uWgkW2+A9qOtTBltVhwSXlnbbfkQSAKqNG
X-Gm-Gg: AZFdTZcSPAtX3mI5eo27ZtwNjljBJu4IGFRPMT+4aisTRD/gxSii0NAmbSkxp5slP7O
	NChfBoNqV35mFt1743mWVFi8Pmz5BNI7x+o8WkRN5pOMdCvJWbJRscMIM2HwlPMpBZF1Xd0t9KZ
	hc/ns4+b2D3RUSe0+z3yqRq6eBDF7CtSVg7PytPjJ2Pcm/iIygtVIXcaftzsV7I8/2lcrg6zbLf
	wZUJpNuE3yXEkEsBp488ftKyYnvnPb6icA71u2N6S7VDurkllEt7uFvix/UifGlx7Zykd8/Yfld
	8RYVOYq4geiZrRdOsb9yKVOxvoim4VZ4PiT+a1EOs0EZADrJYMtCE8URRdlJePj9Dd4ehozmak7
	taxzbIUIF6tyk+XHJrovgawUoA+9AXbu7nOb1cpJSJLicgX3+VLqkWPnNbVS9rdIXiXn0Gs34/v
	TTxujdNTT+H3zDOpIX8Xc5GvOTXU3e9QodCoErW7O46vkgQGE35w6AY8hDySc=
X-Received: by 2002:a05:690e:191b:b0:67c:3162:8112 with SMTP id
 956f58d0204a3-67df440b774mr6078849d50.21.1795618739646; Wed, 25 Nov 2026
 06:58:59 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124181134.481760-1-simon.mikuda@streamunlimited.com> <6b05fb67.140a8b06.51aa7.60ac@mx.google.com>
In-Reply-To: <6b05fb67.140a8b06.51aa7.60ac@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 09:58:48 -0500
X-Gm-Features: Aa3M54pO_7a8Tq4X3179uTNMs2EqvINwBdX8-jCpOX0WNwGw3zJHL7cL7X5shhQ
Message-ID: <CABBYNZ+-rEEdLnzc=H_OLj4kEpQ4sC3gy_=YV5eVCHYozmVkTQ@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/2] device: Run reverse service discovery on the
 bonded bearer
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 4:02=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1221204/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.23 seconds
> GitLint                       PASS      0.67 seconds
> BuildEll                      PASS      20.66 seconds
> BluezMake                     PASS      314.16 seconds
> CheckSmatch                   WARNING   321.63 seconds
> bluezmakeextell               PASS      102.64 seconds
> TestFunctional                FAIL      1230.58 seconds
> IncrementalBuild              PASS      343.73 seconds
> ScanBuild                     PASS      1212.88 seconds
>
> Details
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> src/main.c: note: in included file (through src/device.h):
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]:=
 pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at=
 0x7f9254346a50>
>     searcher: searcher_re:
>         0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
>     <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
>     searcher: searcher_re:
>         0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
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
t at 0x7f9254346a50>
>         searcher: searcher_re:
>             0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
>         <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
>         searcher: searcher_re:
>             0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
> FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]:=
 failed on teardown with "pytest_bluezenv.utils.SanitizerWarning: [btvirt] =
=3D=3D151984=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x777c177e3010 at pc 0x5a423b71944e bp 0x7ffcb09fde40 sp 0x7ffcb09fde30
>     READ of size 4 at 0x777c177e3010 thread T0
>         #0 0x5a423b71944d in timeout_callback emulator/timeout.c:47
>         #1 0x5a423b7284f5 in timeout_callback src/shared/mainloop.c:271
>         #2 0x5a423b729626 in mainloop_run src/shared/mainloop.c:125
>         #3 0x5a423b72bf4a in mainloop_run_with_signal src/shared/mainloop=
-notify.c:196
>         #4 0x5a423b667179 in main emulator/main.c:417
>         #5 0x7b3c18843600 in __libc_start_call_main ../sysdeps/nptl/libc_=
start_call_main.h:59
>         #6 0x7b3c18843717 in __libc_start_main_impl ../csu/libc-start.c:3=
60
>         #7 0x5a423b667ff4 in _start (/home/runner/work/bluez/bluez/src/sr=
c/emulator/btvirt+0x152ff4) (BuildId: ed53605ba86d207d9357e9c6c40b6f2098898=
adb)
>
>     0x777c177e3010 is located 0 bytes inside of 40-byte region [0x777c177=
e3010,0x777c177e3038)
>     freed by thread T0 here:
>         #0 0x7b3c191813ff in free ../../../../src/libsanitizer/asan/asan_=
malloc_linux.cpp:51
>         #1 0x5a423b72824a in timeout_destroy src/shared/mainloop.c:252
>
>     previously allocated by thread T0 here:
>         #0 0x7b3c1918260f in malloc ../../../../src/libsanitizer/asan/asa=
n_malloc_linux.cpp:67
>         #1 0x5a423b71bba5 in util_malloc src/shared/util.c:46
>
>     SUMMARY: AddressSanitizer: heap-use-after-free emulator/timeout.c:47 =
in timeout_callback
>     Shadow bytes around the buggy address:
>       0x777c177e2d80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fd
>       0x777c177e2e00: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
>       0x777c177e2e80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fd
>       0x777c177e2f00: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
>       0x777c177e2f80: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
>     =3D>0x777c177e3000: fa fa[fd]fd fd fd fd fa fa fa fd fd fd fd fd fd
>       0x777c177e3080: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
>       0x777c177e3100: fa fa 00 00 00 00 00 00 fa fa 00 00 00 00 00 00
>       0x777c177e3180: fa fa fd fd fd fd fd fa fa fa fa fa fa fa fa fa
>       0x777c177e3200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>       0x777c177e3280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>     Shadow byte legend (one shadow byte represents 8 application bytes):
>       Addressable:           00
>       Partially addressable: 01 02 03 04 05 06 07
>       Heap left redzone:       fa
>       Freed heap region:       fd
>       Stack left redzone:      f1
>       Stack mid redzone:       f2
>       Stack right redzone:     f3
>       Stack after return:      f5
>       Stack use after scope:   f8
>       Global redzone:          f9
>       Global init order:       f6
>       Poisoned by user:        f7
>       Container overflow:      fc
>       Array cookie:            ac
>       Intra object redzone:    bb
>       ASan internal:           fe
>     ..."
>
>
> https://github.com/bluez/bluez/pull/2912
>
> ---
> Regards,
> Linux Bluetooth
>

Copilot flagged a couple of problems:

https://github.com/bluez/bluez/pull/2912#pullrequestreview-6046643629

--=20
Luiz Augusto von Dentz
