Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484843;
	b=vO771anB65xlTTdm8+A9QmwShG3bS+Ai44NsZitP44WdWiHttWEOi1SXLUAa7gAWgOYu
	 raXHBedkCiknvBL14Xjgdg7YOKpn/zsbbBqps73UeVMYAfZJZpPNMLckXlrNnhpuhujHC
	 8MFIgRokSHm2x2AO4BWaUhkw+pehRuo7NYtJ9mP9Ia7SfzIFGuOZQ1viQOl0P2tWgz+ex
	 gjlnDsU5XHTvxUbSGLLXLuBZA5mSdlw3VOvOB+jinZjgE/RKH45q3OVwsI9WR/uYSJ12n
	 z4fQJxHGjEHpe6bE4B7jYg2I88JhKEkCDpsZFyA0FOyuIrEaLlxaKkVhtTOdV/oWG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wZWTFyJ+5Sc6m/O7t6/3R6owl5dNbJg8zK8mA6KdywA=;
	b=uue9QAb7e1vpRHS7JpaqpaWHSJHLXLPXEaTwAIVOEFZU6fy1vptysW0Bd9v7xO33A8/P
	 zTqYxoCW9un3cYmbWTfLZAQLrnYEs19sEKrhdokrRsS7bQVr8PwHLhjPfmxTYdIcX7u3R
	 wtcrmEXlRxLEXR+Uuj4T+wnKC8AZoyHeQyge0ljh4Mt1N0LKS3CBHOgcUrt9OyvcU+m6g
	 tptJC9pEnZ1nzQRYt70afZsXsKUu6HO8K2Or1v9jH3bmjxHEDeJs/4V4uznQ9tyh8dMIY
	 PzylOdSXrV+KkxEcZLd4azeYCW5YCjOea2widrKvrSGCCossdvNUeVHfEs5hkBD/4IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W6On7fhs;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87C606A31F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 08:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A87C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W6On7fhs
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53644b28706so33353381cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792484842; x=1793089642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wZWTFyJ+5Sc6m/O7t6/3R6owl5dNbJg8zK8mA6KdywA=;
        b=W6On7fhsN6QRRjqjiIOoaUYH/BFmtNRdwNKcEWmizBPvNmQ/dljy9qX46kjmU33RK+
         F6RaIIYO1yZrQD12egyDJNHC/VV7OIurfQ8P4/gpyFARc5nHk1H5xmXCeN65M+mIFKpj
         e0vArvajTb6shlevUNDXgZMnQ2zjeC5a+Ilws4O/yxlSFHUv7cacoLos+tDhJLuVuTaj
         gA+YMsCyolxRwAhsP6soEkSXRtzntLqno8OmrCBE0uiLM0Lrje9IaqxRLLQDeUMgEn1C
         UfHxFAIfGUPa+3sYl4aGcrMEO5O6g9mvTCLUvpJfCW4DMKtnPF7I/sFJFX1TTcj9ud7N
         8BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484842; x=1793089642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wZWTFyJ+5Sc6m/O7t6/3R6owl5dNbJg8zK8mA6KdywA=;
        b=s7M7phktqeUJbfhfNVBdTwAAOi2wgZGTwAIQPER3VB5xRn5771LEldMaf1TtzKBDtn
         bTBewNjf/WpbkDe2Hv4e9GT0f/zS+zoxyWxzqjsJxqwBpbn8JZZ4Pejxt8h5MOQ1FPi8
         uspQ138h+dd24jsSKsXBDQEDNeJQNyMiGkHtQCMjiII8ox1Mnbm8EMfmu0ea6Knx7BCk
         0kPL7VysUhvi6RHcWAibnZjYFrKtTb++sHxVca0ccIn9CPS2RBT9xTXNIVGBwbkgqPnn
         p0B+B8Z/o8tP6a2QFcbst4ZtBfv7rjcAUyjKLiAklvK3hn84+5gu1hAaxoMixSrOSB13
         5KJQ==
X-Gm-Message-State: AFq9FYK5IKWfzXbdS3hUX4FjlcXu6gfUb8UF8BLrbEuK2VA2QX+OuO34
	CMphmu1R36HgnHUTTq3nOCxdqBoCzvVXh2C2b/S9X55eZarj30wRKw1Atxbk5Q==
X-Gm-Gg: AYBFou0IRLj5QPe0tf0AqVZsdm1rExKBCFQBpgXs8KU9zq1Zuc9djKln4BLNOR5tZg4
	+lWGSgxmIyhWl2gvxkLJu1vsJ6n10kPM4xRB/UveFhjdgNUvF04Nj0diPPX6Wlhhf18R0frRDgq
	zJNeBn1dmQcP08cfBCC33guLEWsEU5kpZw0U7KCWlu/izxmLMCC9TOcaGWO1KOhzIUKVMW55AgP
	3lN4FAzbYQ3o5hWwyE2Tvj2X+J0HWRRXLUfarkgMAFTYRKEvLUOhMwl4JCGKZgrV4qUAS09xOX7
	YN6X44LQFWd8YNX3WdGWr5WlijO87kHOYGmRHfN+PuarDvb+xT5hSmolojISXukGpGu0JmbMRxh
	ue4OP17DgGObUgCfCcOtVzJ01BoRh4WUeJwzuQcRvNDc5rk+6v8p1dyFN1tuhYfkD0gnpaaZ/Ht
	Z8Djn/t0Z+hM95PQPRsouJlx3nsXXCgpkBHfQ8p05dLXX6OviMcKe3SMt02nWOIpJheBH26GyYK
	9FlBlo=
X-Received: by 2002:a05:622a:144a:b0:536:702c:f8e0 with SMTP id d75a77b69052e-536702cfb09mr77517101cf.49.1792484841942;
        Tue, 20 Oct 2026 01:27:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e43cfsm118441131cf.5.2026.10.20.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:27:21 -0700 (PDT)
Message-ID: <6ad725e9.cd07c4aa.22e276.36d2@mx.google.com>
Date: Tue, 20 Oct 2026 01:27:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3080994402510498688=="
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
To: linux-bluetooth@vger.kernel.org, sadiq@sadiqpk.org
Subject: RE: [BlueZ] obexd: Handle message read status change events
In-Reply-To: <20261020035617.1089331-1-sadiq@sadiqpk.org>
References: <20261020035617.1089331-1-sadiq@sadiqpk.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3080994402510498688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1189420/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      310.73 seconds
CheckSmatch                   PASS      298.66 seconds
bluezmakeextell               PASS      94.42 seconds
TestFunctional                FAIL      1166.13 seconds
IncrementalBuild              PASS      303.37 seconds
ScanBuild                     PASS      1164.03 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7fb36a566510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7fb36a566510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7fb36a566510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7fb36a566510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2695

---
Regards,
Linux Bluetooth


--===============3080994402510498688==--
