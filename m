Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16F345ED8
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791676331; cv=none; b=bW7ZxusxX0VlIg924Htl/+Q1qJ5NC6iScb8b+9fkF+QKsm7LzP7LGNAGwthv0wJZjDfSTxkyubE342WBuK3Th5c2kLeOyIxscwlbNpvaQQbR0KOCR5mBwVCO44FKozwgCp+9aii2DWlcLoPE6dsBeo8ItbeFkFNt/HBpqoM8Ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791676331; c=relaxed/simple;
	bh=SG66B3/1oHsVCtTEh46swjiHXrnhetA4nTMghG4yk7g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i4WHdvCSEmMCWRidbrsYIjwks4Azq/6yNP8Q4RULoClRtKrwUXOPvLzs3sKdpkFyV7NJnB+GqhZ7S08yEdP5LchF7M1HgPPFkyMbBChpcfwNvvkcJ+O/deTFYFlmN6rLA8SjB07m2Jju2VYvPUOPsHfTJLubAlYpS48SA9vsuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnApkw5y; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnApkw5y"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b55859245so16942166d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791676329; x=1792281129; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pwatc6Rs0sQdr3Eu6LtVPQE37Wy33uJetIyUH7BC36Q=;
        b=MnApkw5yITElPn1NRWIcLZ4FeeVvl4+tDxLZojAsCen4eN19dYsXLkphWv5nG4XjVe
         dTljw1m1c5iUlxImZXRkZygHtkFXAuyNiEtJtcHkHvrSXP9AShnXG9TyCX0sgMLv+oQh
         A2QoRLFA8JaKdCtz7Pltz2v41pl3bUHkG8LQV51pDuFjNo+Yia1vQSRIuUXzVeuPqJu0
         7hefTGGE1UTkU3ZmSemDfEggfbhtpjaBH0syDIoXs3YIlpIFQhMydbXE/MshzDnne7k7
         Z0+1/+Xy2XGuVjTSV5c/Nk/T4Pfo/NfMGBbhBr+LcGYL3c+hcLWhWipvHupvJ4j2TxM+
         MbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791676329; x=1792281129;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pwatc6Rs0sQdr3Eu6LtVPQE37Wy33uJetIyUH7BC36Q=;
        b=NFYdwQm99iIdfHFySUTqpULfl5T3Q4jFleRE9QuF8bUX52xNUs0giz6EKm2bw6quCE
         YajPqmIkXhb3/n9yzpqj6d0wT+Y4loH+gIA/5EfgoY4IxiErCaT6AUOjOxkiZZi5Vm8m
         E7z6k6gTenLFAwWpQoJYs06wUZO/+ZQn1sGsLCsGSScI3GN6paWH+UXu4xOSMyyc/CBS
         gS617Kg+/nsAfza+E5XOwFSzVvk41yrRfYKXgRO7vzIOjv/fczcPiFqGpstyXMlB1Vq7
         wW/ivQKLWCKSLiyNrfkn+g5x/mk6xmgfY5RKN/3f/lpgDnZdxsM/4mloHiyUzdkcSFMv
         ZIaw==
X-Gm-Message-State: AFq9FYJloYO1mst84mexynblMboK976kFaPlX0F+tJMGobJXnWL6EuqJ
	NyW1eC3aJWyyNt0CPfPfempC4de8bXq7tQqsTI5pNBm6mOQn7jL43rKVJaWc0w==
X-Gm-Gg: AYBFou0HHScqf7QpnbPnoEbu6uej5vVL8l7A2UqcvpkYVbJmn23BJ+q8JsK/vwHqIkZ
	X80wpNWi1BAFGC1venBYxaM0TP6qtCU+GX6WR0UdXHpNyQd68U8HskRrHNMi5mL7Lape2wTUk69
	0t+LVlK+1DStSyrY19Jf/RiFb43f+vTh6F4LgRbf8Kl5hZZRmLnz+GpSi9/vCyjnm8uJcs20xPn
	JM/FOUHns68QWdNpUgQfcQjlAizvdvAFe/qlDc0wRIFQnqqW7wa4JruJicceYpYKxRiZp5SQ3mo
	Omy43YFOCKkviRdmgz2cDUaM0sZIVmENlUh+gB+G3QvkguJCACOEIxRJfw8JChP5I5P3bt/5TGm
	J2L9ET1MPeFkuTXJxNfRoQlUzIzQ4nvd+jCbscLAGUUtUUVOzRU1nfgmp/TlLaGeqaqMiGQPfo5
	/xIPHtW4wzP463nyiK0yFaTC2gx7SDpyUofF9TuUHbJ2cZ7rU3r+7egpmLWyqcu7ZeTPoKtMQY+
	JVW9Q==
X-Received: by 2002:ad4:5dce:0:b0:914:525b:8ff3 with SMTP id 6a1803df08f44-91b55500fbamr114151956d6.23.1791676328969;
        Sat, 10 Oct 2026 16:52:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.79.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501755asm57426796d6.12.2026.10.10.16.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 16:52:08 -0700 (PDT)
Message-ID: <6acacfa8.33ea1a9e.2790f.b821@mx.google.com>
Date: Sat, 10 Oct 2026 16:52:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1631775841882687131=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] test: functional: retry pairable when Busy
In-Reply-To: <32b040dbaa0b8bffa4746203c5232791574604ee.1791671481.git.pav@iki.fi>
References: <32b040dbaa0b8bffa4746203c5232791574604ee.1791671481.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1631775841882687131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183123/

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       FAIL      0.33 seconds
BuildEll                      PASS      19.45 seconds
BluezMake                     PASS      395.99 seconds
MakeCheck                     PASS      14.27 seconds
MakeDistcheck                 PASS      140.10 seconds
CheckValgrind                 PASS      231.14 seconds
CheckSmatch                   PASS      291.30 seconds
bluezmakeextell               PASS      94.29 seconds
TestFunctional                FAIL      1192.23 seconds
IncrementalBuild              PASS      388.67 seconds
ScanBuild                     PASS      1125.24 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] test: functional: retry pairable when Busy

22: B3 Line contains hard tab characters (\t): "[bluetoothctl]> 	SupportedUUIDs: 0000110a-0000-1000-8000-00805f9b34fb"
23: B3 Line contains hard tab characters (\t): "[bluetoothctl]> 	SupportedUUIDs: 0000110b-0000-1000-8000-00805f9b34fb"
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bearer::test_bearer_le_connect[hosts14-vm2]: pytest_bluezenv.rpc.RemoteError: Got event.kind='org.bluez.Agent1.RequestAuthorization', expected kinds=('org.bluez.Adapter1.StartDiscovery:reply',)
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/agent.py", line 108, in expect
            raise AssertionError(f"Got {event.kind=}, expected {kinds=}")
        AssertionError: Got event.kind='org.bluez.Agent1.RequestAuthorization', expected kinds=('org.bluez.Adapter1.StartDiscovery:reply',)


https://github.com/bluez/bluez/pull/2659

---
Regards,
Linux Bluetooth


--===============1631775841882687131==--
