Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114771;
	b=Dobj5qOpJHqaWGMMvhdjpjAR3yKDRUpm8LO6Rug6lDM4Suv2okIToj1wTFjlclYGnoii
	 4yGx08cOfXhfv1i3WwD1PcE6SnwvYs42/20+aY0rqsfADgafwUAAPwFHAZ2FGlnJ1fyiM
	 hV73+uXfOcNItVHQFwLDc4NLg9mUgLV9aBLGlG7CedekUBKGKXKHgcPaJU+B1PZeVpDV3
	 iA3ZF1C5ksdii2usyi9nttURQAkkX8C9ZHCgr9vxrA4Kgq98Tmv8sFtnSuLVG1gPaF+Y1
	 p4/GPON5ODVnxdgs6O6QDXuFMkX2zFnk9Wg79VkdsNvdPN9Z3f9TgRGX5Ml3KlSUo3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pLo28lwXjWup380o9OtWZH+rl61eiRlZ2BBQ1DxgyCo=;
	b=vOf06U1Str90B89+4ziy+PTcNfDR1TQmxx76PwyafvfEU8OupuZ/A1UxSJOw1CrMTFdu
	 INaSe5cICdIXZSRdcp+SNLKJlm/YKflFk1JYQwyJUXm5u869KAtO92yMPpvLsXCblIBJe
	 RTv21fBCvrdbuBw5PhTCQRVcM0JBoEN7UsXfJhSbAnH0DYs8aTys7d7A5F1wZ/AXBlNy7
	 NDWyKAT6Yhlk7VPVYjtUp8Cn40+vIp66QL0kgxhzkLjHzrcNN+zZdqlf8tQ85rBwI404w
	 3ZST63Wt7iiZ+E31Gsz2jfqY6neWB4yDiAnqmGn3hJ+slRvbD6lId0uA4B2W+xVC6oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh2d+MJz;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801F606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B801F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh2d+MJz
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so28558a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114770; x=1793719570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pLo28lwXjWup380o9OtWZH+rl61eiRlZ2BBQ1DxgyCo=;
        b=xh2d+MJz0preWKpnqDcKLq6/G4kxM3dKlj3n4IukdV1c27WV6RR/OOovSsz2DbD27T
         UzyaONBJQmc+YzYzbXSHqjhwoRnsydanUqiwkDEK8Ld42hA3NJZ8MzInfo5d54ypDGoo
         d4idvzKNn/nsvrM3v414RF0gskvR1ESxhPX3Xmi5qyM2yMevthuQ9sI+5ovdu6DBs8Qe
         FYr4Hg3AQY47naJkHb46qlCfD8+ExSqqSBb5xwbY6ILosM/NZNdWXVi83kz8SMLmeb6w
         RKR2lOW5AG5/gR9NpyOXnc3sK3rannh37K4ng2TV234InBV0QjCuTlcIsCy/zgxiheNC
         cCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114770; x=1793719570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pLo28lwXjWup380o9OtWZH+rl61eiRlZ2BBQ1DxgyCo=;
        b=Rc2iqH+zNy6XmrjEaJcou54eFLSeDI4qlEU0dfSwR0zEevcuFajYAMpd5cypIsO5pV
         j22OQrGQmdrXWhOuEul3AVITHTf5JvLaVnbekTR7+qp+woWBKt9oDbL/+p5LRBxgdhQX
         X0iNcLhg576KsRJFELTtRZOP1Nm0SV2/18mirei7ZxmK4jqJT6UM4XqSsF19JHerjYYy
         g1MFQyohdI3jzJwzs3JYe0oYjFweRH7Z/RJugR6hHBOYQU49EHs9QCmtKbV4b8ZRK8X5
         4/Xo/RBgG7LItcux3wpw++DBfAJvzr/EFr7O7LCPktiG03d3ePP95THBV5FZJ43bvC4k
         rRmg==
X-Gm-Message-State: AFq9FYJOGOvFK2yUCjbToHsbWXXoXGAlGlg7UGEpOrjeWqqUy24EnagW
	hPZtMlxEt6NLG4+l0rXikErFxvASqHsknhETSSI0GZs2a84WL7gf7X/HnPjoYQ==
X-Gm-Gg: AYBFou1WKusuohcNiycjseFhPe6IR0jjK/kDL7XvTaDDHdOd7H2tW7OvX5QB5wu0EFs
	PcPMCW61vUKxwoTTnbalutTv3w/tsvDOIYpFNDzB/KQ9jNVm9Ho2kltS8J4CZfL40eJY59Oa9Av
	Oq5GnoCR7LB+oZIjEoNw8yWvLOpFoaLumMpaLqc25OUAawI3oQyj+E45Ke7BsoF8LLH9JL8qQKF
	JvlOdusit4tjsUhSCxNIzzOxDSbZIRRiPpf2G36bQmM5q88RPCEdLlsgho2FdCUijem3GV89ARr
	kuexX56FW4Z8x9R12PnJSJs/t8LJ1uYUE7+stnrd/oi03kMW3WELs4Z+kxtA1sB3DNniwkBYJ5N
	V6J6CZDPRVpD410TUHf6RhLLSYpNbaLrNgU0l4rj5jOayVOluYxH4JILYTV9bZMbcXpzneVwBbD
	3dXq24Eai7Aat9eAH3GRkEsKev+GcISV4cz6/fhhVdoQxdlIl5kJeYb8l2Nsag0UyTiB39VLYEj
	AcuNft6EfG2cnNBy60nZy3VY3hX3KXzhSVliVOg/J8YEYdjElZel6aTUhtyHQ==
X-Received: by 2002:a17:903:26c4:b0:2df:8d6a:3548 with SMTP id d9443c01a7336-2ea9c8cbaa0mr83989625ad.48.1793114769952;
        Tue, 27 Oct 2026 08:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.227.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6454a29sm11427095ad.9.2026.10.27.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:26:09 -0700 (PDT)
Message-ID: <6ae0c291.a5baad57.374aab.af42@mx.google.com>
Date: Tue, 27 Oct 2026 08:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1899769702838620092=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez,v2] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
In-Reply-To: <20261027-fix_sco-v2-1-e3835bda5453@oss.qualcomm.com>
References: <20261027-fix_sco-v2-1-e3835bda5453@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1899769702838620092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194542/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       FAIL      0.41 seconds
BuildEll                      PASS      19.73 seconds
BluezMake                     PASS      300.39 seconds
MakeCheck                     PASS      0.83 seconds
MakeDistcheck                 PASS      142.66 seconds
CheckValgrind                 PASS      147.43 seconds
CheckSmatch                   WARNING   293.18 seconds
bluezmakeextell               PASS      93.97 seconds
TestFunctional                FAIL      1182.64 seconds
IncrementalBuild              PASS      296.50 seconds
ScanBuild                     PASS      1149.70 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez,v2] monitor: Fix stack-buffer-overflow in packet_hci_scodata()

50: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f2baea7e510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f2baea7e510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f2baea7e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f2baea7e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2720

---
Regards,
Linux Bluetooth


--===============1899769702838620092==--
