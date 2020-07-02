Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 05:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9B207D4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 05:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgGBF1M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgGBF1L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 01:27:11 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208409] New: segfault in bluetoothd on mouse pairing
Date:   Thu, 02 Jul 2020 05:27:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david@aqwari.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-208409-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208409

            Bug ID: 208409
           Summary: segfault in bluetoothd on mouse pairing
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4.49
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: david@aqwari.net
        Regression: No

Created attachment 290051
  --> https://bugzilla.kernel.org/attachment.cgi?id=290051&action=edit
output of bluetoothd -n -d

I have a "3D connexion cadmouse pro wireless" that reliably causes bluetoothd
to segfault whenever I try to pair it with my Dell XPS 13 (9350). Here is the
stack trace:

        #0  g_io_channel_unix_get_fd (channel=0x0) at ../glib/giounix.c:656
        #1  0x00005555555b68a3 in bt_io_get_type (io=<optimized out>,
gerr=0x7fffffffc2a0) at btio/btio.c:105
        #2  0x00005555555b88dc in bt_io_get (io=0x0, err=0x7fffffffc2a0,
opt1=BT_IO_OPT_SOURCE) at btio/btio.c:1513
        #3  0x00005555555a1e82 in report_map_read_cb (status=<optimized out>,
pdu=<optimized out>, plen=<optimized out>,
            user_data=<optimized out>) at profiles/input/hog-lib.c:992
        #4  0x00005555555b335c in read_blob_helper (status=0 '\000',
rpdu=<optimized out>, rlen=13,
            user_data=0x5555556d3eb0) at attrib/gatt.c:804
        #5  0x00005555555b44c6 in attrib_callback_result (opcode=<optimized
out>, pdu=0x5555556d5c01,
            length=<optimized out>, user_data=0x5555556c6880) at
attrib/gattrib.c:273
        #6  0x000055555560b950 in handle_rsp (att=0x5555556c4200,
opcode=<optimized out>, pdu=<optimized out>,
            pdu_len=<optimized out>) at src/shared/att.c:715
        #7  0x000055555560baed in can_read_data (io=<optimized out>,
user_data=0x5555556c4200) at src/shared/att.c:904
        #8  0x0000555555615429 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>)
            at src/shared/io-glib.c:170
        #9  0x00007ffff7ef9c1e in g_main_dispatch (context=0x555555689d30) at
../glib/gmain.c:3179
        #10 g_main_context_dispatch (context=context@entry=0x555555689d30) at
../glib/gmain.c:3844
        #11 0x00007ffff7ef9fd0 in g_main_context_iterate
(context=0x555555689d30, block=block@entry=1,
            dispatch=dispatch@entry=1, self=<optimized out>) at
../glib/gmain.c:3917
        #12 0x00007ffff7efa2a3 in g_main_loop_run (loop=0x55555568aee0) at
../glib/gmain.c:4111
        #13 0x00005555556159b1 in mainloop_run () at
src/shared/mainloop-glib.c:79
        #14 0x0000555555615db8 in mainloop_run_with_signal (func=<optimized
out>, user_data=0x0)
            at src/shared/mainloop-notify.c:201
        #15 0x00005555555ba6b5 in main (argc=<optimized out>, argv=<optimized
out>) at src/main.c:729

I stepped through a core dump with gdb. The mouse is sending a
BT_ATT_OP_READ_BLOB_RSP command. report_map_read_cb passes a NULL pointer to
g_attrib_get_channel here:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/input/hog-lib.c?h=5.53&id=1524499483a3678951c0e3059b158836398c4e9b#n992
which is not checked before being dereferenced.

btmon trace to follow...

-- 
You are receiving this mail because:
You are the assignee for the bug.
