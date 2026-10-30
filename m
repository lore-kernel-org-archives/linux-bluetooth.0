Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373662;
	b=DEj+HVziDy8zzLSdt0ADnTGywcZvJUFb/A5DEN6bQybgqs0CFh6tpGyxDx0eSQwxDIQX
	 ImZwUn3y0nR5BlJNVLLfjbn2VX/JYJzep1wH12MSxuqNcpdPbu8IQMGPuISK7gTVE7HLB
	 YfR3jjDTfClm/zJN8usiUxoLGhuavypBteU1cn2EuWYUvgCD8iTwTrUKVTF4X+P21GD4Q
	 2hzEN1+BaAYqh8EawhUOimltjUn9qLBWl2xrkqfx2QVMAAn1VB+/Ig2I/JcUMBUsMw5gG
	 dQo/7/ah8BtnwLBL9ZTOhS6h2rbiNwwwI1qbXH4vBzmuROed+/3h8E9vs+ozPJ0FrkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZYa5BsyrtEYcBlKfT/e5f5y2r8GvadhWaT0gbtF/+6A=;
	b=vXtpAdvV6w2wW7T2LL2bSNLypUq01fvB+U1tjrX6Ll4eXKKOMEQ04HiFtvhrGzzfD1hi
	 HNyJqu3/BdJ6BlOoMNhhBe3Sf/OoM698h3eP6f4n01duGycQ5TCq6nIuJfW6sHvtt/cXP
	 O7NLm8Wgh4Rj8pJ9YHdgSlyUErD+HeB9QPROXMNub3MOwwAToY0hjT16bC0T3ACfTFXdj
	 hONkKWLZbyTuSn3ShM8AyU+jE1KjygYdxtMSTa6l2VVTqMHlCUC/EvrhdADhL+BrlQmrr
	 FHbGOavD3UFdBhb1PkG5nUCaxc2I2sACyyEEfebdb69X5i8iNC0ouUzA/srCqBchYRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTnaxN87;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AA606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 15:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B48AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTnaxN87
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53669f7b518so8697171cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793373661; x=1793978461; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZYa5BsyrtEYcBlKfT/e5f5y2r8GvadhWaT0gbtF/+6A=;
        b=wTnaxN875q1hG6yeCyeg0MhxGhI2QprukqGmk6JvMzIXTIV1/pt2Af4pBEmamr+trY
         5BjrhKZfR3HG5PI3MSewQ8FIGLonDXJ17zpVseHgslrqDty3ELlKEgMd3q966MrLnZEK
         P534MQ8+jbBY4snnOn2p66FJuAMEp5rKiGTgEKzb/ATbjRjGv0b215W7Txt4ClMnSXHe
         ZDVrsm2nOrn2ZPLyXvLQPoXIDPr1ZXlOpReKRxX9XytJZPSmJJhCnIG2KFTAB/GGl0aD
         JIZJMA9pv0jmTj25JXZEI4teLF6oQWnJUz5oZd9xVnx5Q0Ii9xqRoEp43Lr93P7EJHBH
         JivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373661; x=1793978461;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZYa5BsyrtEYcBlKfT/e5f5y2r8GvadhWaT0gbtF/+6A=;
        b=1MGKx4bdQ5ne+fQhHoJIz6UpbDxoMrh9SMqjpYGN9b3gjDXyrzNkq9fjXG+VbSTRsb
         HkQB5q9qCc/F/+uZJ+XbR87xKjXv3tyXplNogW8Nj365zrQZHdrK0lWl0sfiUu9vboRV
         fFyLqI1fUaysHHCbrtRiehYPwnODodCxZixa7+50bVD5gR6rQXQyCkUHLacJEyLD+Btl
         d4VRNFPe6whiAunnB6ne8bMYztemXADqV2DNi1gtpZfxApsjQoYkvPWeicaHduE0UufQ
         XcJYtbTeZox5CmnAFmpEWoHMLe0JOtoy1n5Ca1pN9au64eW4qiDfcYx8iWOkc5tA01jI
         O4lg==
X-Gm-Message-State: AFq9FYIb6Mzpd/ErQ7W3nzZn0UZposNZOV/zsvd4GZN5xoHZNEBRkFaI
	E6pHaR7WDzu2Eys78LZsGUxkBDsSGSZwaeydmsXMJjMd/IbilOnYiYnOZV1wqg==
X-Gm-Gg: AYBFou37gRTAukn02WokejW9Zv5GlO02WV8+0l9dYWM0GGWWvaUt4Qfv1b8S4D7KkU9
	Saos21bEK2LVEVNhsvqjjgs+tV/gt7HM6znLKPUGJskRKPbkWkvVJBtGG522xU3AhqvBdaQ7fAf
	R/9dnZg50I0U5mek4shNxE5tHDDUh6UTF33OfXN+MkaS/gIMQzeMamkBsr9sV7zy3VftTVdOe0g
	pHEYtMC9l9sTU2Dxvb2Iui7H3tBB0FL7Irz0ReCn0acViOk+Vy9GkDpvuRasHzvLhv27/uXRrej
	PxyAMuDji4QUhIGNazim/B1g8iO5UHInnoropKU+f0gnXmbBEL15PR6g/SDa84HmMo7Ryj8G1jQ
	KCb1bWKe5Aco1GfbgWK4l0a9Vq8frw3DN5qF1TMh9ocIRXj3ZOLimHoTKkJJvrZd8N78Zxns+mC
	0Hi3xzj+uPn9LA6B5oxH4WZ0Nd90Y9pdUQ0crrzQ7EKwoT9Xi1EYEyFFzy1NGc8FfaHYXvai1EL
	hg+G4w+dvCPb1ZcTSuOWlEUXDGrc1WA2oy7MbdUgZkGowHWFWjFDLeAbZ3cKCw=
X-Received: by 2002:a05:622a:5147:b0:533:9381:7603 with SMTP id d75a77b69052e-542b6d5f76emr38821641cf.12.1793373660528;
        Fri, 30 Oct 2026 08:21:00 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.83.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5430faff332sm15759381cf.2.2026.10.30.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:21:00 -0700 (PDT)
Message-ID: <6ae4b5dc.60f493e6.387f6f.e5a9@mx.google.com>
Date: Fri, 30 Oct 2026 08:21:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2302697880606641868=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jacob@teenage.engineering
Subject: RE: [BlueZ] client/telephony: Fix missing string.h include
In-Reply-To: <20261030090934.89910-1-jacob@teenage.engineering>
References: <20261030090934.89910-1-jacob@teenage.engineering>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2302697880606641868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196995/

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      16.30 seconds
BluezMake                     PASS      230.88 seconds
CheckSmatch                   PASS      225.43 seconds
bluezmakeextell               PASS      76.87 seconds
TestFunctional                FAIL      991.72 seconds
IncrementalBuild              PASS      231.05 seconds
ScanBuild                     PASS      829.73 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f7c16c4e510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f7c16c4e510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f7c16c4e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f7c16c4e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2737

---
Regards,
Linux Bluetooth


--===============2302697880606641868==--
