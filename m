Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA22D7386
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762874; cv=none; b=S7z5OsSM4VS+1RKKK3wliTd/Qy3cxXI0/5Lf7Klz/y7ouCXBSFqj11nWA525HmiM8p8zzqaE6BYkzpO9jemfCmtz+CULkrkuskpSabVQUYv/HPf9+Oe5wnREqWH5bA1jyr6MILjKmqRkHuHr9r8cTn4j7PeH5U4LtvEY3kpWEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762874; c=relaxed/simple;
	bh=HpM4IrXgvnfcoHy0B5S2tbV+m3OLxVjSbFbAoGlDbyQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q0+t10AsoM2808RiTRj2LBDfCQRuFdAiOp1RekUU6VcUTHJAKZRQXTShNo98fD6yKOEYJ5FaRmGBy7Z21CpW//98FwFbKUXv8gawV1iLj6QtHWNtsB8fSbTd7AgKuSQgQLevU57R29ySVuDqROSeFNmYb1t/chNrco6fAME8xJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCbg64Yz; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCbg64Yz"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so1463464eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791762872; x=1792367672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12HGXvhu5+7iyv+cgeldH6gKuo47Cv/8Bx3fsxjgDBg=;
        b=bCbg64YzT0viBf92VYf65FuJrBu/1uKGqg+1HQUteLAGz0Z2AQQIEb73EgbeOjYlVx
         xxayim5+2YT592tIc4y9AMPL4DPZ4vu9ExWr01DStHUPntPvqwoLoX0ot7UeYjyhtrvQ
         4IzQw/hPOXOq6Da2uN15srI72hesO2R40opzQf6fajoc0GA6HvRpd5ihTzWSnM3mMAXD
         jFuvkFfjATg7TCdd7GPotjod3LBZGicrPA+Z9cbbPyN7ahPbxjkgztbLwkv5Jj+UFAn+
         rHfHRXYOGi7op1KrAW6Hy1UPDHoe7c74v5CloHpz3n6ImnMjDLDig8QBIHmAPG6CSNmV
         ehTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762872; x=1792367672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12HGXvhu5+7iyv+cgeldH6gKuo47Cv/8Bx3fsxjgDBg=;
        b=1Ioox7o/BIuSZL7/oHnFbYJeEG2BudPxU0gSBv+B+D7Jxwz4e2/xMXJVj7h/b0geTy
         vtPUsutr82DFMqs5nsHm/XWyhFppXh2ixE5R6YhntZggfJtzcEk/8QIkiBp/Po82o+K9
         LTyFYKyBsbQDVdonmqs2tA9n02ntLkIiXI1Cudy0GT9jujqaQij/CK//bmjoSgE5CCqq
         enVc1x9k8EVZS8PpCNysvTEpK0f1v+riaYCnU7jVRxZR8Th/BaEo785GOG78FpoGgz6D
         RwvUDuEk4GwP9NSJ7uAbs+wtmHLqM/Rep4E7O1F9Uy9agaVF52ol0zwvvMmSXQNpdb/f
         k3zw==
X-Gm-Message-State: AFq9FYLDzDAipHakQXcOE0HCly915g9DHOM5RgyhvAoJOap0u77XFPHH
	o7QH+op+8O8NzogSIZdj8LNVKRteWSSYCJf3k7zi0VlGCDtvAySdTy87MdfLSA==
X-Gm-Gg: AYBFou2+6PNeqJbUWcq6ftMzD9h9Ad2RmdC+EMJW5l+ZvGPaCyGRmLo49spkvfsqKky
	DgtmBS/NJd9UYNt+hvzMsnX+RXpEzh+NplGzRV09yED9kOOtgkN0DsLh58VJyqlXTsvRyiEHSSn
	EO4Bm2EtS4+Auu1lS7kNj7B+wbOsVUdJScB5lSbvSryFMf+orAe2HHVaT+PAFmCNWxV1v+KMe5h
	Zwzsk0uNeJwO1qp2bGg2LrwKlEXPlIQ4XwytIGXdkGsRJ2DuoLyUyKl4nWxgPCTG0UyG8UbvZur
	6nRtJ86f/irCHy/c4Z0YqajRLAedor/AQsgpDieekbnon0J/fkI18/iBz0Nf1tJcqSewaVkg/Af
	3yfW7lzpYXlY2+SY/KQYEUWi+QoL/5FgeVgeXzuuEpiA5BSvOhGnDrZtBB40xWsPg0EJogHXGTg
	uJs8JrZqIv7LOosPBlR0OA7MRtA715XiUZjoa1nPFbZhQhhmVcdm2swUjEIOuDoW7AzOB/epEzR
	DKpOtE=
X-Received: by 2002:a05:7300:4306:b0:34e:67d0:bbb9 with SMTP id 5a478bee46e88-3537e0368fdmr17765982eec.29.1791762871769;
        Sun, 11 Oct 2026 16:54:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm24620817eec.29.2026.10.11.16.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:54:30 -0700 (PDT)
Message-ID: <6acc21b6.0dab3a27.1e6ee3.7b1a@mx.google.com>
Date: Sun, 11 Oct 2026 16:54:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2155561331470427592=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: bass: wait for PAST listener readiness
In-Reply-To: <22736ec1d4ec6288aaf4c62642c65910dba6c591.1791750393.git.pav@iki.fi>
References: <22736ec1d4ec6288aaf4c62642c65910dba6c591.1791750393.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2155561331470427592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183466/

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.20 seconds
BuildEll                      PASS      19.26 seconds
BluezMake                     PASS      382.69 seconds
MakeCheck                     PASS      14.01 seconds
MakeDistcheck                 PASS      138.19 seconds
CheckValgrind                 PASS      228.68 seconds
CheckSmatch                   PASS      289.47 seconds
bluezmakeextell               PASS      93.09 seconds
TestFunctional                FAIL      1235.95 seconds
IncrementalBuild              PASS      749.51 seconds
ScanBuild                     PASS      1116.57 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7fbeb5906510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7fbeb5906510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7fbeb5906510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7fbeb5906510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2662

---
Regards,
Linux Bluetooth


--===============2155561331470427592==--
