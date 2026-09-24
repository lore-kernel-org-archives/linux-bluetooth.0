Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD03DAABA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277363; cv=none; b=ssSqgbRWmMR7nZgn51YNkQDjqsgjVCNkpdVCaplx14srHnv9SfC4q8T+1e/UBopJjOmjGuS7ZeXz5G2qzDRpy5fbcgd0ZX5DYDb2KxYrK4/UBcmkyltULvyjkN6TWK+vLATTReilZK4MRqWwiX2My8zBULO98pglTWkHoi0u9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277363; c=relaxed/simple;
	bh=LLCXJmHmwMk8dX30YkQMzqjUzaKCvZELinpQVyMioSc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uKs3jXqiU2R9KfrPOzw6LPdzX/t7HjTXL9KoMDfkyA/UMhbsMwDm7SbmpbveVVuzEDbhYT5BI6bheGt9KNyIe6+1pEEojVAYxkNRmRsKZFfr7ojh6ngc9nMX16QxF2NgvP8p1GOogGFvpkYrE5Ne7R7nlPBHgODr3MpeHPynGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWNzq5T6; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWNzq5T6"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f1354074so31674a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790277361; x=1790882161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=283vZiv8clP2Nd/IDw1kXdBWxvH2UGhysOg75ohVQ2s=;
        b=EWNzq5T600ZAvomXx9Cg3pz72n0IxUKkie0dGLRRq1/z6Q5uQYMAKV/K9ic0+NuMLP
         S+OB9YrYv1IrpHiqOQFlorLZXSt6UkNkxS7fo7xXiMKpoSnc1HO34pbGCu4vUZ0EoEAh
         Yl2md07dxww/Sz72v9NaKEL8oHVuAqXeNWbhK49g99F2MRcL0AyrBwoADbkwGbaDnk3/
         qLYdrCuCIGf38DW1KC3YZycoxzXJLVbkz306t7LtMAdjcjeYnTKbPvaLF4NCYQWDsj1c
         Q3826V/N5CUVbKcgbu0viiuNha/z3EQ4zxbv8lrFArW+eBSbkLeHXs73vvjyBOTJ18vb
         uEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277361; x=1790882161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=283vZiv8clP2Nd/IDw1kXdBWxvH2UGhysOg75ohVQ2s=;
        b=Wo55kZsUCEANGOO6XQxQTA4LdmJ6L9TTn0CDLBFFSNB5kpYjk5CNJnLI0oBrPgTXm6
         JDM5bT82xd8W++08zHZpSA0/cNeiM4yYBL3VgDApHAGdVFrHPoCZAM9bZoL824Ynyk+f
         8u1Ec0hXlmWBtwzOqzZZtTIWkD+TqFfVHz/eaja36BZ2wXoCEJPtYFP+95l5cmNDbrf/
         Kzm2SX/92QwfPGR4wlKOWPimGLxjuulUunfJLBNFGOHw88Y2OBkVXUjVFZmazwO9FfcI
         ZTHuTxa3EWg+2FORFYJrMxY6/W/IBGoJxQ/VcWxj4h72RGVUIXI9kH3LVQPH0dI7nofW
         I2iA==
X-Gm-Message-State: AFuF++l6sGaP1SUln5CdOPlZ8iTBJEug2P0TP8RXgcr6Y7d4p6ilCZOC
	e6UKX5+xPlK6tcK7oKxPGpMp3Yzja3EiwlB6ORX+/Algrl5sKwhR761JXXkrgAJk
X-Gm-Gg: AYBFou1Ibmoj62rBuknFvGnMAoGbaTlZLAxHd9DJzdGAASB1rV9MXmhjDGET9hE/RoO
	OMZ5dwwEfZrRzOzvR6qI422RC/I1OVUt5rVvQ+CFAnpHgOx7kP2QQ8Fpy+GlaCx02QlQppMJdor
	mUMFKm9mTiIbLyf68gVUhAobN+pCa/IZ/8zfsCIr0La9HCrRTmADSIwv+dJpXRZgcdmi5k8ylMz
	djpW2QowKxCabPJ2fSp12vNB/tkgxm+3TQKBTCDLd6CYRnmbzcpPK72evmZgr4qR6MdEIT0aRDo
	VSyZfJJNIUiDIJVxpBuEwwou29RDuItf/j5PEC36dBA5tbyLEDGuqZVIMcnvVcl9cvksJuXPZAW
	TYkijHDOL5P+/N69F3Uwd4kNHcsTMfGTya68fer9gU4AcHRx5497FufCoaRVzDtgi2uwTT12qls
	3LBc7LwEsgYACBvmeisfuobfCxZUSojxP9/DWv0OHhpzTYJSxrB8RxCTab8yaBzmJ/RPJTjMTEE
	IVKwg8=
X-Received: by 2002:a05:6820:f005:b0:6b1:d0e9:7ece with SMTP id 006d021491bc7-6d43f4bb84amr2672892eaf.11.1790277360802;
        Thu, 24 Sep 2026 12:16:00 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.21.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d582b792dbsm567652eaf.11.2026.09.24.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:16:00 -0700 (PDT)
Message-ID: <6ab576f0.0c0d0188.361926.08e3@mx.google.com>
Date: Thu, 24 Sep 2026 12:16:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5327972270718963730=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add HID over GATT functional tests
In-Reply-To: <20260924154631.369299-2-luiz.dentz@gmail.com>
References: <20260924154631.369299-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5327972270718963730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173252/

---Test result---

Test Summary:
CheckPatch                    PASS      3.54 seconds
GitLint                       FAIL      2.94 seconds
BuildEll                      PASS      16.88 seconds
BluezMake                     PASS      230.92 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      105.89 seconds
CheckValgrind                 PASS      160.51 seconds
CheckSmatch                   PASS      166.27 seconds
bluezmakeextell               PASS      64.61 seconds
TestFunctional                FAIL      815.22 seconds
IncrementalBuild              PASS      266.83 seconds
ScanBuild                     PASS      657.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/9] shared/gatt-client: Fix calling destroy after unregistering notify

1: T1 Title exceeds max length (81>80): "[BlueZ,v3,1/9] shared/gatt-client: Fix calling destroy after unregistering notify"
[BlueZ,v3,2/9] attrib: Fix unregistering notifications registered with bt_gatt_client

1: T1 Title exceeds max length (85>80): "[BlueZ,v3,2/9] attrib: Fix unregistering notifications registered with bt_gatt_client"
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-legacy]: failed on setup with "pytest_bluezenv.rpc.RemoteError: [Errno 32] Broken pipe
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 447, in send
            return ctl.send(*a, **kw)
                   ~~~~~~~~^^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/popen_spawn.py", line 142, in send
            return self.proc.stdin.write(b)
                   ~~~~~~~~~~~~~~~~~~~~~^^^
        BrokenPipeError: [Errno 32] Broken pipe"
FAIL functional.test_bap::test_bap_unicast_set_transport_created[hosts9-vm3-legacy]: failed on teardown with "pytest_bluezenv.plugin.CoredumpWarning: Core dump: test-bluezenv-hosts9.2-bluetoothctl-1790276391-121.core
        /usr/bin/gdb: warning: Couldn't determine a path for the index cache directory.
        [New LWP 121]
        [Thread debugging using libthread_db enabled]
        Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
        Core was generated by `/home/runner/work/bluez/bluez/src/src/client/bluetoothctl -a auto:NoInputNoOutput --init-script /home/runner/work/bluez/bluez/src/src/test/../client/scripts/bap-sink-lc3-right.bt'.
        Program terminated with signal SIGABRT, Aborted.
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44

        warning: 44	./nptl/pthread_kill.c: No such file or directory

        Thread 1 (Thread 0x7f3293a9ed40 (LWP 121)):
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44
                tid = <optimized out>
                ret = 0
                pd = <optimized out>
                old_mask = {__val = {140726025679776}}
                ret = <optimized out>
        #1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
        No locals.
        #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:100
        No locals.
        #3  0x00007f32940ddb7e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
                ret = <optimized out>
        #4  0x00007f32940c08ec in __GI_abort () at ./stdlib/abort.c:77
                act = {__sigaction_handler = {sa_handler = 0x7ba292ee1520, sa_sigaction = 0x7ba292ee1520}, sa_mask = {__val = {139855210919203, 140726025679792, 139855209372592, 7791336406271877491, 139855210919072, 140726025679872, 139855220451473, 139855221501984, 139855201496144, 0, 139855210919072, 4294967295, 139855208120320, 140726025679920, 139855209043459, 139855210919072}}, sa_flags = -1829814976, sa_restorer = 0x7c5292ee01c0}
        #5  0x00007f329493efe2 in ?? () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #6  0x00007f329496a4c1 in _dbus_warn_check_failed () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #7  0x000055a79cecf02a in cancel_request (conn=<optimized out>, msg=0x7c3292ef3d40, user_data=<optimized out>) at client/agent.c:258
        No locals.
        #8  0x000055a79cf63ac1 in process_message (connection=0x7c5292ee01c0, message=0x7c3292ef3d40, method=0x55a79d0445e0 <auto_methods+320>, iface_user_data=<optimized out>) at gdbus/object.c:293
                reply = <optimized out>
        #9  0x00007f329494b0f4 in dbus_connection_dispatch () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #10 0x000055a79cf53728 in message_dispatch (data=0x7c5292ee01c0) at gdbus/mainloop.c:59
                conn = 0x7c5292ee01c0
        #11 0x00007f32949e2b9b in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #12 0x00007f32949e41d7 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #13 0x00007f32949e4577 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #14 0x000055a79cf96ec9 in mainloop_run () at src/shared/mainloop-glib.c:65
        No locals.
        #15 0x000055a79cf977fb in mainloop_run_with_signal (func=func@entry=0x55a79cf8e840 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:196
                data = 0x7b6292ee1810
                io = 0x7b7292ee1f90
                ret = <optimized out>
        #16 0x000055a79cf92a1c in bt_shell_run () at src/shared/shell.c:1476
                status = <optimized out>
                submenu = <optimized out>
        #17 0x000055a79ceb7935 in main (argc=<optimized out>, argv=<optimized out>) at client/main.c:4228
                client = 0x7c3292ee0440
                status = <optimized out>
                timeout = <optimized out>
                timeout_id = <optimized out>"


https://github.com/bluez/bluez/pull/2580

---
Regards,
Linux Bluetooth


--===============5327972270718963730==--
