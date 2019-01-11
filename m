Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB3BC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524E620870
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfAKNxH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:53:07 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33478 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729744AbfAKNxH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 08:53:07 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5984C29D24
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 13:53:06 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 4DD6229D57; Fri, 11 Jan 2019 13:53:06 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Fri, 11 Jan 2019 13:53:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mliska@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202213-62941-Uf7UxkKq5g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202213-62941@https.bugzilla.kernel.org/>
References: <bug-202213-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202213

--- Comment #10 from Martin Liška (mliska@suse.cz) ---
Yes, it's problematic, please see explanation:
https://gcc.gnu.org/ml/gcc-patches/2019-01/msg00629.html

and there's a reduced example:

$ cat /tmp/x.c
struct test_data_de {
 const void *input_data;
 int input_size;
};


int main()
{
  struct test_data_de *ptr;
  {
    static struct test_data_de data;
    data.input_size = sizeof((const unsigned char[]) { 0x25, 0x00 });
    data.input_data = ((const unsigned char[]) { 0x25, 0x00 });
    ptr = &data;
  }

  *(char*)ptr->input_data = 'x';

  return 0;
}

$ gcc /tmp/x.c -fsanitize=address && ./a.out 
=================================================================
==17535==ERROR: AddressSanitizer: stack-use-after-scope on address
0x7fffffffdc20 at pc 0x0000004012d9 bp 0x7fffffffdbe0 sp 0x7fffffffdbd8
WRITE of size 1 at 0x7fffffffdc20 thread T0
    #0 0x4012d8 in main (/home/marxin/Programming/bluez/a.out+0x4012d8)
    #1 0x7ffff7018fea in __libc_start_main ../csu/libc-start.c:308
    #2 0x4010c9 in _start (/home/marxin/Programming/bluez/a.out+0x4010c9)

Address 0x7fffffffdc20 is located in stack of thread T0 at offset 32 in frame
    #0 0x401181 in main (/home/marxin/Programming/bluez/a.out+0x401181)

  This frame has 1 object(s):
    [32, 34) '<unknown>' <== Memory access at offset 32 is inside this variable
HINT: this may be a false positive if your program uses some custom stack
unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-use-after-scope
(/home/marxin/Programming/bluez/a.out+0x4012d8) in main
Shadow bytes around the buggy address:
  0x10007fff7b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x10007fff7b80: f1 f1 f1 f1[f8]f3 f3 f3 00 00 00 00 00 00 00 00
  0x10007fff7b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
You are receiving this mail because:
You are the assignee for the bug.
