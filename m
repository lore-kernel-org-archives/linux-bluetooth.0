Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213D4D9552
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351802; cv=none; b=YSk6gFmmWCGhGMoBdME/fICqfnfCIA9TgSfLFmXeLxLjYLKSoBSii4CnNOuY0spPAFSaQgtQrMOA54EaJkGkw3Ottg3o7VmEEJbtvcPTgRNBwssntVVJR3WDaV4vgzlaxJdqdSETv59BExezPY8ZB6t3hflaDFWhepZgigSYoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351802; c=relaxed/simple;
	bh=eRcLp7sH547j/xC7ABZaiJovJrrGYuRBDWO+VektvmA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rug1r83nlVRdMFKjaDjQYB3eGuipOcIOAUTRKPif4MC5Fk4mFUJFJ2H0Gu8+JZ70KxCm/ohKmVoj6IYyGeoHwIzX6py/pmLzrz3nDsAq3jechla5tFOCqc108iurDrisEZvsNCdqJ3o2xCdCaAp4QiiBPKW6FWzrrH/u2INgNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKv1IA8z; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKv1IA8z"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so884294fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351799; x=1790956599; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Snp0RlUksPjDlVo43fLborNIPViouCWOptuNU1CCov8=;
        b=UKv1IA8zkB9AnlFD2pbuXjlGpQb9wh1Cvq4qNT+OVdBGTE1lNkMyitH1VTVBKomyR7
         Qhw9yh9hBExcBTPdY/yGzKZv6y/BktdVLc5hvrZNA90xyGUs2izAhATpaKoROYCakYfk
         uz6Wp0rOQLQQIEC7HQ4MDlQ4LmZfuM/gbqnAwwg4H72IqCnhn2DFoLSmQpnwlVLV5fBv
         ivaIRLN2wKoo5F1ex+inpiC1l3nZDYbmAh5u0PaXw8a2cdxlGfiTzGkqwfBOxWiADQB4
         ZHk7ynH6Y4aFKqP+SIXvhr79GIYi/tJHftx352JFVlIsM0Aesb0tdtD8yAHvsR//GpZv
         UdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351799; x=1790956599;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Snp0RlUksPjDlVo43fLborNIPViouCWOptuNU1CCov8=;
        b=UYxAZN9x1EWjLjDr0aGqYmP8tfChHa5mYGjYPZVkAgLa6h1NYnWu2PnexV5JphtKeQ
         bITFfGBmH0sE2mtIbmaHI1OoRGLzwkdgN3cwlfZZza0tCgTi8koItST1Um/itWoQpj/P
         0rtjaihA9F3ZRfyKOlhxtzs+5wZcXi9CFWW80mjESAq/oAESrQfUZmogQaJfMHFsJ20a
         W6msh5OGnWQ5kHDWLeADrVhVkEIaFHM5syXKoHrUlhKWjpJQDRdhg9lbySx9ulVnwyLR
         +Dbw2cs/pdSu7oc6jFJwx7EAowTW/XGfNPJVnzxp4l7ZWeyu5/9qlGmgVBseZIJPgMGg
         M+jA==
X-Gm-Message-State: AFuF++kK2TLO3ij6rwxfekLDAiq0HPeN9kboa2M22cNcFjz9lwTp20Q1
	Eb7hWprinmlhYKQ7U9S6gdG+S0r1WKLgByArDxZLImlmC3o9PDGBu85HjJiUqZAq
X-Gm-Gg: AYBFou2HkCvCo+Mj6ZWju0avvDOFzqXsBeLvRH1zrv2PBnhPOrnfUmriXP15IuCBObl
	9Rs8J0lhPYaNmuGFA+ldYaj0BJmIcy4A0KZE5IqhthEk6OavH3u3ZDtkhmrDCvGedpVx32S3PL9
	gCSyhzuPGCpvSJmh3JGWByjcw9xIprs1UkXIurJpCoMeTHoVnsgVD4qY1OvbBAycENMCc9bjovQ
	Yq3ruJkYlO6LfHiqldrRxuSzg8GXqIcvD1iz+4miyMG5Xo6XiQoOplBAv/h/3mxvA5A+OV8wipR
	i1chcnhtZylvvWOKUx3Itg3VOit2F3Mhnz8jXasCkkKeF4NumvHoA4pqHc0xQM8lA+bHvGyNxyc
	7JDcUR1Wu8cKJceVe97o5Se/6u0w0+PDRxamqkfiSfb0W6PUxSXsz2grZQyQzMGEnStc/v+BvEx
	+xx5N77HVLE8ZKKGG9y2GuietaMpc7TfZQVpW9rMB+6eo6xw5Fl74yr9j28pAD3DaYcYaolIa8t
	TTSMQ==
X-Received: by 2002:a05:6870:21c4:b0:486:cf17:7f2 with SMTP id 586e51a60fabf-491e4e58b49mr6957333fac.4.1790351799076;
        Fri, 25 Sep 2026 08:56:39 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.190.67])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4933501183bsm2059874fac.5.2026.09.25.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:56:37 -0700 (PDT)
Message-ID: <6ab699b5.e782ec0c.3d5d7.37ed@mx.google.com>
Date: Fri, 25 Sep 2026 08:56:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5113942168171328791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add MICP PICS file
In-Reply-To: <20260925124838.3346980-1-frederic.danis@collabora.com>
References: <20260925124838.3346980-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5113942168171328791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173750/

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      19.85 seconds
BluezMake                     PASS      386.43 seconds
MakeCheck                     PASS      14.71 seconds
MakeDistcheck                 PASS      144.39 seconds
CheckValgrind                 PASS      236.06 seconds
CheckSmatch                   PASS      296.69 seconds
bluezmakeextell               PASS      95.73 seconds
TestFunctional                FAIL      1123.68 seconds
IncrementalBuild              PASS      378.99 seconds
ScanBuild                     PASS      1159.36 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts9-vm3]: failed on setup with "pytest_bluezenv.rpc.RemoteError: End Of File (EOF).
    <pexpect.popen_spawn.PopenSpawn object at 0x7f30661567b0>
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
        <pexpect.popen_spawn.PopenSpawn object at 0x7f30661567b0>
        searcher: searcher_re:
            0: re.compile(b'Device has been removed|Device 00:AA:01:00:00:42 not available')"
FAIL functional.test_bap::test_bap_unicast_set_transport_acquire[hosts9-vm3]: failed on teardown with "pytest_bluezenv.plugin.CoredumpWarning: Core dump: test-bluezenv-hosts9.2-bluetoothctl-1790350219-136.core
        /usr/bin/gdb: warning: Couldn't determine a path for the index cache directory.
        [New LWP 136]
        [Thread debugging using libthread_db enabled]
        Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
        Core was generated by `/home/runner/work/bluez/bluez/src/src/client/bluetoothctl -a auto:NoInputNoOutput --init-script /home/runner/work/bluez/bluez/src/src/test/../client/scripts/bap-sink-lc3-right.bt'.
        Program terminated with signal SIGABRT, Aborted.
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44

        warning: 44	./nptl/pthread_kill.c: No such file or directory

        Thread 1 (Thread 0x7f32dbe40d40 (LWP 136)):
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44
                tid = <optimized out>
                ret = 0
                pd = <optimized out>
                old_mask = {__val = {140723539280960}}
                ret = <optimized out>
        #1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
        No locals.
        #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:100
        No locals.
        #3  0x00007f32dc47fb7e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
                ret = <optimized out>
        #4  0x00007f32dc4628ec in __GI_abort () at ./stdlib/abort.c:77
                act = {__sigaction_handler = {sa_handler = 0x7ba2db2e1440, sa_sigaction = 0x7ba2db2e1440}, sa_mask = {__val = {139856422688035, 140723539280976, 139856421141424, 7791336406271877491, 139856422687904, 140723539281056, 139856432220305, 139856433270816, 139856412992456, 0, 139856422687904, 4294967295, 139856416079872, 140723539281104, 139856420812291, 139856422687904}}, sa_flags = -617661632, sa_restorer = 0x7c52db2e01c0}
        #5  0x00007f32dcce0fe2 in ?? () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #6  0x00007f32dcd0c4c1 in _dbus_warn_check_failed () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #7  0x0000555e84fdc00a in cancel_request (conn=<optimized out>, msg=0x7c32db2f3b40, user_data=<optimized out>) at client/agent.c:258
        No locals.
        #8  0x0000555e85070131 in process_message (connection=0x7c52db2e01c0, message=0x7c32db2f3b40, method=0x555e851515e0 <auto_methods+320>, iface_user_data=<optimized out>) at gdbus/object.c:293
                reply = <optimized out>
        #9  0x00007f32dcced0f4 in dbus_connection_dispatch () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
        No symbol table info available.
        #10 0x0000555e8505fd98 in message_dispatch (data=0x7c52db2e01c0) at gdbus/mainloop.c:59
                conn = 0x7c52db2e01c0
        #11 0x00007f32dcd84b9b in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #12 0x00007f32dcd861d7 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #13 0x00007f32dcd86577 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #14 0x0000555e850a3539 in mainloop_run () at src/shared/mainloop-glib.c:65
        No locals.
        #15 0x0000555e850a3e6b in mainloop_run_with_signal (func=func@entry=0x555e8509aeb0 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:196
                data = 0x7b62db2e1810
                io = 0x7b72db2e1f50
                ret = <optimized out>
        #16 0x0000555e8509f08c in bt_shell_run () at src/shared/shell.c:1476
                status = <optimized out>
                submenu = <optimized out>
        #17 0x0000555e84fc4915 in main (argc=<optimized out>, argv=<optimized out>) at client/main.c:4228
                client = 0x7c32db2e0440
                status = <optimized out>
                timeout = <optimized out>
                timeout_id = <optimized out>"


https://github.com/bluez/bluez/pull/2586

---
Regards,
Linux Bluetooth


--===============5113942168171328791==--
