Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554153;
	b=5dlq5WWkK3lIMSBmhZGMFTUvyBBKyC+F1bo0zgSEhibKHyZZ07UMtVNXSmBXm7meBXcx
	 4fJzYli7PFF/Y7mYooKjuGw2q9fU0z/zKCh0S+6gOchekorj9OfQpjiAwvZ7Cdg1ob+AZ
	 ZzvDehgXbBM8KmfwXiC8qnc03Mc/NykqeNVJqPc4rgpaMiWevxeh1PN7Mrp6nOpb7QK+2
	 JInefaWclF/hkzA8eDxHMrPbq2EXhF7L9JMrmk0AzbXQI+28DzILBYKqhonXq+oCcNIbu
	 RSNe2HY6CYAw+L2L/GQ+TH7NjcniOHxetBx4n0JOn7C5DlIU8t945hpSugGJiT29/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FiuxOVTkKjiW3YMxrAUefc2bmRxgeEXeL9KuETK2mPs=;
	b=BTVYxYTfFipmGG+DWNOhCWH2oq4cdNCOWanRmsYkxQN3Heo799tR7oxcb1IeoShxWK1Z
	 OM56/oXcwzDEoozb8mY1vq2BGz34oEC9WvGmSXBf2ig3HVX47cFSEL/rIYcnXmXINycw6
	 L2/1I+GB1/kF69eQbWBf738xMIu64j0+ncWTFVcrWm2PdKcOJDaLvJFIs9SXnY4BxCHaJ
	 EsH6pBFvIw6MhMW4mKPRlqGMwxd/dtAuiNzvHbzrXRJrG70xifBMT2wwDA5wTnGqAusC8
	 1PmOd0YOaQjxMRs5+KlHwRZaUdH/4QEmE80VqpTzrlAFyPDLm3uJBxoFUxA0Pw18BLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A59T5J70;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EB606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A59T5J70
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4cc793704so37446867b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554152; x=1796158952; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FiuxOVTkKjiW3YMxrAUefc2bmRxgeEXeL9KuETK2mPs=;
        b=A59T5J70K3C/pZLEWhrTKpqKYGoXsD5/HPmBVxfxVkfxSoPF9EZvnlxJmTzkRcP0fL
         elCJeIy6mhs9Q94JUdw3UuvFJMNZsKmTIQ/g5X4FYKcY13ZbejE8n+5p8/A0towzJPhe
         5lu6vNZLZzKeUQcfZqYGHzqz12GLuow1xBBqlNxcx789/K/ypaGqOCZMOIdPpOUzIcJ+
         pnbXkoVjxLTLOHVQseEEqqyzjsWtrF2X71V7BdGPE9BYO/TImD7syPXwximjpmHnE9uO
         Q6ocewzXRIFYjC5QoHnXMyaWrDVl23FGBvwtkb5uFcP2EWqsGv3R4lpAeCoL72d6pIe8
         0gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554152; x=1796158952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FiuxOVTkKjiW3YMxrAUefc2bmRxgeEXeL9KuETK2mPs=;
        b=snTIK9t9HRTihlPO+5xxXXXNo2dDX0JPOY8GuCHeqsSPB95wbB60KyAlyoHX9q4PS5
         o3MVymX6jodvuB4VSkrGJFWb4Ic5PskoBXbIjoWsB59c4K1SyMd8cxUtWbCXALES1KUt
         iHWrJpKaWYNG4FYH9EMCXyfz0Gs+I993xw6OhIG8R1YdmRI5xc7shjH4fNsGJNpUajtD
         P7rq22oWD7DZq4n9nl8FASIgMijf3LT1QWDcoJauO5GfT+ETySRUnMlTBfkAEMwK1A0k
         nzL8rkSt4BsQYU/kfqKG67Ho1QX2UZD1pJEsqu11D2vMU88fLpuBIlTzeHK4mh+5PpYj
         M8xQ==
X-Gm-Message-State: APuU4Z81GZ98J0PqzczBXUJvrn5ydk2lWOg2+tkdAPgJ2nlZbMV31s5O
	VdY93dk+0o63RPUMcHEwpbs3snjYeoWIDJ/irjV+JXliXxl+86L0ZocGs3+w8w==
X-Gm-Gg: AZFdTZeFEOrZLQli8qD2weR4rB9e3GGh2W8xDi6g9ESA0YKirUIJkE02ZPLiiVZvBjG
	tnySnGshuPoRYrXO3I8RqLyFvCtWauSec1XKWgR8dp3/eLXDSE6EUIjgTBVTYZ6D0496yqk0+dQ
	I94jZf7YLbWEzoyvquIE+nji4q6XUitjwXk0uGHo3b08Mm3WFlMgKNtGF3vaLJRFraKEJaARhnL
	upNQ4/DTuHveh1XrZHhbuhigVe3KaX//4nq2rRj+MgP3J82OF4OUlDDQ1tP0WJoyabZ21Qlv2Yi
	bnRXgW989S3ZNtYJ33V1ibNvSbhF1kUA2Uk1bhRUro/B52LZszUtJt29p73lOYkCnKXsRj9m999
	KbvFNkdpeobhfJObGeUptAC2NYIGFpTAb0Wcsjn4a6eOSur3pA1mgo7is7gjnbgHDRZs3ml4dEk
	ikBJujU2V7/SGyG/hRNZO+XvzXHSZZETMbIxXujFJy3cEIId/bjdb46QVsLqTQ6hyOf6l0s7cui
	oxP/Eog/a4q3nZ6OXGuQFQPd0MjqfscTbwfxGmf7oC+JjWbh8QJe5n9VPS+F5IAxA==
X-Received: by 2002:a53:b706:0:b0:67b:fe2a:443 with SMTP id 956f58d0204a3-67df44853a2mr4764473d50.87.1795554151854;
        Tue, 24 Nov 2026 13:02:31 -0800 (PST)
Received: from [172.17.0.2] ([172.203.203.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921787fd72asm4793136d6.12.2026.11.24.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:02:31 -0800 (PST)
Message-ID: <6b05fb67.140a8b06.51aa7.60ac@mx.google.com>
Date: Tue, 24 Nov 2026 13:02:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3387273624437731543=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/2] device: Run reverse service discovery on the bonded bearer
In-Reply-To: <20261124181134.481760-1-simon.mikuda@streamunlimited.com>
References: <20261124181134.481760-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3387273624437731543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221204/

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      20.66 seconds
BluezMake                     PASS      314.16 seconds
CheckSmatch                   WARNING   321.63 seconds
bluezmakeextell               PASS      102.64 seconds
TestFunctional                FAIL      1230.58 seconds
IncrementalBuild              PASS      343.73 seconds
ScanBuild                     PASS      1212.88 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
    searcher: searcher_re:
        0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
    searcher: searcher_re:
        0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
        searcher: searcher_re:
            0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f9254346a50>
        searcher: searcher_re:
            0: re.compile(b'\tTransport (/org/bluez/\\S+/fd0)')
FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]: failed on teardown with "pytest_bluezenv.utils.SanitizerWarning: [btvirt] ==151984==ERROR: AddressSanitizer: heap-use-after-free on address 0x777c177e3010 at pc 0x5a423b71944e bp 0x7ffcb09fde40 sp 0x7ffcb09fde30
    READ of size 4 at 0x777c177e3010 thread T0
        #0 0x5a423b71944d in timeout_callback emulator/timeout.c:47
        #1 0x5a423b7284f5 in timeout_callback src/shared/mainloop.c:271
        #2 0x5a423b729626 in mainloop_run src/shared/mainloop.c:125
        #3 0x5a423b72bf4a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
        #4 0x5a423b667179 in main emulator/main.c:417
        #5 0x7b3c18843600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
        #6 0x7b3c18843717 in __libc_start_main_impl ../csu/libc-start.c:360
        #7 0x5a423b667ff4 in _start (/home/runner/work/bluez/bluez/src/src/emulator/btvirt+0x152ff4) (BuildId: ed53605ba86d207d9357e9c6c40b6f2098898adb)

    0x777c177e3010 is located 0 bytes inside of 40-byte region [0x777c177e3010,0x777c177e3038)
    freed by thread T0 here:
        #0 0x7b3c191813ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
        #1 0x5a423b72824a in timeout_destroy src/shared/mainloop.c:252

    previously allocated by thread T0 here:
        #0 0x7b3c1918260f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
        #1 0x5a423b71bba5 in util_malloc src/shared/util.c:46

    SUMMARY: AddressSanitizer: heap-use-after-free emulator/timeout.c:47 in timeout_callback
    Shadow bytes around the buggy address:
      0x777c177e2d80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fd
      0x777c177e2e00: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
      0x777c177e2e80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fd
      0x777c177e2f00: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
      0x777c177e2f80: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
    =>0x777c177e3000: fa fa[fd]fd fd fd fd fa fa fa fd fd fd fd fd fd
      0x777c177e3080: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
      0x777c177e3100: fa fa 00 00 00 00 00 00 fa fa 00 00 00 00 00 00
      0x777c177e3180: fa fa fd fd fd fd fd fa fa fa fa fa fa fa fa fa
      0x777c177e3200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
      0x777c177e3280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    Shadow byte legend (one shadow byte represents 8 application bytes):
      Addressable:           00
      Partially addressable: 01 02 03 04 05 06 07 
      Heap left redzone:       fa
      Freed heap region:       fd
      Stack left redzone:      f1
      Stack mid redzone:       f2
      Stack right redzone:     f3
      Stack after return:      f5
      Stack use after scope:   f8
      Global redzone:          f9
      Global init order:       f6
      Poisoned by user:        f7
      Container overflow:      fc
      Array cookie:            ac
      Intra object redzone:    bb
      ASan internal:           fe
    ..."


https://github.com/bluez/bluez/pull/2912

---
Regards,
Linux Bluetooth


--===============3387273624437731543==--
