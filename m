Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370995;
	b=k+qxueeVRr7U2BY+I4QxpW0n8QgEnlCcXPIHTfE117JMbnxSuIRkOpzbebsdjGsLgDRY
	 JJW/t4bCH+ERyuH+pabYbqJSZe9rSknTt1xjs6pyTWvVYu00RDH6Ax7/VsFiLJjI+IkH0
	 iPcj91iPi79XlGsLX/MTTwRuB+YXvypRRTgbQM6TJqefUNCMqfVM3r59bNX7cOUmVwIBm
	 O6p1K62w4wdYN9PpZo+yFphHgmFYt4bi8zAPv0kqEcyQv6F0t5Oco4Dj3rRdyR24Si0fo
	 gJmkdvMd3/oc8tHvkYSI3lOTjZYA4LtpbxDSUjUGnJ4jaSHFzbt1Dx07Wef8FcoFSsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uAzcA5OV7bBjnkxLfehdBltWqPAwnsqmv4Leo4qRmvM=;
	b=4dM7XGVi8bRtwzweLssmkT1szMcPGw1ydvyP+AFEKGHppausuqUeUhXOqPGbDrmFuP/C
	 OY8GdeoJ1QU7fmRsLIm1hgHkjygrelLRHJnI2WfTPdnOSx9rHXMZmwz1ciDzvZE2OuDYp
	 spMTZMLHuFSxBW2/rG81Of1eSYhzhBMBgLzrhU+gfLy/PzxMzzOz4NtpmBBBzytNSqP8F
	 VcE9m+keOHy7DYpVkBW+5OOdBbgalHi1uwNI4I82EmbzcnEefV0NKJ9aDOwLmBkUCqV1K
	 JzoA3eCI+D870+o3mXoOFUOHgpUT/tBZ2gdhVhMKcY/olI53RtSm5QY78QbIsRGoGgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UCo9AsaA;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EA606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 04:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UCo9AsaA
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso1242514fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370992; x=1794975792; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uAzcA5OV7bBjnkxLfehdBltWqPAwnsqmv4Leo4qRmvM=;
        b=UCo9AsaAFdCzTHdbS04+PrGapjfvCbOjkxthnfvvsNQVuXFdLyOHqY67zXUNrx7mlm
         f+unOCdHw91NFb0+25PtYRbclPDIfrYdXru+bc9g/2IwZTiz7ujSMDDApJGcm5LKuNl9
         2Cki7R3dpV0SuB+jcInHIxwBzciUkvtAinjByJUOUFwwjc49RXYeY0AZ+PWg9FKqRUql
         UAJAYV3yUtA+DyMp3JgE6Ip91h0piwxkuoGSxdzV7l5ylxkbtSLXYgHv0UyJFhXHs/9O
         G4absMJraSUYo0S+SbeB9oC4Uk7Hy5LxSjJ4L6d7j+gGL9EeHNCNqCgLoRLU5gIyN4Lu
         S9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370992; x=1794975792;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uAzcA5OV7bBjnkxLfehdBltWqPAwnsqmv4Leo4qRmvM=;
        b=I0mdsnZl6D0QbAaCkYOfo6QMmFkd5mQ+1vhAgoipJql1dqy6ax9fmr6sxKQzXtEXUl
         4JomsvgxgrhEFOWtN+JcpV/QBwVajhBtIXu9fYGNfmXsrbDy5PEDcYbWusaTrewTSgI5
         HIiHR2cIP5WfiZCqvtMONLx7UtEvra0GNZoNUAh7M9Dgopb44ATJoVmDQmZgiAKM/+qQ
         8YKRIma/3FrsTh8ixkvsO5oY3kzKHAE6qHLHbEOgK6JDOL99BsiWkR9QsG3/9GJ2KOmP
         r+bsfpMqKGIU+DoHEaIsSYdStBaenmUbbju+v2PQ90iQoD49dr/eG7BWbrRzsH4Q+SyA
         SWqw==
X-Gm-Message-State: APuU4Z8ZaeubAeYK9IWkRNIZ89YSNaqzMH6HvRfJhA86uuOyrjAE8Ag7
	uIdm5uD4mW1GQ4eADrYvY1rzn3mqH+XfDnd5c7YzlbK/4gY5SN8WWMzL4o0cvA==
X-Gm-Gg: AYBFou2KV2ltjib1fEiNGX1+OmNNexZCeY5OlJATT9O5aVpRgZ4R27EOE489Zb9D8Tr
	V/7NlT3yn80rYfFsFuQfbOoToXeFHYb0IkKHrvML7IlgBEb1yVzrGZnxwEyCYlnP0xOOfUGjZGt
	7oyZVHjUtIN976f/gAKzxrlxoA/mNHPv3u5V9PIRyhTYnOoP/GdT9gG2sSq3g3hqIMRNPKFYOkG
	b/Vt1Fq5BitKELVjTkWQRAiAC0RbVqZCAGI07KRwJjOe/HIbLF1InPZn7rZeJnlDEQGF/tSKr8j
	bvyL6AoP39o0810ajtLc88N1s6fMpaKmCsrxCwRi0GQ6Lp45mBbDAZOYDP35ck/Swzl0xrjNe2V
	ctykr6KrTlg5IETk31n/7PHSgYNbGHqIIknpDbeWmPzfb4HI4GAYRl/+jpbb8SFijXs5i8wlF0g
	Wq12yL4+iXwzmiBiAVehPfvDI2NC2VgATkDpDL5SgW6Hx/+1pLgFCnYRg4macU1VFccmFbqoJyV
	/kjKXWLnHzINU5L1PpalTbVibhJyCSfvjC7IQEPKpZjtShpjbABaNUzLLAn5g==
X-Received: by 2002:a05:6871:b28:b0:4a7:6dc:af65 with SMTP id 586e51a60fabf-4ae46afffcbmr1316047fac.10.1794370991855;
        Tue, 10 Nov 2026 20:23:11 -0800 (PST)
Received: from [172.17.0.2] ([20.80.111.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae2308e3ccsm2716114fac.15.2026.11.10.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:23:08 -0800 (PST)
Message-ID: <6af3edac.73f9ae50.5aeb4.4294@mx.google.com>
Date: Tue, 10 Nov 2026 20:23:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2882606067044326200=="
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
Subject: RE: [BlueZ,v1,1/8] transport: Hand the owner over to a link still streaming
In-Reply-To: <3b2039804cdb286aab8d19e6e2e74e6d641f4d9c.1794349049.git.luiz.von.dentz@intel.com>
References: <3b2039804cdb286aab8d19e6e2e74e6d641f4d9c.1794349049.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2882606067044326200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207688/

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      13.11 seconds
BluezMake                     PASS      169.41 seconds
MakeCheck                     PASS      3.08 seconds
MakeDistcheck                 PASS      95.40 seconds
CheckValgrind                 PASS      97.29 seconds
CheckSmatch                   PASS      169.43 seconds
bluezmakeextell               PASS      60.03 seconds
TestFunctional                FAIL      2927.99 seconds
IncrementalBuild              PASS      172.30 seconds
ScanBuild                     PASS      578.06 seconds

Details
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


https://github.com/bluez/bluez/pull/2791

---
Regards,
Linux Bluetooth


--===============2882606067044326200==--
