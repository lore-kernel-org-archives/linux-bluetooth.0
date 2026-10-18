Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F481CAA6C
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792308163; cv=none; b=k66BAGm+Q6hqiPWNE3cUHU2+9f3oKP/heuNUKi++Gm2uJE4OEEbGpH/ZaiUFAjcXjzjr57of5pOkIOUykv3a8iErpwasIRe4Kn68RIcLtQwDIPhxfS7Q6WK8cN5i12X97PcdGg6zJivV5OfGwGgR7ATKv1E+qS+yIesYUDwzpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792308163; c=relaxed/simple;
	bh=xQiYD/7OlnK7AUWJGabeGFcuq9NqwUyyS/QBCuJbTtU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nmkDuURvW6xzv1O9eTNmMrn3v7y9y72/bYxz+Hkkog8OBYUEZdnMvjsP/jqHyi1FC01KKn6jpPEjWFLUAgSsdA5I3qOAt7gkA8N4apqieM5EcBPfQ96Rw44O5Zitmx4wTElEloZZQ6L1l01UMSF0FLTyKPOzxPBWM88nm9/mOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5bWF+54; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5bWF+54"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so1057269eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792308161; x=1792912961; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZKA/5fnRKw7ce9kAeHf2dm6n08t1Nz8ut9xJhSCiRQQ=;
        b=P5bWF+541r22+Bqu39L5ZZqMVpwiBvM7SNcjE5PR7Mg1WlDPQBS2sq3Dq10BYsPAQ/
         eeEWKq+F5NZWh1lV9O9XOis3GRTiZXhB4Ba8sGeneEzmgANgph3cc9aqOd9QCtKZCdd+
         1JhCRx8IMJ0zLCPDWse/3mYQfqskaPmas3hXZoFwzuhmo1UsAC/0GLWnLu2xyMzeaThp
         WVkAuGGQZgUzPsBSZ6TH3iILyy/QAUWl9IaryKzscJJg4mQ+DqAzXZCYd7JTStZTnp41
         vwsnOUzR+uXmvNb5c3wbq1P7l3UWUSDV1ozmwfL7pvEDjRC/Ll+OtKG1fKdieqBmsk+f
         g83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792308161; x=1792912961;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZKA/5fnRKw7ce9kAeHf2dm6n08t1Nz8ut9xJhSCiRQQ=;
        b=toK/FZ0IAXVMiLBu/jQgh4AQBX3F4pf7Q+tXxrY6TUZIdHPuvWUyvYqW122xEdIfLN
         8jniHh838ItKbAhPKoxHbEIVQQucWPnvoHMvYFEAjWCLVfrzGm9hKnHbcqosuIrXppe7
         QmnF44C+ktybequOt3u7uKSERwsxAIPBH6+OFdH73n/00CM/r4/rlJ90LpIQgEreGE2a
         pa60FRPtsKFuV0+HNo3dEnfRjdagGrLOdrk4JnS6QdQEWtIOYKOI3Eabw10OqahyA2YD
         c2rdrYjLVMKXhBmxmqrVIc/946Qfjxz+6lE7QfTgaME+O6IZqc5ej8pZ7NrRTwQvZGL4
         Tq+w==
X-Gm-Message-State: AFq9FYIC/16B+y7PJzUllfWSfPJnnplKgP8/wyOxbOUym2j12b8LQq8V
	ct8OHgXrqAGTaIOcISoOnH0RTGAfVAEualPVq0prNtdOYMGPy0N09g4NdDI/hg==
X-Gm-Gg: AYBFou0c9yFZ37f5h33/6zUpIeIm2fST/ln4GXN+oBNf8Ko1iajH9P9IfA0hsMqLwd/
	HM3Wk3DTL9Zudzo53MvbCHFxWlQ3JTiTOcRe5yLoftY2R8Q57P/mfzJhv8y16gzsWYi+M19GUux
	jiV9CSJNrIZ0ZkYRgVYcRGeDenrb2UBYPP7BNEX8aQm2sIacv+tMtkDO25fEQ0nEgqyBTCEzlH/
	aW5g31hqd9sbQWKayQIu5PiwkSbkIYu1pPxeAKADuKrEhrxK1YiyY7ioCHBXpBkAc+Gtd2G8CVP
	DlgatuiDYkUrhYi82j4itvm79PtZQywQ/Q+TCsUwjkWB8ufSkTp/wec8jG7PXg2mYpDsLmzK4Ww
	DhrLn15zz7QtaAuO5vTP7ZZQNrJO/mv4FxqDBa4hhYY5Qt1qD7AlpH+OOuPGU2AoLiUePizrM4d
	6ycs15xQ83xzgH/f9xtsh8d/uYyb/eBkSaf3ZK3PqzEe1UKN/UnRtxsVfXm4hMdVCBmxq09HhPr
	w==
X-Received: by 2002:a05:7300:dd04:b0:35b:85fe:5b6e with SMTP id 5a478bee46e88-361a264b9b4mr6571901eec.22.1792308161004;
        Sun, 18 Oct 2026 00:22:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.6.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm36681941eec.28.2026.10.18.00.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 00:22:40 -0700 (PDT)
Message-ID: <6ad473c0.7d74b517.6affe.ac7c@mx.google.com>
Date: Sun, 18 Oct 2026 00:22:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1166854284163196622=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] emulator: Avoid variable length array in send_cmd
In-Reply-To: <20261018043911.1756937-1-yaroslav.voytovych@gmail.com>
References: <20261018043911.1756937-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1166854284163196622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188166/

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      6.64 seconds
BuildEll                      PASS      19.45 seconds
BluezMake                     PASS      291.76 seconds
CheckSmatch                   PASS      293.09 seconds
bluezmakeextell               PASS      93.68 seconds
TestFunctional                FAIL      1149.78 seconds
IncrementalBuild              PASS      295.73 seconds
ScanBuild                     PASS      1132.20 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f09b608a7b0>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f09b608a7b0>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f09b608a7b0>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f09b608a7b0>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2690

---
Regards,
Linux Bluetooth


--===============1166854284163196622==--
