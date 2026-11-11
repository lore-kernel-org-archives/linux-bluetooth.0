Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399313;
	b=EzJujrThdDMHq0hB9G1FM8YCTvy5vdRycM9lMkaX9OsJXUbFMbk256hBlY3pz0j/WD2H
	 EcFsTZaUz1YrJ2pGRYYT7c1xgQRoT4Ngzk44KcLthkdAVTjoIFGdGTu5rVABmhgFHB7/Q
	 xc/s65V4FFKxwREVklf7HlJZisRXqpbRiMUaE8A+Q6OhpuGvu4hMoS34cN/fGkOLDZh5S
	 MaoQ75gr4u4gid2ZQz4XQ8k3Q7H1R3ivqx0Q10X8U5DlrzL++bzQzP9AzHb+N5OLDRkXW
	 zJ7a0nAu1grUhyXOGqOdqU0prJ1mndO8E3JEHiNn+/YeldpsLtjDReb0Cjv0/pLQGlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4S3phb2z3KhFYoqLlczhInELSuejeRl/QBZeGxK1pkw=;
	b=TO2uuAsUwf8lpKZLybeu2u4pXdBcuKXqW0vUB6+/ZzMmdTTXXYlys493bTrje756/Hiq
	 dQ+9LtOb/5XP52P5o8sFZg8ETvKzxco/zWSD+Jt6TuuatVuTCi7zZKqWZQaYvqUCAJWFh
	 mpddHOVyxMSRjLsNFthwLmbQBp4gchlVzqPaDQDlljLham9w8fQ8FfJRJckion31noAoi
	 jYRBDi5DBzYJE+BMXPH/Dc8JeQ0G3t0mzpulx5owIxEyeKo+QpxG0x1oxhBEHBbsLYXoK
	 omlwkt0cOBW60jvXaLiFhH45jQvpjYDcNe3fr+CkgxP8J1aWm8ORBIVvyANk9/3VNIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irE889kM;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21360A2637
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB21360A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irE889kM
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1749202b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 04:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794399312; x=1795004112; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4S3phb2z3KhFYoqLlczhInELSuejeRl/QBZeGxK1pkw=;
        b=irE889kMQS2YNUo/tnHLdogTRU5LqTE1pxSo1MMC2Pm1FeX7qv6lAEuk5PtxKCrfpX
         bWqhQE1menr03OtM0blwLq5+q3v1uC+lOMAdnEoR+9ZoaawubTiOFiYT5xRgbi1cxKob
         YxrJa10DyRAdR7yMW4Buo6ohlZF7xmPJOWc9SqPFBEglm6effDA+NxlMQ23IGrrSBbTd
         DlWaKmiztfS2udWjRD0y4oHJYYU+5T18YQAR0yA4nvC5R8B7Xm93DqzZdILCmFxKDKJH
         dhIf0biPaonMkL9DBsxsG0dxoPPSa2hIgbGI1k9Q/aPz+qiBvaUT4XXzEhI8u3rGpfq1
         pVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399312; x=1795004112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4S3phb2z3KhFYoqLlczhInELSuejeRl/QBZeGxK1pkw=;
        b=aWGyn8RUSeTV5chSsn+NDvO5DMOgzAYI8puHij9KIGxFb0Gc4uxsvCFkP8iqP6c5e1
         bnQCTf8CzzE2muclfmMpxRCpkrWroiZy2TgrOm5Y1ZAHlZDINoguXsuLxN/mDbWy+ASv
         eIIiDGytyJdS44O6IVp1yAAAaVYZaAXcNuD9MlGR4dg/i98k9jzfom1dSi+qKIGOHBJl
         URZr055ZzF8B0l/z045CdKmoE18J1/7X2qeBeNklzBHIi+IczbSTjAEDar86O9PVPo9L
         HymiSkoKP/lVk7CfXxAkzPuoMh+qqhd9m82mQy1Vl9hvF5E8glBOchjj2jpt0d7W6L+n
         l3+A==
X-Gm-Message-State: APuU4Z8k9+CNTJIn1+YjvcH7DpngIMRS7I4uVyXcLugM5Bpab3xKU4lP
	YHTH2QKXdeBmPaKB6Oocq7rJFDGMFFRaa+NYvMjZ5iUmqk6hzwg/WQspGgoTLw==
X-Gm-Gg: AYBFou2Yx5RFoXnbbdbOAptpvdeV3A+uczjsA5QrX7Brwl3DlK8tgslwvOqm9EGJ4/Y
	R6QGED1rw0GOIy1m62eYkfLftXhwWoKoPAFro9Ps4D5TckdKs2TO2DVnzqq8wNUCOKYIjrHdoDS
	HtE7SqzKnlVN9XxNW54zX84BNeB8WzdoA8SUdFqD4eV9BdE+IMcozpRrKFEe398t0jPqKKgPmwN
	UFKx0Jem/31hNX6wCmFIp3qJch1Id1J7/ltFlEKqPth79u2OUtyL87Fpu5KC1I2K5Lg2MoyM6mK
	FgoQbfQwh7hJlo1r9gA4VGszSM1VZqjcRA2r1HLG282mWP0tIQiAFKOzcOZHbToHJ89YNHmwCb7
	qizxJdechOgQhfeVm/+MnbgbQtfkKK8uI7H1QSqcmuergiJcD8EneqPicHpZVse9j+zlssApO9z
	ANXz7UPCCyku/IV8simwR8f9PiXlfr3n23K/67cLo7vFgtk3XdNk9GD9rFHfZ0ARp996/3j0ysw
	BAXVLfz693NsQIUyO8cHaYxmEbJofYkqUHBPdFfvWk8eeLfDGT3frYFd/UybkiNouGz76cvoKhP
	3GTKKjtvLA==
X-Received: by 2002:a05:6a21:f112:b0:3e1:898f:a10c with SMTP id adf61e73a8af0-3f2feee6fd1mr1567577637.84.1794399311965;
        Wed, 11 Nov 2026 04:15:11 -0800 (PST)
Received: from [172.17.0.2] ([48.200.104.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab21a142sm2100785b3a.44.2026.11.11.04.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:15:11 -0800 (PST)
Message-ID: <6af45c4f.c2509344.14424c.98d1@mx.google.com>
Date: Wed, 11 Nov 2026 04:15:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3482264174554401728=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
In-Reply-To: <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3482264174554401728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208162/

---Test result---

Test Summary:
CheckPatch                    PASS      8.03 seconds
GitLint                       FAIL      4.37 seconds
BuildEll                      PASS      15.90 seconds
BluezMake                     PASS      225.12 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      115.56 seconds
CheckValgrind                 PASS      274.50 seconds
CheckSmatch                   PASS      224.49 seconds
bluezmakeextell               PASS      74.26 seconds
TestFunctional                FAIL      3064.97 seconds
IncrementalBuild              PASS      277.39 seconds
ScanBuild                     PASS      825.36 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,06/20] obexd/pbap: Reject PullvCardListing without Name in telecom folder

1: T1 Title exceeds max length (83>80): "[BlueZ,v2,06/20] obexd/pbap: Reject PullvCardListing without Name in telecom folder"
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[hosts1-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts16-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts16-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts16-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts16-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_btmgmt::test_btmgmt_info[hosts19-vm1]: AssertionError: assert 'addr 00:00:00:00:00:00' in '\x1b[0;91mReading hci0 info failed with status 0x11 (Invalid Index)\n\x1b[0m'
     +  where '\x1b[0;91mReading hci0 info failed with status 0x11 (Invalid Index)\n\x1b[0m' = CompletedProcess(args=['/home/runner/work/bluez/bluez/src/src/tools/btmgmt', '--index', '0', 'info'], returncode=0, stdout='\x1b[0;91mReading hci0 info failed with status 0x11 (Invalid Index)\n\x1b[0m').stdout
FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_a2dp::test_a2dp_disconnect_during_setconf[hosts0-vm2-accept]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_a2dp::test_a2dp_disconnect_during_setconf[hosts0-vm2-reject]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_a2dp::test_a2dp_reconnect_pending_disconnect[hosts0-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_connect[hosts12-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_conn_params[hosts12-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_connectable[hosts12-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_pair[hosts12-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_bredr_pair[hosts13-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_conn_update[hosts14-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_not_connectable[hosts15-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts17-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts18-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_hog::test_hog[no-sci-hosts20-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_hog::test_hog[sci-hosts20-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[bredr-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[bredr-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_obex::test_obex_ftp_list[hosts24-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_obex::test_obex_ftp_get[hosts24-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_obex::test_obexctl_list[hosts24-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_transport_resume[0-hosts4-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_transport_resume[0.1-hosts4-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_transport_resume[1.0-hosts4-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_reconfigure_metadata[empty-hosts5-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_reconfigure_metadata[media-hosts5-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_desync[hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_duplex_enable_one[hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts7-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts7-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts7-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts7-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts9-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts10-vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts10-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts10-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_created[hosts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_acquire[hosts8-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[le-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[le-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"


https://github.com/bluez/bluez/pull/2794

---
Regards,
Linux Bluetooth


--===============3482264174554401728==--
