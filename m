Received: from mail-oo2-f16.google.com (mail-oo2-f16.google.com [74.125.231.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5913B0592
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512568; cv=none; b=BFYNKRhWVfyg9VgpfWPbofSIj8ecMoQHUsADkNVkh7oChpi+lVZKcgiIumoMs3Cuh15ZIPOaazCMYxlesDecEmjksNYHaow7ZUu6PWjGfDNxNFpv3urKy9trpE+QrkzCWiSEVp5HwIu4v+U4QMnN5Iu93/dFYPHVFUPA71zN/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512568; c=relaxed/simple;
	bh=nvTy8tlHQj2+ErlRcH+rOxQlAyYM2Ts5cgM6XVAQF20=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IbLJFyyz3AU/3UqZKg/QO4b+vFx5Ir3UOZXrscPyAK43TS8fKKkNtSdejhTfJVenVuNRBFBaQOV2QZkx3iZPUdzghgzygrK6s1DVHt1OZV0BjW/YjOwTisiz89tmIlouAIapS/0GuqaiViWTSp37vh4Smh/S/RG7e/XnEdV5CAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFs8Ht5w; arc=none smtp.client-ip=74.125.231.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFs8Ht5w"
Received: by mail-oo2-f16.google.com with SMTP id 46e09a7af769-805bf8c2661so186359a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789512565; x=1790117365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2AxZZ4JLuYWEEwIQmkuTSjXpn0s6/YbwSOigBz4xQRQ=;
        b=OFs8Ht5wT4aKuuwTF5LF+CQvNbPstbTDxT/K3lfHKRuU9RiX/SP4LpjpZpcWa6+JGX
         3l40bAQcRtbZhRAZDhZbhOI1wquxbOrUgqkT4PxDvbG7uGt7+wpy2TOv7ig89Vc+/VFd
         zNsWHYhpSY8hNxL7USwa+9X1BsditeTm3d8MSgKViPkjcYpcyG3SUT7XJi815W02pOoE
         djPNWtZXIbpMt2Bzu36A3WhOTmaK5yagWoEFhLt3K0yL5aCf/kQNE7OonOzLF/kyXWxM
         ifrDU+KaNH+cD431HOLj7lt5kUlxRnFiUaSKYuN3NMLpaXtvYuBDZFgU355B0/7fBEyy
         9rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512565; x=1790117365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2AxZZ4JLuYWEEwIQmkuTSjXpn0s6/YbwSOigBz4xQRQ=;
        b=qIMMe3C0FYgOR3FZCSwmdwr10gbDpHy/lt/eiuOKZfSeICShKvvqoKXfmRYMNEIAY3
         gxW6g9Te0GIXWalvSCIADpOFTHn+l4eycKkvoHA4MPr+CZwFpigSehXuyHnE6xs2crK/
         ylOEcz7pgWjlDJLMmQ04Xqot9YTOsoABPaKCA4v1jTD5ZSmDFQtXXBihFg1phkxIbwgF
         bt6TKTggCQXmrSiie8M6j78uvvHZssndLmcJY/Cm34vn9Hy5tQOAkiCtJHymhnroNfMO
         WTWrfW7qNuIrCw0Hnf4fDgMlNh8PIdwUghN5AdtSq3eoxXhXfV2SnOR42eSiSud7KhqS
         WBag==
X-Gm-Message-State: AFuF++maa0/8P9480jRWK4HETw9/URSeSdO4besAMCxt+sPz0vEAxXmh
	fCezqVLJdbcNsoIBrP9rgbb7lWbScOAEGTva49cJjqtJFsmVSFuLgdqCD+Ns3Q==
X-Gm-Gg: AYBFou2Z+tkfTu6rvVItbZNeg1dvhE2+3YTRC0sDU11CtTwfcihuae0PfXA+EvvmMJM
	sdBJikTHvV6WipyoMPxwTlApkhgNgFC2OJJuhhgFPt/bD2PRqbNld53Cve9xtVZcbJfaz0+hD1w
	/LtJDMUOMnHwml9y53gUr34SeGXlmwkuMTPnnxavkiMJ7rXeTNKz7PsKRUogwn22Kem+kN/ncGU
	Cjz6gqNDrKUCQaMnaLReGl6nXBrzDkvavIacl8FFASFCPicGFKbhbuOVwoOpRUG2kAlPmt/XaiF
	ZKoXRL93iRlUn6OWruodvTuInmZVjBmoeDvDn4p9/HKHaIjHkb9dJ8nBuMZg6DNKEbNnjsd9C17
	zaEuxE5tmINHQVhQNcmIpxxhJOTx5MMSG0Trd7K2QRswEPBJwU5oyMY34ZA3GH0iZ5STIR9pAAi
	XkG6e2dLtJxYEA/dxIhHeuaSHRJy5rq5IYoHPJ/MStgb9zrC8jsGTji+iwQbIHS4c5mpJfmGuSi
	G+rgBc0GFxoEhAmbg==
X-Received: by 2002:a4a:e917:0:b0:6b7:46fa:169d with SMTP id 006d021491bc7-6c7d45e2badmr520702eaf.50.1789512565373;
        Tue, 15 Sep 2026 15:49:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.219.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a677b3bdsm1152192eaf.6.2026.09.15.15.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:49:24 -0700 (PDT)
Message-ID: <6aa9cb74.42bc1fc1.52aa0.7b6c@mx.google.com>
Date: Tue, 15 Sep 2026 15:49:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6812006555005220452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc/test-functional: Document PCIe controller passthrough
In-Reply-To: <20260915214410.1250646-1-luiz.dentz@gmail.com>
References: <20260915214410.1250646-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6812006555005220452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165941/

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      15.84 seconds
BluezMake                     PASS      276.90 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      118.63 seconds
CheckValgrind                 PASS      197.52 seconds
CheckSmatch                   PASS      209.66 seconds
bluezmakeextell               PASS      78.72 seconds
TestFunctional                FAIL      940.94 seconds
IncrementalBuild              PASS      283.90 seconds
ScanBuild                     PASS      812.82 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7fdddfacea50>
    searcher: searcher_re:
        0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
        1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
    <pexpect.popen_spawn.PopenSpawn object at 0x7fdddfacea50>
    searcher: searcher_re:
        0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
        1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7fdddfacea50>
        searcher: searcher_re:
            0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
            1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')
        <pexpect.popen_spawn.PopenSpawn object at 0x7fdddfacea50>
        searcher: searcher_re:
            0: re.compile(b'Acquire successful: fd \\d+ MTU \\d+:\\d+')
            1: re.compile(b'Transport /org/bluez/hci0/dev_00_AA_01_00_00_42/bis1/fd0 State: active')


https://github.com/bluez/bluez/pull/2532

---
Regards,
Linux Bluetooth


--===============6812006555005220452==--
