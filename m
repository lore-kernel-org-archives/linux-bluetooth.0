Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE66517BC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921545; cv=none; b=PcuMikHmrD32itRv7Rtf172Y0/bWrsyoStC+lOK65evMT1oXO2FG2jnAQBcVJe6XfpbT8umuNzcUDbhiDmYfaDB4yYksDKjOlgDEM2Htq/5pIeDv271SWiTt5+DnI2bS+2mGJQ+xlQc7QLuXPImJUAhwioqpCZ30sSuqDPLDWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921545; c=relaxed/simple;
	bh=l4P4pQkqUGvo3MQ/FRStkAHTzlGu7FZHsq6+Tiosz+w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=neUdDjluksbcl3H/X7KlV2ru/jqRSLY8UMV+T2l0+VN3lnIjdlPD1d3udIGXdEuVbBY4Uda1ef42kfpuoJ4uA5HBHy6C8rkTq3muiLynRYj/XIjx1GjCBg2pG/nf/TvtisnhsCl7UmpLbs80wFxXcIFkTRRSqDU3RCY9vOHHuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un72yokc; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un72yokc"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15168a20b47so2159626c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791921542; x=1792526342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5a8/8ouOTinlax5qi4nR9/ajAX4bZ40wHJinvy0inqU=;
        b=Un72yokctCXhldh31c6Q0bKvtPTNsSa3fKTgLxohlz8DrzaVC9J/vTt1tEvOFigip/
         0a/vtPIZwtxeFPBMqucJfjdgHMOOgfSXQJmCZWuQ1ep8RPu4QCN8HJpeo6J5aFDeh8ti
         zUdZesEmc4uEwEnJ5PGUjjd1uaFPe+9slsD1X3CX8iFrJPqaSJA5SPhiLh9tO69AyOnn
         6dipO24s25lXHpz0GL0/TyftJR6GnPH3RyQ8Q6XY+0v+rpqfEVosT5jr+ejRmh5NAl0H
         oCqIUjB4l8dPRG9fm1qqHH6IvCVJekn5uX0W0aBa2EZZRQeP64c121rW0BKaSQVrad8A
         ZyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921542; x=1792526342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5a8/8ouOTinlax5qi4nR9/ajAX4bZ40wHJinvy0inqU=;
        b=J6iMHtL7dmRxESgXrQgkwVyZplkuK2PdK2fhC13A9Cu9cAYqPtD4agXKoRAGMZiod8
         /X/ZqxXY5VjxZhRMX1wgb6uOiGnebWMM/LmqgzqOY4fwToYJyHHxV8wIMaRemBNKXV1u
         8q4Vc6a7Y4M6/Dt0MacBFz4FmWmpxe0lebn46z3upnzwD1umCyq55sW/qNK58/K1fKQk
         HwDgj9otjjYVf4TXLithCH0ipMmjcZ9UO9X0QfEHH8/+Yv0ytWcw4VmBOvwBFr6ENaSQ
         IikEVSkRHupGx9cEHiHZX1mR4APOB7PIKhZ4x7v2lViMMBf3JjqJDittYociMcRh7593
         gHZQ==
X-Gm-Message-State: AFq9FYJR+D7QzEIJU1qPWM6UEialHOK2sUbbd9tzdA3KaPgCAEh/BXVS
	7C54N0BohhjelWIEJci6jU9ylyhjPphBzqGSwHvNTBwr9hfpIow3jgX+Qzf0VQ==
X-Gm-Gg: AYBFou0RF/hdbLcBAoFiR4O/KIKjTHj35MkIrVZcTpe6NG9sKaY3hkuT+TDKqVMwsvm
	Fl7pXS4McFCva+8ogTDSddbXcGPJ4DrrnkjO5sAT1V+dAmC93MfvGwoXcNvlZPw5tOoaKG32cq8
	tWM+AiVeB1XdskOdnDpqlRLPxObxtvQ3p0+kxGnEHWDhctxq0Cy5/7eSKZSiSIiwtqh4bYum7KC
	x3OuOppQ4iTUcHkPZZtwlfvnpFN7rXWE+hRSKUxME3h9pHzI1aRx7W1R+v1wbkJnuSYZBrv2vNB
	i/Jnvg4SG7HTJETSNRDALb/VXbSeS7wRUQi7kRj/3RvU0zMVQzl/xdN7E7rlmAzbNTqtskmdlPw
	fdUOpH1NLLDMh1ZjYyBcOclCcS8UE48rU2YJpWW5Fsz9nQm8ZcOOAt3nBchgxFMAJC6WyK6rzmq
	AwgqSph2yy6ga6mPLj2dbpwXvY0Z1RvlvwRGO2ZlA3HwKaGIZwN5ZMX2xMmps4pbp+ncRePPTFQ
	dJe
X-Received: by 2002:a05:693c:87c8:20b0:358:90dd:78d with SMTP id 5a478bee46e88-35890dd07bemr15044293eec.19.1791921541343;
        Tue, 13 Oct 2026 12:59:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.74.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b690af3easm16283665eec.1.2026.10.13.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:59:00 -0700 (PDT)
Message-ID: <6ace8d84.48d70a69.2ba107.46ff@mx.google.com>
Date: Tue, 13 Oct 2026 12:59:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7430712565993984970=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] monitor: Add Minimum Supported Connection Interval
In-Reply-To: <20261013140255.521668-1-luiz.dentz@gmail.com>
References: <20261013140255.521668-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7430712565993984970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184798/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      17.62 seconds
BluezMake                     PASS      268.99 seconds
MakeCheck                     PASS      0.72 seconds
MakeDistcheck                 PASS      130.25 seconds
CheckValgrind                 PASS      139.02 seconds
CheckSmatch                   WARNING   246.86 seconds
bluezmakeextell               PASS      88.57 seconds
TestFunctional                FAIL      2927.26 seconds
IncrementalBuild              PASS      274.19 seconds
ScanBuild                     PASS      1006.83 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structuresemulator/btdev.c:479:29: warning: Variable length array is used.
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
FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts14-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts14-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts14-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts14-vm1]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_btmgmt::test_btmgmt_info[hosts17-vm1]: AssertionError: assert 'addr 00:AA:01:00:00:42' in '\x1b[0;91mReading hci0 info failed with status 0x11 (Invalid Index)\n\x1b[0m'
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
FAIL functional.test_bearer::test_bearer_le_connect[hosts11-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_connectable[hosts11-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_pair[hosts11-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_bredr_pair[hosts12-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bearer::test_bearer_le_not_connectable[hosts13-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts16-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_hog::test_hog[no-sci-hosts18-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
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
FAIL functional.test_obex::test_obex_ftp_list[hosts22-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_obex::test_obex_ftp_get[hosts22-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_obex::test_obexctl_list[hosts22-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
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
FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts6-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts8-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts10-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_created[hosts7-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_broadcast_earbuds_transport_acquire[hosts7-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-sc]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 238, in wait_load
            raise RuntimeError("load failed")
        RuntimeError: load failed"
FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts9-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
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


https://github.com/bluez/bluez/pull/2672

---
Regards,
Linux Bluetooth


--===============7430712565993984970==--
