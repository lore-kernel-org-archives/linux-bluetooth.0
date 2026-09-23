Received: from mail-oa2-f22.google.com (mail-oa2-f22.google.com [74.125.231.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3B3ACA64
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161496; cv=none; b=VnIeNccs8ATKEiuww2SeSWHUNQ/yN5cBpUU+cXJMBgQzMIRKvhkym1/xfkn+9RVR6ham0Avs5A9wcvde1lc0SO3gqoc3iIQIYhKFxewEJusnFKHzn83qPKmrIFt0+3d1ZezY2iGMBKkQ47CeAr5e06HA4uircOZvPMjfdjRG18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161496; c=relaxed/simple;
	bh=5eaBsaOTdhJ15+1WFgjmNdeMAIpVuJxMq4MsdktNOds=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o0Pgdm5N5dnFvreoM0LPRK4IIUXqRmH6Up2wlUpHOjGI8BGJPSd8kKRINX2Wjzd3h6IliVSJKwzzlxksQcvTtuZtMvsQxPGcemsMr9VJuDgeZETAXiTf/21vLNnU/xPqgy78v78xwMluxIHWemhond3IuUIU6NkCc77XvQk9jMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwNa7S6E; arc=none smtp.client-ip=74.125.231.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwNa7S6E"
Received: by mail-oa2-f22.google.com with SMTP id 586e51a60fabf-48e46240b38so523849fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161488; x=1790766288; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dVe/YuZmPR1eElbCrL39wX+A2bOAnwO1I6QJ6MPw0/o=;
        b=SwNa7S6EaI4SoFP/GNO9eF/a1D3nlb9qX4pXkOJx1pwzybisaVHY05+gDTi5Q11xmm
         iPSJGFLRX4A3uLWjPUrBYAknxy/Kg/SuDL1GlaDbnXFLpTLBb3vfsaz2J+pJxZlskybA
         YAPV9hdiseo95RHUZrjqC0cYbixTSD6MtUhtdvvDKL2cFhrNUP9o8O2msXtQjEXXvT3D
         7TqXZUF71sJ7GNwgw1DzS5uROupXKcTOXPGrQ4PfKgB1h7uOil07kBrbQxeINjNMUCWt
         auWwT178ydSsdRshgFPWnnh6xvYFIuc4j5LxZ5vwJlRbPjia9CE9g/Z7A58+wruv9onV
         urIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161488; x=1790766288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dVe/YuZmPR1eElbCrL39wX+A2bOAnwO1I6QJ6MPw0/o=;
        b=O87VSSi6angctisIfMxrz0KBlia5eSmDARe/X8O3fIeforEZ0uk3rWoRRfoMHXJKYm
         0RtdjQddZnoyLy9QVbq8lyx3pJGBV1uL6tQ2wh+YO6ntmtUQGZneteYChe//Z/lWNTfp
         tvvx5qzEepvJwK1pD74CjLv8+/mbVsq1NBf+FzqWVMi6GPW00B0Myx93iYTU8/gN/AIN
         OmbhR69oKotyDHGRS48EsdwZsSsiRfg1i3pqUDETZLhFgwhCTi+UjqK06CbQz+Eh1jkv
         9rYs2PkOt4rUOA+dQQRt3POjSHW9o6tqpM7dIC4Fkg9NKS++Om0Wyb4QUavbH3YAZDyQ
         uW0Q==
X-Gm-Message-State: AFuF++n7PDwIkji/Ah8cjxNE0SdYVvU5u94oOeQcsrPpcjpxLuARn8uj
	HxAqXmqArxhBB1hhCrP/nrV5CUFbjzvEeVWHnnja0f2UmWT7mVLluwpsZjjPhbnd
X-Gm-Gg: AYBFou0YkTjlDTK0iIs4S44B5EW4gQhZ+5Ia2iEJm6F+WPklxbjOq0z8z0IkY/8oDHY
	Zh+ZAnHSfXF52/9PxMK0ZGMhr0Dx3CdhZVwka2e3Mng/ZddAY/9ywb2JtIKp+Z4UOvBDv2fVdbI
	U+ewzAx74KtyVPU9IjZivfeShLL1w4juc26s5srcYdgpnr6b2lqsfC6SqPYuiO7DEQMAZDtC+Fd
	sFAMME9cETwEr0fBnQh6Uqe8vtpioU7yw1xtzZObgUrxlGw1ZVolecQ1Ie+CeiEvKyVu0cxPNeN
	hRJ1mAMsJ1yNLTvnD+xEFbZP+8dw03+UCavKdf6uaTJJYkf3A2eVHwMc5GevQJxP5wIb48tV/i3
	w1EUW4cfbyu0jv/bQ4DBIpO4sQkAbdQB0Xh6zmpeUP7zOSJj1ubPQNC/6ygFSoVyvvNXtYjjzTa
	HcbWGrx/c1tuM7z9riAcJoxfGzJy18wiZUTvjrMIbz0MvpnS8W0dNmZFJU5jlZ9pMll0lJH3te2
	NesZ6JLdi1eHGjs
X-Received: by 2002:a05:6870:d202:b0:48f:e21d:f753 with SMTP id 586e51a60fabf-4908b5fb2a5mr1945705fac.60.1790161488224;
        Wed, 23 Sep 2026 04:04:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.254.226])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4908e11e7acsm1562391fac.5.2026.09.23.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:04:47 -0700 (PDT)
Message-ID: <6ab3b24f.e782ec0c.249bf4.3d5c@mx.google.com>
Date: Wed, 23 Sep 2026 04:04:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2252320409481295464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
In-Reply-To: <20260923080003.317019-1-frederic.danis@collabora.com>
References: <20260923080003.317019-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2252320409481295464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172004/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      1.17 seconds
BuildEll                      PASS      19.48 seconds
BluezMake                     PASS      386.90 seconds
MakeCheck                     PASS      2.67 seconds
MakeDistcheck                 PASS      138.47 seconds
CheckValgrind                 PASS      149.37 seconds
CheckSmatch                   PASS      287.84 seconds
bluezmakeextell               PASS      93.00 seconds
TestFunctional                FAIL      1132.21 seconds
IncrementalBuild              PASS      383.61 seconds
ScanBuild                     PASS      1124.56 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: End Of File (EOF).
    <pexpect.popen_spawn.PopenSpawn object at 0x7f0ab7b1e7b0>
    searcher: searcher_re:
        0: re.compile(b'Device has been removed|Device 00:AA:01:00:00:42 not available')
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 441, in expect
            ret = ctl.expect(*a, **kw)
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
            return self.expect_list(compiled_pattern_list,
                   ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
                    timeout, searchwindowsize, async_)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
            return exp.expect_loop(timeout)
                   ~~~~~~~~~~~~~~~^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 179, in expect_loop
            return self.eof(e)
                   ~~~~~~~~^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 122, in eof
            raise exc
        pexpect.exceptions.EOF: End Of File (EOF).
        <pexpect.popen_spawn.PopenSpawn object at 0x7f0ab7b1e7b0>
        searcher: searcher_re:
            0: re.compile(b'Device has been removed|Device 00:AA:01:00:00:42 not available')"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-legacy]: failed on teardown with "pytest_bluezenv.plugin.CoredumpWarning: Core dump: test-bluezenv-hosts9.2-bluetoothctl-1790159931-120.core
        /usr/bin/gdb: warning: Couldn't determine a path for the index cache directory.
        [New LWP 120]
        [Thread debugging using libthread_db enabled]
        Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
        Core was generated by `/home/runner/work/bluez/bluez/src/src/client/bluetoothctl -a auto:NoInputNoOutput --init-script /home/runner/work/bluez/bluez/src/src/test/../client/scripts/bap-sink-lc3-right.bt'.
        Program terminated with signal SIGABRT, Aborted.
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44

        warning: 44	./nptl/pthread_kill.c: No such file or directory

        Thread 1 (Thread 0x7fba8f957d40 (LWP 120)):
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44
                tid = <optimized out>
                ret = 0
                pd = <optimized out>
                old_mask = {__val = {140730558660480}}
                ret = <optimized out>
        #1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
        No locals.
        #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:100
        No locals.
        #3  0x00007fba8ff96b7e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
                ret = <optimized out>
        #4  0x00007fba8ff798ec in __GI_abort () at ./stdlib/abort.c:77
                act = {__sigaction_handler = {sa_handler = 0x7c2a8ede1440, sa_sigaction = 0x7c2a8ede1440}, sa_mask = {__val = {140439258023203, 140730558660496, 140439256476592, 7791336406271877491, 140439258023072, 140730558660576, 140439267555473, 140439268605984, 140439246334784, 0, 140439258023072, 4294967295, 140439239786496, 140730558660624, 140439256147459, 140439258023072}}, sa_flags = -1897983936, sa_restorer = 0x7cda8ede01c0}
        #5  0x00007fba907f7fe2 in ?? () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #6  0x00007fba908234c1 in _dbus_warn_check_failed () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #7  0x000055a7c4f7200a in cancel_request (conn=<optimized out>, msg=0x7cba8edf1040, user_data=<optimized out>) at client/agent.c:258
        No locals.
        #8  0x000055a7c5006131 in process_message (connection=0x7cda8ede01c0, message=0x7cba8edf1040, method=0x55a7c50e75e0 <auto_methods+320>, iface_user_data=<optimized out>) at gdbus/object.c:293
                reply = <optimized out>
        #9  0x00007fba908040f4 in dbus_connection_dispatch () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #10 0x000055a7c4ff5d98 in message_dispatch (data=0x7cda8ede01c0) at gdbus/mainloop.c:59
                conn = 0x7cda8ede01c0
        #11 0x00007fba9089bb9b in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #12 0x00007fba9089d1d7 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #13 0x00007fba9089d577 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #14 0x000055a7c5039539 in mainloop_run () at src/shared/mainloop-glib.c:65
        No locals.
        #15 0x000055a7c5039e6b in mainloop_run_with_signal (func=func@entry=0x55a7c5030eb0 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:196
                data = 0x7bea8ede1810
                io = 0x7bfa8ede1f50
                ret = <optimized out>
        #16 0x000055a7c503508c in bt_shell_run () at src/shared/shell.c:1476
                status = <optimized out>
                submenu = <optimized out>
        #17 0x000055a7c4f5a915 in main (argc=<optimized out>, argv=<optimized out>) at client/main.c:4228
                client = 0x7cba8ede0440
                status = <optimized out>
                timeout = <optimized out>
                timeout_id = <optimized out>"


https://github.com/bluez/bluez/pull/2570

---
Regards,
Linux Bluetooth


--===============2252320409481295464==--
