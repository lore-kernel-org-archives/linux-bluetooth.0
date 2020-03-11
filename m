Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83742C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5398E21D7E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 13:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgCKNQC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgCKNQC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 09:16:02 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206815] New: bluez-5.53: unit/test-mesh-crypto fails
Date:   Wed, 11 Mar 2020 13:16:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pachoramos1@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-206815-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206815

            Bug ID: 206815
           Summary: bluez-5.53: unit/test-mesh-crypto fails
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.5.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pachoramos1@gmail.com
        Regression: No

Created attachment 287869
  --> https://bugzilla.kernel.org/attachment.cgi?id=287869&action=edit
test-suite.log

I get this failure
PASS: unit/test-crc
PASS: unit/test-textfile
PASS: unit/test-crypto
./test-driver: line 107:  1527 Aborted                 (core dumped) "$@" >
$log_file 2>&1
FAIL: unit/test-mesh-crypto
PASS: unit/test-mgmt
PASS: unit/test-uhid
PASS: unit/test-queue
PASS: unit/test-avctp
PASS: unit/test-gobex
/bin/sh ./libtool  --tag=CC   --mode=link x86_64-pc-linux-gnu-gcc  -fPIC   -O2
-pipe -march=native -fno-stack-protector -pie -Wl,-z,now -Wl,-O1
-Wl,--as-needed -Wl,--hash-style=gnu -o unit/test-sdp unit/test-sdp.o
src/sdpd-database.o src/log.o src/sdpd-service.o src/sdpd-request.o
lib/libbluetooth-internal.la src/libshared-glib.la -lglib-2.0 -lgthread-2.0
-pthread -lglib-2.0 
libtool: link: x86_64-pc-linux-gnu-gcc -fPIC -O2 -pipe -march=native
-fno-stack-protector -pie -Wl,-z -Wl,now -Wl,-O1 -Wl,--hash-style=gnu -o
unit/test-sdp unit/test-sdp.o src/sdpd-database.o src/log.o src/sdpd-service.o
src/sdpd-request.o -pthread  -Wl,--as-needed lib/.libs/libbluetooth-internal.a
src/.libs/libshared-glib.a -lgthread-2.0 -lglib-2.0 -pthread
PASS: unit/test-ecc
PASS: unit/test-sdp
PASS: unit/test-ringbuf
PASS: unit/test-avdtp
PASS: unit/test-gobex-transfer
PASS: unit/test-avrcp
/bin/sh ./libtool  --tag=CC   --mode=link x86_64-pc-linux-gnu-gcc  -fPIC   -O2
-pipe -march=native -fno-stack-protector -pie -Wl,-z,now -Wl,-O1
-Wl,--as-needed -Wl,--hash-style=gnu -o unit/test-gatt unit/test-gatt.o
src/libshared-glib.la lib/libbluetooth-internal.la -lglib-2.0 -lgthread-2.0
-pthread -lglib-2.0 
libtool: link: x86_64-pc-linux-gnu-gcc -fPIC -O2 -pipe -march=native
-fno-stack-protector -pie -Wl,-z -Wl,now -Wl,-O1 -Wl,--hash-style=gnu -o
unit/test-gatt unit/test-gatt.o -pthread  -Wl,--as-needed
src/.libs/libshared-glib.a lib/.libs/libbluetooth-internal.a -lgthread-2.0
-lglib-2.0 -pthread
PASS: unit/test-gatt
============================================================================
Testsuite summary for bluez 5.53
============================================================================
# TOTAL: 26
# PASS:  25
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0
============================================================================
See ./test-suite.log
============================================================================
make[3]: *** [Makefile:9726: test-suite.log] Error 1
make[2]: *** [Makefile:9834: check-TESTS] Error 2
make[1]: *** [Makefile:10228: check-am] Error 2
make: *** [Makefile:10230: check] Error 2

-- 
You are receiving this mail because:
You are the assignee for the bug.
