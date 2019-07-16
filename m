Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A4BC76192
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 21:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FD92173E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 21:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D799rozi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfGPVef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:34:35 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36818 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfGPVef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 17:34:35 -0400
Received: by mail-ot1-f48.google.com with SMTP id r6so22755479oti.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2019 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=EdYDaCAyx+qNAzhyP59fGkVnjjsN3giGDmxVMSqCWNA=;
        b=D799rozi0r4f+EL0OkbbtqZnsipCjFC37Bc9tVNbQ5BDd9si2eACzF6Mb60HHN+B7Q
         MlIIPNabiczw/R43VQjdZ8ZiENjZD/wTkRZxIKmLq7HkiKnnKCPMduRpdAuHWBKu6ACt
         hPMDGZOGC2rXjVdqIISuk0vjY0XDbp9LA4jYSPf3YuSxxYPTd3ecz8TUGpCTxf9lmZmj
         0wLgR2P4RA/URGZANMv0Cn9TEm4ClojkNNy8d+6ajF8jsb1yIUygOOsTVWFGbg8FxxN4
         wuQx772hnxJZZbIJRQlWYuI0sKd3mJYnWo1nzu8jwVeOnEMpCFfSW5e1eH6Vyk+6lNa3
         dcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EdYDaCAyx+qNAzhyP59fGkVnjjsN3giGDmxVMSqCWNA=;
        b=KStMz+0E8tbwzv+nyyA6XQR6SgoLHVBX1IV0rjdnp1baYrKH5eFgzC1TUxVLWg+0P+
         wQPu0a0BgLA8CelFr3GSQ8lTb43yjMJTivXnxwAvu9eZgP4F0II8R1yxQd5Xo+kNobgK
         d0wbCt+jiQIGBVFPR4M/cNP6dzDaIObbLnyfFQmcC6JZUTDz3PJlv5dIk1d40TWhpDRY
         lgGQ2rof8bfmef69Ucn6QgPTFzkGvlsw6Klb2bVChtVU7KRouxHygIqPh9Ngkb6luFR6
         6Q6snS7oQDEGFxI4ZtGTO8Qrgweie9J1oxC0Oc1of6tHq3UpPjosaCIvvvOuqCvmhbA3
         5rag==
X-Gm-Message-State: APjAAAX5SfS8oblt6KIEUgK7gVsJO6Qy3ubO8mnXUYgXf0sYj2Z/0cxn
        ZMCZvoH5fF9nlA5tv/rzI/TTHu71nW15EH1c4iP1JJZo
X-Google-Smtp-Source: APXvYqy/0jxZnNMb639zLX3yVlRm18+9vmafCTyQnfRGN3n99Sn0gHW+0X/Sbn9kJ6DU4Qayu0viLM79bVxcZPeL/FE=
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr6249253oto.124.1563312873717;
 Tue, 16 Jul 2019 14:34:33 -0700 (PDT)
MIME-Version: 1.0
From:   "mathieu.stephan@gmail.com" <mathieu.stephan@gmail.com>
Date:   Tue, 16 Jul 2019 23:34:22 +0200
Message-ID: <CAHdu5-4F8z=8=d3TH21gXxbi-G38CABMd6u-7scZ22DvzgiKkw@mail.gmail.com>
Subject: segfault when CCD are present in two different HOG services
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

We are currently developing a device that contains two HID services.
That device, as it is right now, is properly functioning on Windows & Android.
However, when pairing the device on Linux running bluez 5.50 we do get
segfaults (see attached files).
Our bluetooth device has 4 services : 1 battery service, 2 HID Over
Gatt services and 1 device information service.
With trial and error, we managed to find that we wouldn't get any
crash as long as only 1 HOG service was present.

Here's the interesting part. The two HOG services are made as follows:
- standard keyboard over gatt: protocole mode / report map / 1 INPUT
report / boot INPUT + OUTPUT / HID information / HID Control point
- raw HID over gatt : report map / 1 INPUT report / 1 OUTPUT report /
HID information / HID control point

Looking at the write_ccc in the call stacks we wondered if the
callbacks subscribing to notifications for the INPUT reports were
causing this issue.

We therefore changed the raw HID over gatt (and its report map) to
remove the INPUT report and change it into 1 OUTPUT report (leading to
2 OUTPUT reports): no crash.

We therefore hypothesize that the segfault occurs when subscribing to
notification on a second HOG service...



callstacks:

Program received signal SIGSEGV, Segmentation fault.
ccc_read_cb (status=<optimized out>, pdu=<optimized out>,
len=<optimized out>, user_data=<optimized out>) at
profiles/input/hog-lib.c:377
377 profiles/input/hog-lib.c: No such file or directory.
(gdb) bt
#0  ccc_read_cb (status=<optimized out>, pdu=<optimized out>,
len=<optimized out>, user_data=<optimized out>) at
profiles/input/hog-lib.c:377
#1  0x000055555559d40e in read_char_helper (status=<optimized out>,
rpdu=0x55555587f8d0 "\v", rlen=3, user_data=0x55555589daa0) at
attrib/gatt.c:841
#2  0x000055555559f32b in attrib_callback_result (opcode=<optimized
out>, pdu=0x55555587b5a1, length=<optimized out>,
user_data=0x5555558a39a0) at attrib/gattrib.c:273
#3  0x00005555555f74a8 in handle_rsp (pdu_len=<optimized out>,
pdu=<optimized out>, opcode=<optimized out>, att=0x55555588ff30) at
src/shared/att.c:714
#4  can_read_data (io=<optimized out>, user_data=0x55555588ff30) at
src/shared/att.c:886
#5  0x0000555555600733 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>) at
src/shared/io-glib.c:170
#6  0x00007ffff7b0a285 in g_main_context_dispatch () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7b0a650 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x00007ffff7b0a962 in g_main_loop_run () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x0000555555572419 in main (argc=<optimized out>, argv=<optimized
out>) at src/main.c:781


Program received signal SIGSEGV, Segmentation fault.
g_attrib_get_buffer (attrib=attrib@entry=0x31,
len=len@entry=0x7fffffffdfd0) at attrib/gattrib.c:437
437 attrib/gattrib.c: No such file or directory.
(gdb) bt
#0  g_attrib_get_buffer (attrib=attrib@entry=0x31,
len=len@entry=0x7fffffffdfd0) at attrib/gattrib.c:437
#1  0x000055555559eb79 in gatt_write_char (attrib=attrib@entry=0x31,
handle=handle@entry=37, value=value@entry=0x7fffffffe086 "\001",
vlen=vlen@entry=2, func=func@entry=0x555555598050
<report_ccc_written_cb>, user_data=user_data@entry=0x55555589ce20) at
attrib/gatt.c:956
#2  0x00005555555963fc in write_char (hog=0x5555558664f0, attrib=0x31,
handle=<optimized out>, value=value@entry=0x7fffffffe086 "\001",
vlen=vlen@entry=2, func=func@entry=0x555555598050
<report_ccc_written_cb>, user_data=0x5555558624e0) at
profiles/input/hog-lib.c:174
#3  0x000055555559800a in write_ccc (user_data=0x5555558624e0,
handle=<optimized out>, attrib=<optimized out>, hog=<optimized out>)
at profiles/input/hog-lib.c:360
#4  ccc_read_cb (status=<optimized out>, pdu=<optimized out>,
len=<optimized out>, user_data=<optimized out>) at
profiles/input/hog-lib.c:377
#5  0x000055555559d40e in read_char_helper (status=<optimized out>,
rpdu=0x555555876ef0 "\v", rlen=3, user_data=0x55555586cf40) at
attrib/gatt.c:841
#6  0x000055555559f32b in attrib_callback_result (opcode=<optimized
out>, pdu=0x55555587a671, length=<optimized out>,
user_data=0x55555589dfa0) at attrib/gattrib.c:273
#7  0x00005555555f74a8 in handle_rsp (pdu_len=<optimized out>,
pdu=<optimized out>, opcode=<optimized out>, att=0x555555897f00) at
src/shared/att.c:714
#8  can_read_data (io=<optimized out>, user_data=0x555555897f00) at
src/shared/att.c:886
#9  0x0000555555600733 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>) at
src/shared/io-glib.c:170
#10 0x00007ffff7b0a285 in g_main_context_dispatch () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#11 0x00007ffff7b0a650 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#12 0x00007ffff7b0a962 in g_main_loop_run () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#13 0x0000555555572419 in main (argc=<optimized out>, argv=<optimized
out>) at src/main.c:781



Program received signal SIGSEGV, Segmentation fault.
enc_write_req (handle=handle@entry=37,
value=value@entry=0x7fffffffe086 "\001", vlen=vlen@entry=2,
pdu=pdu@entry=0x40 <error: Cannot access memory at address 0x40>,
len=0) at attrib/att.c:633
633 attrib/att.c: No such file or directory.
(gdb) bt
#0  enc_write_req (handle=handle@entry=37,
value=value@entry=0x7fffffffe086 "\001", vlen=vlen@entry=2,
pdu=pdu@entry=0x40 <error: Cannot access memory at address 0x40>,
len=0) at attrib/att.c:633
#1  0x000055555559eba0 in gatt_write_char
(attrib=attrib@entry=0x555555874f90, handle=handle@entry=37,
value=value@entry=0x7fffffffe086 "\001", vlen=vlen@entry=2,
func=func@entry=0x555555598050 <report_ccc_written_cb>,
user_data=user_data@entry=0x5555558969b0)
    at attrib/gatt.c:963
#2  0x00005555555963fc in write_char (hog=0x555555883ee0,
attrib=0x555555874f90, handle=<optimized out>,
value=value@entry=0x7fffffffe086 "\001", vlen=vlen@entry=2,
func=func@entry=0x555555598050 <report_ccc_written_cb>,
user_data=0x5555558840e0)
    at profiles/input/hog-lib.c:174
#3  0x000055555559800a in write_ccc (user_data=0x5555558840e0,
handle=<optimized out>, attrib=<optimized out>, hog=<optimized out>)
at profiles/input/hog-lib.c:360
#4  ccc_read_cb (status=<optimized out>, pdu=<optimized out>,
len=<optimized out>, user_data=<optimized out>) at
profiles/input/hog-lib.c:377
#5  0x000055555559d40e in read_char_helper (status=<optimized out>,
rpdu=0x55555587fe00 "\v", rlen=3, user_data=0x55555586d140) at
attrib/gatt.c:841
#6  0x000055555559f32b in attrib_callback_result (opcode=<optimized
out>, pdu=0x55555587b1e1, length=<optimized out>,
user_data=0x55555586c5e0) at attrib/gattrib.c:273
#7  0x00005555555f74a8 in handle_rsp (pdu_len=<optimized out>,
pdu=<optimized out>, opcode=<optimized out>, att=0x55555587dd30) at
src/shared/att.c:714
#8  can_read_data (io=<optimized out>, user_data=0x55555587dd30) at
src/shared/att.c:886
#9  0x0000555555600733 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>) at
src/shared/io-glib.c:170
#10 0x00007ffff7b0a285 in g_main_context_dispatch () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#11 0x00007ffff7b0a650 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#12 0x00007ffff7b0a962 in g_main_loop_run () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#13 0x0000555555572419 in main (argc=<optimized out>, argv=<optimized
out>) at src/main.c:781
