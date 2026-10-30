Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374928;
	b=kTt7nymGH1LhnJ08TGsrZNzju3UPSvnMPZihMeNglvSQ6HOXvjuxpq+QrNWrjK3tdCK/
	 1IcS5s/k4qI4Ji0blC498tvI+FqcIo4lQBuAtty/iXoB4t3hy05+7+CmauN0gKfffVyrk
	 Z1IxO0jrefPuNLBOBrqt9v4lBm4lRMaJZIpcALwByu7l9V754oWv/3fSR0Ccl1mTgDOQs
	 YQn7vBqYJCJJEPu1HLbb2igwBcon8LAlsgQG9Va5Mm7KP608FCtg2mq7b5sYFx1Wsabg/
	 3A6tr7r9Cpeh5+yWvEbEFXeZFs67NiQkuKt5yFAa7ScC5v0etuTRxOsy9ioDkuKSdEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lHN8T+Nfms9zv3Q01Yj5oRdknz3z0jsGTdxNHyyAUjw=;
	b=huwFDEJREQJt2hlMk1JMmA6uXpd+bMZ6dY4AU/xVPhbZxckMXmEcX0AJgssntMDB62tn
	 GmpJ5hAnebb9npj8wMAT4eN+Q6d8Iai6lK2roGBMlBKkobKPv5Sb7jvuIsbMkUlJ8BDEM
	 LQyZI5Vlfd36dRUVRA7+cdzKMykgxCqRgzvBmjzxliL5bjv1UdNYMRz0DK1q4qaIqYIqe
	 GuQ/BjGstcp5m+u1U4wLG41PpZdokrqa+liWdOxN9BGAL59sSusg3Q4bzV8IFbrvo/FNL
	 cc35xjA65Q9RWiZZYHltmSHojz57p/VgH2NMNairLlhhP0NOLIVAn+KcFdyfFAkF3oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bRAP/+Qa";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EF606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 15:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 594EF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRAP/+Qa
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so734904a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374928; x=1793979728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lHN8T+Nfms9zv3Q01Yj5oRdknz3z0jsGTdxNHyyAUjw=;
        b=bRAP/+Qa4T3U8RZxmYQF46jSQwRcVSUI+MGdxz5KlNdbX8rSZb1eU2hiU786tBoXpV
         k1y0V3xaor61zgz6DF1PKRrkTn7PsH7EiWN+xHZiujtgPGQLatN8cBvlFEnc3WEiPdrx
         8pC3tStfPfXw7j9dnyizxzEBXwXYv0MjCT7k40Eqy/BzcqGi0QEjwIRgtqLf0fmyoTlt
         T1i1SIIeFcoEU/hPftJcOi5A9U4WwEoc31ydWCc9CNoEKHl/i7mBoPhxM4dJt71hHioZ
         ir5dUGN4m6L/bD2ntAi3YOujqO9AbTfKVpsgdr7LvhQDtMsnppUP+nB1sg7l+NX6bz5e
         qlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374928; x=1793979728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lHN8T+Nfms9zv3Q01Yj5oRdknz3z0jsGTdxNHyyAUjw=;
        b=zO9ZujSw991kJNFJXivew6oEfP7pc6nnxGB1i7zyh/LapJG8ANUtHoTqtO0vK/Nu7u
         QFVopT70xtm0zFMu7exSNkdi2x2/23gpAdhk1QB7l/VFziKWtE6B9Pz6jqq06ZdYnm8t
         bCj84AEaX8PlfyBufaJUBF/s3EXXBJ63pvrSZZqBR0oWvIrTeIbNny9J84IQ+QEMjobV
         O1Kxn77SMWsTjxZAcOvTH13gdStgWfj6A7aO41aU0QzpUFyFRf1ivI3oAWYm/sfFQGVh
         4sFE4+RhMejTm1+7hWohuCMg1WNBZCVvdXr8vDPkiwo8hK41PRy9MpNNf3YSD8K9n7VX
         AkkQ==
X-Gm-Message-State: AFq9FYIeec4eHHVGDiaOHB9xyDYggDKuGcD4a2pP8Mm5GDL/i/jgpQq8
	s6SjisewndMSbvAAXv04RtAGapJZnax/NsTZOPQSk2Rib9WI3YCnh/u4YlHGVg==
X-Gm-Gg: AYBFou2ig6J3t8bBFfyzr2CP+xxiKtXfjyJm/u0+9xlC2WORzoudOIq5WA+arX0kLTR
	KgSsosx/3gZqHloYhIXouFZDpoOq1PxEAhrfQWgGHP3ldgCMjed+a5WO4FYTs8h5/4df4GVy88g
	KY0+amobPkuJ6WpDXbOtdpzMxy/d78nc73AVx4s5iajqBDp5aIq6drl4gXxfmCheVcsYyXCfP0I
	79d0e/9p46Rc/wf7wdVU8RcCNH5IT/onzHLCKqVYlgbOFNrU//fdJC92tpyeqgjNmdWksiplnsQ
	AiKbFWim3KCvczl5il/sTw2/AWC+eRwDPC6BZdxQuGwyGoDEKTJEA3oO5KNQtyAgaON8faWinNw
	ZFOlkebNpLnzKAUNeOONpMqV35cl5o1QR0klpoa5poc1yvC2bel/AoqoQgbTr/RfdNagE5azWAt
	Swstl9m8M3gMYTSyQVIrsKpBh4xA4UVi270k8ZxVI5anunplZg2ipjXE3LkJSxOKIw/Z3pSJuIm
	iP+evQCFYKR6CwGbypPXIjr8+XZd3zYfRwB6Pur6OMcgM7MjANyR9PrVrL1z+1K3haP6ocPFEBN
	B3QQlgA=
X-Received: by 2002:a17:90b:33cb:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3ae895a5c2fmr2266016a91.5.1793374927633;
        Fri, 30 Oct 2026 08:42:07 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.44.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b4bcdsm968402a12.5.2026.10.30.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:42:07 -0700 (PDT)
Message-ID: <6ae4bacf.3b75116a.ab96e.316b@mx.google.com>
Date: Fri, 30 Oct 2026 08:42:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3636387823455140771=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/timeout: Fix use-after-free when a timeout removes itself
In-Reply-To: <20261030134426.420979-1-luiz.dentz@gmail.com>
References: <20261030134426.420979-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3636387823455140771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197185/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      21.82 seconds
BluezMake                     PASS      314.02 seconds
MakeCheck                     PASS      14.62 seconds
MakeDistcheck                 PASS      149.26 seconds
CheckValgrind                 PASS      237.84 seconds
CheckSmatch                   PASS      298.50 seconds
bluezmakeextell               PASS      99.67 seconds
TestFunctional                FAIL      1202.82 seconds
IncrementalBuild              PASS      325.06 seconds
ScanBuild                     PASS      1181.22 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7feaa5592510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7feaa5592510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7feaa5592510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7feaa5592510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2738

---
Regards,
Linux Bluetooth


--===============3636387823455140771==--
