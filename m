Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449380;
	b=0QDCSL7wj/2f8nV2Xw2KBhFnInapB/X6CjOojkb54bn5f38ox0Ouf9i2/hP+y2/OTn4s
	 BZBnwjEQtIKKjwDErylb70NY3htShk7mHHDPjFm08j/UPiAnl533RH5Nw0HLL6D7GacRP
	 XwWO3yMA53kWzE5YHOxvREf841lfidqjPQ/jAmCokoJIiRcxr2Ku3tlanJaDTjw5NgJeP
	 EeRW2dh1bFtFVK5lR06i4emBguisL++0nsoVxsfHr9kB5gBlEkKMVPU2WJ7A8LR+9T/5y
	 ZHcujpjSBpJm3IVgULquLmGjJVKXxJqcrJOYnG/ksgy0ySiyEG+GN60SCUaiwTRDpXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=9DrZPP4zxni28eX2UOvAD/2kwBmXYTTGTkKziZRwTA8=;
	b=UWxbiy/zkflus7WgPNBekyL5nEhVE5kqHjP4Uf6KE1mcwsfIq+Apw45V+Jh9I2huBSat
	 h7/wuGWSs//zkSGYHOJwGPdEPMuZEtda+YwGGEsO/78aphNbEsHOmaEcX6AXS7DTlXkHF
	 Ylx83Ii4R8DhoNXZtxQL9KDPlPaHI8lifAskjWkiOJsV4bsCxfk2hsxWVmnOzEnSQd9VE
	 iH0HbGzGXd6v6xvbciCnTE440zT9ZQIuKUoxBKUGf8idtLw9p7ZYxTYyOWQ0daZ8ogZQC
	 Oh4ppQ593I+jX+L6kO4m0updsAZbu3MKNifzAF0japUeCOvLlm2nXTa1JuaonYM/HRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrnDDdlD;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB2606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mrnDDdlD
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-833e671ee9fso3633558a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794449378; x=1795054178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9DrZPP4zxni28eX2UOvAD/2kwBmXYTTGTkKziZRwTA8=;
        b=mrnDDdlDpC9fJcPBaM91rRUlhCwzCOkoRYdIISupk4hXxQPuXGEUufmPkqvo32P6yv
         fYjEuMH6BBzPjmFj/iZiopxfhWm0rUFfuk5p4tu0kaNSr1VNFPAZN8OtuHGdKygIAIgX
         7BjFVWXQKHzumCk6DoaSu9Oa5yH/L6dytMuN9dMR4u72tCmTEVpMOTnyye3lNRvV48B9
         pTRjoR5dPvxZG1gPtc/90tvYDMnDOgasSdeSipC1CQrNOM7HVvB7xvSE8IuSg6n95oHu
         duw7yTMBUsk/TMfoRbpSpQaLkCyrYNW4FgKsfDUS6JXRCsgKXzYDBp+EmLnAPXBNQmgk
         X6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794449378; x=1795054178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9DrZPP4zxni28eX2UOvAD/2kwBmXYTTGTkKziZRwTA8=;
        b=FBYfmYeYq2Ydkrwg0/a8KxzRMEr/u44kN+mCDX5Jw444WM5HqLovLVuI8IymlaMhi0
         C/CfP43dfbYpdMVwLoaOP+iLAaXjuQLAXw0w2nbQKe4seFP9FKtZUQyLhgJAzxaaAL+/
         BnELaXIJ+044+0iwGRPI1SvLyVa0H7ZTDfBIfr+O27LmBbLJR6Kw8ikPnLMVlMVcNhOD
         PVOm2JUWHvJksz0gelhOflwwhElhbobNFH5Q4S8mI1QDMYL1ZttvJvQ8mhChzVnlMwbl
         14WXQ4cTYduqLOMeoN6G6Dy/91eqb6fXriphfqA9CQ7+n/FvhPnj3jB6Ogsu301vObtx
         tQrA==
X-Gm-Message-State: APuU4Z/b+EYBRT2Vrbd9N43OiO6V43savMvUNPZP+eM2iOWZBTPIjriY
	/QapAREl5cLrSigIQd+RPqASN/uueD344UbJiMx3o7B1g01AKqVDsYuSktEU3A==
X-Gm-Gg: AYBFou0hLcT+N7LvbqrfyM7k2ljJRHj1xZxcQB+2EAcLiaRlgfhtjW8dcxw6+QB/B7v
	/Mzb4xUR2HIMiGZBkaGOaiBIxpRCwCFhbHm3OeTimmP3NCRgjOS0pwEVzJEjd8pqQ4yRhfkgrKf
	ZmuzZvlfjRPOulsw7P0fy+o7Puajtk8wraDijLQ03s1xIazpgHyPOLOImKTS5SJdh5IuD/L7zat
	T19D82rK78E3xCBx6osyY1oTfYw52R2oepFScFQo2zYGl9GBk/vSU9BmFzgH1/ZGWe1cm+OVk+e
	EGplqsy6VQueZh2N8S3L0XrgiUydFMMsUeSYUA57UZhz1Ww8UsVuv2T4Z2UE+BTujblQSmg8Avb
	XTP6pimBJA0aLGxdyyVSJWzhDPt8MPYz2vMur0LzShOzmSnfYjFTTAziZhdqXgqkNlfq7PSKrxz
	pAroP1NnSSsvHNcnbm6L44/qmBPRs1af2D6n6UILdRqMXy6USgmbI6b2gZYwXz7Q7Ca+EJY1nGP
	SKOCVwTsFA27/QuAUqzGtlSlTL+5rMq7UnM7TEHkHd7cKKIlxjUzmzLqWNTxeTI
X-Received: by 2002:a05:6830:3e04:b0:81f:8a6d:7b52 with SMTP id 46e09a7af769-860f291218amr4971818a34.24.1794449377187;
        Wed, 11 Nov 2026 18:09:37 -0800 (PST)
Received: from [172.17.0.2] ([20.118.245.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca41c80sm5868939a34.3.2026.11.11.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:09:36 -0800 (PST)
Message-ID: <6af51fe0.b906deeb.39d84e.2608@mx.google.com>
Date: Wed, 11 Nov 2026 18:09:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7025322183851003621=="
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
Subject: RE: shared: Use util_iov helpers in gatt-db, hog, asha and micp
In-Reply-To: <20261111203949.3874673-2-luiz.dentz@gmail.com>
References: <20261111203949.3874673-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7025322183851003621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208739/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.32 seconds
GitLint                       PASS      1.53 seconds
BuildEll                      PASS      18.69 seconds
BluezMake                     PASS      271.15 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      137.07 seconds
CheckValgrind                 PASS      147.70 seconds
CheckSmatch                   PASS      240.11 seconds
bluezmakeextell               PASS      90.71 seconds
TestFunctional                FAIL      3170.98 seconds
IncrementalBuild              PASS      304.68 seconds
ScanBuild                     PASS      927.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,4/5] shared/micp: Fix reading Mute State from an empty notification
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 5c788b73b8a5 ("src/shared/micp.c: To implement MICP profile MICS service")'
#129: 
Fixes: 5c788b73 ("src/shared/micp.c: To implement MICP profile MICS service")

/home/runner/work/bluez/bluez/src/patch/14973718.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14973718.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


https://github.com/bluez/bluez/pull/2809

---
Regards,
Linux Bluetooth


--===============7025322183851003621==--
