Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449882;
	b=PrsotBnoP4NzrBezkyl5vqK7EfzSZzPMZ4bk63+PePChOkkoQISywCsm+G7Jj45JGh19
	 KNqnN7QKYZQB1xbSoeyIjgqLqP34MwUevOFObvfctmYmT3p5hEa5FKIEXb1sukiQWnanK
	 ayAi6JqMEN4peqZzaWm2ZZmUH3Kl39yy/W6le9/cv55XGM6BRGu3QL9BbQmEOxqiZ1oah
	 2bRgCHIJyMQ18OIogGMTFdOqJbBptmX4yc+KIXMZiOBHAR7jkN0g8Uz+Ih2jwUwPQzC+i
	 wQNg+UQOuCtvobuKZ54LiqmAxFP5z668jkeWKpUr+iOmEtGK60pzfSfN6yjuIBh9uvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bse8PIIi+rFOk1zXGGuakoNjS5L3UpQvlVHGCmAb5qs=;
	b=ENZmUQQ/8wnHo4whQCEuk5jkPl3OBr6AVJmuYl1fr3+9OuvzTXvmcm1dz/1rl6BNdm0r
	 Nt7gxIBuElfRtPdI8PyRYwuJaMPoyvJPsfLo0Oiko6a7Rhu0+jCpNWiyV1wNb59CxBnn0
	 ZcQiZDHYUyjBLeXAoMkB+0IKF/S+qQgOvl0GsasuXGEBRTobjErHlZDGcXPd8Xl4LEgZE
	 CvjFjAMExmqiVttLqXrOgS+L5oYFAWqAqFlYlRtj0kDq9dlzOaBx9F4m9rEm4TGJUWUTu
	 ORLpnKph3yQyEza7EqrOZlLg/tfx8+/SuJBOMfhFP7zRDNrJ54dOS4wW+/B4qc93CUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIAXkgzP;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A54606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A54606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIAXkgzP
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso1835105a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794449881; x=1795054681; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bse8PIIi+rFOk1zXGGuakoNjS5L3UpQvlVHGCmAb5qs=;
        b=OIAXkgzPqwvbXUG2FOdScgFhNLIm0aMULKPPvxd2qymjFYx8M5RaBAhiK/tS1n371s
         opFeuy5/3WNaPw4LJ3fYQtQzPwE45U+7Wl5/NU1kLP0gc9Icro5QxUlIHu/okL/IcYQF
         Ld2eSJyGdJ904F+xOJOOgL0qFBYzeFmNFXVj6GQSY7upAIFS/KTjqe7+ChUB3Bdy8hPs
         GaxKGa0P68cJWp2quUqO/0i/LY6XvFGd9szpXnpQlDCKE/gjCrdOERcc/6eQMuuO9YqM
         xC/NssbtE2wBmdUbr18+uLTNcFR/INjklgJ7BjqLkrQB2X51zOOyUCF1IwbpZW9oSmBB
         ZXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794449881; x=1795054681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bse8PIIi+rFOk1zXGGuakoNjS5L3UpQvlVHGCmAb5qs=;
        b=F5Bvn2LTL0mZRAu3HITWXcAZifwI1JAYw8o/zDNL/B+VppbEaU9VSHvuJliltMPNfK
         7XGI/kfyRWEs6U1RLxGMi+YCdOYjLQnpScytyBjZTwZ7Rhm6jb1sr9xP6XnH8MV8w9cq
         1RUiGsbxnfYN7w6qlI8Qw4iZUHKV+Wt638f/YcAoiFG1CHl886eQ7lxNcshxikzpsz/2
         nBWT3zk+ZnH19RPb40zT8AhHj8XL57oafoZFaWfZckHhfhq/HX1AkFz3bh085yfxLl3J
         tysa0G9t+CCw2N9XmaEwXOYoLAJ63InqICBtApZ4Db8FxZJo7WK3tg3r0b3AJr+ygsZc
         uCxw==
X-Gm-Message-State: APuU4Z/7FwbmDX8CBb1bWTm4xfQ3XpzGNxPYn2FkC/2444q3vezCUi3D
	+h/w959eyrWf7+tXGGcXM+scErBHbG9LTUSzaO+7uM1yB/PsxdcYVK7YdmdMWg==
X-Gm-Gg: AYBFou2scfa0tc4XZ2GWJYPCk4I6GIi9Cd2BpDSAuhkPMCldFPcjs2CxAwleC/v9afU
	VO4El+AHruxcdLcna3KFUqmdQNQ0uszZddLECMv4lmvGQTpYvjq6zAf28ZMQ4pFJnsRhKhoNbSl
	Ek0slTlk183wxTjsISS2oXt82lrQI1lW9sPFR1m8q7Mcxq+eR6q99tBr98A4NHIVvhIukbYC5If
	nRgFmUTtRnz1BFMJJidcn8YR+3kn1MgulrgkFjxRZX6y4GvHOkP1HXzVNZadrubf4wjRGu1A+C4
	ifEgkTYToNod5RvRkbONcl4BhAVdsdshHp6m8X4IYYTiYzuOsmw+GRKZ0Bqcp8Yihygy82qpUiZ
	fFz3Trf/9bm7z8a7cIs/zHcqaexZigH0OTxfhOpqvPuA4FhHNRVZ83+bFPYhc1ji2HG76kqhak3
	HGWABiFkPJBKQo4mZeK2B8zNe7/Qdp3uAL1+qox0rEoedv3BsvX/dcROjip4OXvcMX5wEf196MQ
	mkgk0iE25NjGp6ha7r8+MoUsMdcPGz6xUrttJE+MMeSQwYxUsB/NmLDXA+w
X-Received: by 2002:a17:90b:574e:b0:3ac:8897:7ba4 with SMTP id 98e67ed59e1d1-3b182e10907mr3773526a91.5.1794449880751;
        Wed, 11 Nov 2026 18:18:00 -0800 (PST)
Received: from [172.17.0.2] ([4.155.14.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm1841187a91.5.2026.11.11.18.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:18:00 -0800 (PST)
Message-ID: <6af521d8.488c8742.26003.3592@mx.google.com>
Date: Wed, 11 Nov 2026 18:18:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9015138477033382897=="
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
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261111200705.3802779-2-luiz.dentz@gmail.com>
References: <20261111200705.3802779-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9015138477033382897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208698/

---Test result---

Test Summary:
CheckPatch                    FAIL      7.93 seconds
GitLint                       PASS      2.40 seconds
BuildEll                      PASS      18.26 seconds
BluezMake                     PASS      273.68 seconds
MakeCheck                     PASS      13.89 seconds
MakeDistcheck                 PASS      139.39 seconds
CheckValgrind                 PASS      329.80 seconds
CheckSmatch                   WARNING   246.89 seconds
bluezmakeextell               PASS      90.03 seconds
TestFunctional                FAIL      3189.72 seconds
IncrementalBuild              PASS      706.34 seconds
ScanBuild                     PASS      935.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v10,01/11] monitor: Use __packed in bt.h and its users
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#229: FILE: monitor/bt.h:16:
+#define __packed __attribute__((packed))

/home/runner/work/bluez/bluez/src/patch/14973568.patch total: 0 errors, 1 warnings, 4719 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14973568.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v10,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#417: FILE: tools/iso-tester.c:958:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

/home/runner/work/bluez/bluez/src/patch/14973576.patch total: 0 errors, 3 warnings, 3090 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14973576.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):
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


https://github.com/bluez/bluez/pull/2801

---
Regards,
Linux Bluetooth


--===============9015138477033382897==--
