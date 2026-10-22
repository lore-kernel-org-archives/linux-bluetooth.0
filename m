Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698068;
	b=WBfzTMZ2EoNB0LTNLVQIf+XIUUCBVNU0137qvAxYCJDAGJpcmRbiLMQ/p4iu2VdMot/4
	 1+0xmy5KMuVSw5IG5YDb/sV6XUjXakBZG2PJUuLGua4rmrwD/ARPg297P3wXBUXOstV+6
	 9irWL1axQ4aW7qugxFSWOGUQVNmuyAF5/aBrVuwiDpOfApvFogx0shIKG8kqHZcLn/1sC
	 w1w29iz21gfqP7nUqHH8RXKTdqXQMbfal5WQF60ZVbcGV7xh+0sPIpRaUVnfG3ejX876S
	 cqY1qFzHWrVSPuEk+bfBvMk1Xy9RlxBfhyffssdch/4zq4DMehiNWea36R8Q1s3utzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dFQNv7pn6rCXKpCSOT4n0cKxsgwhf+SsdeekXWDE07Q=;
	b=Oq5VfTIwLYgUtOaMqRCdQZL1SGDi2Tow/Lj/J/wwIi13bud5IXBI40NEux/8w+berhUk
	 2rVUyAsOq5ZxY7pa4/WpjS8y4LT6ds4QksYG/LJe5KVcmvFp8QPLW667ZD/isNFJy0hKF
	 SZyCs2lsvPZV8+e6D0U40mY4vqBclWQ4YrKK/vmFpalLjTVui6xZ5L7Jbz4rkkQQoZUOu
	 9+4PXAt6iupoiT8Jnm9O/nM/5q/xU5DYWrig25qV0v8vQa/3qDR0oXugJNaYJPm06qnkE
	 rfWCmtf21fGVOFEe5NDWFvkY/WoYhJrhW7cP6NduuwItWseyBTPlCXwsYMh1IFcOzoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4LTlRwK;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49785606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 19:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49785606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4LTlRwK
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aa9606ddadso120720eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792698067; x=1793302867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dFQNv7pn6rCXKpCSOT4n0cKxsgwhf+SsdeekXWDE07Q=;
        b=Z4LTlRwKaNUmAmyQs3wmT25TSjGW/71zgtDu5QN7/WUv568XDVJyBlpujwLwHQ1egO
         jwOvXKNeLfpKrdg8JyHuxuX0l4Ux4udLOUa6OukZ4H9+cnD6IsWlnyUUySQDlMEny7Bx
         Hn/hCfH3kGHwOH3Xz9Uvj0aPv9AOkNO0G2V2POcsk9cn86w/P/kW6tMWuGadYWK0bOFg
         HewbPRl+sv3MfJUwKwmGJs9QR42w031flNZPV7uTbzhETdZo2Ki9vGfMwDFzTHIrZXgV
         UbHDmMr8o9Aw1Zu+tYUJWihBH1D6Xbb2+3aMiqG8HP0j0NQldBi30BICg9rOnD5l8pEf
         iJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792698067; x=1793302867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dFQNv7pn6rCXKpCSOT4n0cKxsgwhf+SsdeekXWDE07Q=;
        b=jh6s0NI/aocaHIrSgZ9LKflrsmQhJ8jaEgojvDJh+PTZg+vjKWv+e67LwOY+tXL2Rh
         uznzmM5Be37+0Pzzz+Nx4ndDYUBw0XeKkXV6Qtzbv9Zmq03h8bCP90IjNQDT7KGnWyt0
         l8j+IUljdkm1/rpWJWRb61enBZiCARTYPbnZ8wOsOka+ZLFGJtYTaypQcBPK1FmF3ErI
         Xxygl2yDa93hlZQQEnN1tv1/smC5zPRrI8N92Ghy+4rBnN4Im/H/7urPiACaWkRNvmp6
         HWMxSGgC9OGcIicZnIU+J1CWSIvd0/iBYmKTOvgcz6/35zXj5QC3TMF650i73BcM/kZe
         hKWA==
X-Gm-Message-State: AFq9FYJ1HKbmy07jCtkM1NPfmyWKNxzSoHYrg49zS25rYiL4sHcWtgkM
	hJ86jt2OKqVWcs1PsOy9p+ez10D1PgLJROuK9S/X7RgFLX/hc2OxICab/c0o0w==
X-Gm-Gg: AYBFou0PayD+ugk98ALYKhRr5hcncARWVKIdbkX1nPxvs4lQ3WwccGy12Gnulcd5PLm
	sNxwUQwiu5mfvHT6xkWphQbZtnmTx3vyFGZ7+e5y/0XKi/fdtX9hx8YQhJ0+8MR3kqS7i5qW54G
	Q2SvqePYMqlMWqoRUW+E7cKoSJGkZnpNsbzsblupQpkoz0Ilolp2vEuPlC1f2x9QI6VC7sQ41+q
	rIKWrEPxWeNMYP3m7WqIo8SXI+rg1aH5OaqPh4BAeK1G7o3i7JABnBGCbaN1cM6LsOtMEU+4407
	VNJOdyILV9r7De33kU3qV2X3zcLC5nxGJE+Az19cgbdzQ9kUWmUbDOxTbIpcueC8pdtl0w51uHh
	3oOLncjCw2/lzmafDygc/T62GN5YVqFTlswk3OTceX2gbDAmAtYbGCPNWrVF2XYf2aWVrmcE6sm
	4n3KkCl4aTyDFc9BdKVAbdQHc8vtqGilfRQ6lHZ96JGSCP/AuHpywgWEYiH7lgOuoPTWZ1A5uaR
	lNOUnFYoFIz+t69DLcSoT9DXh7Pg9taNb8hgFFXJr8JZgbN0tOC6WBXRY2ScrW2
X-Received: by 2002:a05:6820:1ca8:b0:6f7:b0e0:63c7 with SMTP id 006d021491bc7-70b889f6165mr328798eaf.35.1792698067247;
        Thu, 22 Oct 2026 12:41:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.219.193])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a82095c63dsm29951fac.4.2026.10.22.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:41:06 -0700 (PDT)
Message-ID: <6ada66d2.6464a4ac.326eae.68d1@mx.google.com>
Date: Thu, 22 Oct 2026 12:41:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5318292790190099085=="
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
To: linux-bluetooth@vger.kernel.org, aurelienrivet@hotmail.fr
Subject: RE: [BlueZ] mesh: Fix Command Disallowed on random address change in generic IO
In-Reply-To: <AM5P250MB4222047E08E92211215A496AACCB652@AM5P250MB422204.EURP250.PROD.OUTLOOK.COM>
References: <AM5P250MB4222047E08E92211215A496AACCB652@AM5P250MB422204.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5318292790190099085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191507/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      17.28 seconds
BluezMake                     PASS      248.29 seconds
MakeCheck                     PASS      0.77 seconds
MakeDistcheck                 PASS      119.46 seconds
CheckValgrind                 PASS      119.67 seconds
CheckSmatch                   PASS      199.74 seconds
bluezmakeextell               PASS      76.31 seconds
TestFunctional                FAIL      1023.54 seconds
IncrementalBuild              PASS      227.66 seconds
ScanBuild                     PASS      808.37 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts10-vm3]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f85506b2a50>
    searcher: searcher_re:
        0: re.compile(b'Transport (/org/bluez/\\S+/bis2/fd\\d+)')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f85506b2a50>
    searcher: searcher_re:
        0: re.compile(b'Transport (/org/bluez/\\S+/bis2/fd\\d+)')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f85506b2a50>
        searcher: searcher_re:
            0: re.compile(b'Transport (/org/bluez/\\S+/bis2/fd\\d+)')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f85506b2a50>
        searcher: searcher_re:
            0: re.compile(b'Transport (/org/bluez/\\S+/bis2/fd\\d+)')


https://github.com/bluez/bluez/pull/2702

---
Regards,
Linux Bluetooth


--===============5318292790190099085==--
