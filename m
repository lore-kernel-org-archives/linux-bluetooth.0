Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiAGRxS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 12:53:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36560 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAGRxR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 12:53:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEFDEB8269A
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 17:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C5E5C36AEB
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641577995;
        bh=AvsjlA8FPlQRvSJaBS3pTRxxV3akc3cnDeHUYPgskvc=;
        h=From:To:Subject:Date:From;
        b=TYvutun7PXBwm5EXbK7asZtq11L7QBattWMegLrHZV3M8EAZVngroQkrSNojz9Dvb
         b1JwQIRNNVbGX9NtKsJ4a35pGTnKQdx/gVWdOe2icGhpHpFEzpMXtoKZAoM+i79dFo
         yN8kiInQGz34DaoGT5AoYdYuideSz0htDVHUDFPYT1E7jsSP+HORNw5MF86wH1Yeyp
         ciYWkatxQGuhpm3TxGUFtMFN7vPp4PjSYBwmPNiSI/wgNfmoGmX3LoFiJMt/kjoAUJ
         5tezfBHydk85Iy00acsAA7oD742m3++TfLCPmk/eMzjrQHzIs1AJuTzOxhUnXFXxCo
         UzbWvviMj1FHg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7C907C05FF0; Fri,  7 Jan 2022 17:53:15 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215462] New: bluetoothd segfaults in libdbus-1.so.3.19.13
Date:   Fri, 07 Jan 2022 17:53:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215462-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215462

            Bug ID: 215462
           Summary: bluetoothd segfaults in libdbus-1.so.3.19.13
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

Using Debian sid/unstable with Linux 5.16-rc8 from the suite *experimental*,
*bluez* 5.62-2 and *libdbus-1-3* 1.12.20-3, connecting to a Google Nest over
Bluetooth, bluetoothd crashed with a segmentation fault:

    [ 7793.540822] bluetoothd[7937]: segfault at 3 ip 00007f73196e3d28 sp
00007fffbd269280 error 4 in libdbus-1.so.3.19.13[7f73196be000+2f000]
    [ 7793.540835] Code: 08 4c 89 e9 44 89 e2 53 41 b9 6c 00 00 00 41 89 c0=
 48
89 ee bf 01 00 00 00 e8 e4 f9 ff ff 5a 59 e9 9f fe ff ff 0f 1f 44 00 00 <0f=
> b6
16 44 89 e6 e8 fd be fd ff 85 c0 0f 84 87 fe ff ff b8 01 00

```
(gdb) bt
#0  _dbus_marshal_write_basic (str=3D0x55992b2dc560, insert_at=3D213,
type=3Dtype@entry=3D121, value=3Dvalue@entry=3D0x3, byte_order=3D108,
pos_after=3Dpos_after@entry=3D0x7fffbd2693e0) at
../../../dbus/dbus-marshal-basic.c:814
#1  0x00007f73196cef9b in _dbus_type_writer_write_basic_no_typecode (value=
=3D0x3,
type=3D121, writer=3D0x7fffbd2693c0) at ../../../dbus/dbus-marshal-recursiv=
e.c:1605
#2  _dbus_type_writer_write_basic_no_typecode (value=3D0x3, type=3D121,
writer=3D0x7fffbd2693c0) at ../../../dbus/dbus-marshal-recursive.c:1600
#3  _dbus_type_writer_write_basic (writer=3Dwriter@entry=3D0x7fffbd2693c0,
type=3Dtype@entry=3D121, value=3Dvalue@entry=3D0x3) at
../../../dbus/dbus-marshal-recursive.c:2327
#4  0x00007f73196d36b8 in dbus_message_iter_append_basic
(iter=3Diter@entry=3D0x7fffbd2693b0, type=3Dtype@entry=3D121, value=3D0x3) =
at
../../../dbus/dbus-message.c:2843
#5  0x0000559929aba78e in get_codec (property=3D<optimized out>,
iter=3D0x7fffbd2693b0, data=3D<optimized out>) at profiles/audio/a2dp.c:1970
#6  0x0000559929b54f86 in append_property (iface=3Diface@entry=3D0x55992b2f=
bdd0,
p=3Dp@entry=3D0x559929bd6830 <sep_properties+48>, dict=3Ddict@entry=3D0x7ff=
fbd269430)
at gdbus/object.c:498
#7  0x0000559929b55632 in append_properties (data=3Ddata@entry=3D0x55992b2f=
bdd0,
iter=3Diter@entry=3D0x7fffbd2694b0) at gdbus/object.c:527
#8  0x0000559929b556bf in append_interface (data=3D0x55992b2fbdd0,
user_data=3D0x7fffbd269590) at gdbus/object.c:542
#9  0x00007f7319778938 in g_slist_foreach (list=3D<optimized out>,
func=3Dfunc@entry=3D0x559929b55670 <append_interface>,
user_data=3Duser_data@entry=3D0x7fffbd269590) at ../../../glib/gslist.c:885
#10 0x0000559929b557c9 in emit_interfaces_added (data=3D0x55992b31f310) at
gdbus/object.c:574
#11 process_changes (user_data=3D0x55992b31f310) at gdbus/object.c:996
#12 0x0000559929b56fb7 in g_dbus_flush (connection=3D0x55992b2d57d0) at
gdbus/object.c:1494
#13 g_dbus_send_message (message=3D0x55992b2fbe10, connection=3D0x55992b2d5=
7d0) at
gdbus/object.c:1518
#14 g_dbus_send_message (connection=3D0x55992b2d57d0, message=3D0x55992b2fb=
e10) at
gdbus/object.c:1498
#15 0x0000559929b39d87 in device_profile_connected (err=3D-5,
profile=3D0x559929be0440 <a2dp_source_profile>, dev=3D0x55992b301360) at
src/device.c:1802
#16 service_state_changed (service=3D<optimized out>, old_state=3D<optimize=
d out>,
new_state=3D<optimized out>, user_data=3D<optimized out>) at src/device.c:7=
002
#17 0x0000559929b2d072 in change_state (service=3D0x55992b306bd0,
state=3DBTD_SERVICE_STATE_DISCONNECTED, err=3D<optimized out>) at src/servi=
ce.c:98
#18 0x0000559929ab91ef in discovery_complete (session=3D<optimized out>,
seps=3D<optimized out>, err=3D-5, user_data=3D0x55992b305b70) at
profiles/audio/source.c:237
#19 0x0000559929abdd87 in finalize_discover (s=3D0x55992b301250) at
profiles/audio/a2dp.c:403
#20 discover_cb (session=3D<optimized out>, seps=3D<optimized out>, err=3D<=
optimized
out>, user_data=3D0x55992b301250) at profiles/audio/a2dp.c:2842
#21 0x0000559929ac0ba7 in finalize_discovery (session=3D0x55992b311700, err=
=3D0) at
profiles/audio/avdtp.c:1087
#22 0x0000559929ac63e0 in avdtp_parse_resp (transaction=3D<optimized out>,
size=3D16, buf=3D0x55992b311773, signal_id=3D<optimized out>, stream=3D0x0,
session=3D0x55992b311700) at profiles/audio/avdtp.c:2957
#23 session_cb (data=3D0x55992b311700, cond=3D<optimized out>, chan=3D<opti=
mized
out>) at profiles/audio/avdtp.c:2284
#24 session_cb (chan=3D<optimized out>, cond=3D<optimized out>,
data=3D0x55992b311700) at profiles/audio/avdtp.c:2208
#25 0x00007f7319758be4 in g_main_dispatch (context=3D0x55992b2d05b0) at
../../../glib/gmain.c:3381
#26 g_main_context_dispatch (context=3D0x55992b2d05b0) at
../../../glib/gmain.c:4099
#27 0x00007f7319758f88 in g_main_context_iterate (context=3D0x55992b2d05b0,
block=3Dblock@entry=3D1, dispatch=3Ddispatch@entry=3D1, self=3D<optimized o=
ut>) at
../../../glib/gmain.c:4175
#28 0x00007f7319759273 in g_main_loop_run (loop=3D0x55992b2d1790) at
../../../glib/gmain.c:4373
#29 0x0000559929b6ccd5 in mainloop_run () at src/shared/mainloop-glib.c:66
#30 0x0000559929b6d12c in mainloop_run_with_signal
(func=3Dfunc@entry=3D0x559929afe2c0 <signal_callback>,
user_data=3Duser_data@entry=3D0x0) at src/shared/mainloop-notify.c:188
#31 0x0000559929ab142d in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at
src/main.c:1210
```

It looks like it=E2=80=99s a problem in D-Bus, so I reported it to their is=
sue tracker
as *Segfault in `_dbus_marshal_write_basic`* [1].

[1]: https://gitlab.freedesktop.org/dbus/dbus/-/issues/372

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
