Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2491C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9304220874
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 09:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfAKJto convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:49:44 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40122 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbfAKJtn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 04:49:43 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5E8EB29993
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 09:49:42 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 52EF4299A5; Fri, 11 Jan 2019 09:49:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202213] bluez trunk tests fail with GCC 9 (or with
 -fsanitize=address with GCC 9)
Date:   Fri, 11 Jan 2019 09:49:41 +0000
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
Message-ID: <bug-202213-62941-cPX9nAEond@https.bugzilla.kernel.org/>
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

--- Comment #5 from Martin Liška (mliska@suse.cz) ---
(In reply to Stefan Seyfried from comment #4)
> With gcc9 (finally found a way to use it in OBS :-), it asserts:
> 
> abuild@strolchi:~/rpmbuild/BUILD/bluez-5.50> cat unit/test-sdp.log
> bluetoothd[3066]: Bluetooth daemon 5.50
> len: 7 raw_size: 14 cont_len: 0
> **
> ERROR:unit/test-sdp.c:258:client_handler: assertion failed: ((size_t) len ==
> rsp_pdu->raw_size + rsp_pdu->cont_len)
> FAIL unit/test-sdp (exit status: 134)
> 
> I added a printf before the assert (and shifted it down one line)

The patch does not fix the root problem.
#define define_test(name, _mtu, args...) \
        do {                                                            \
                const struct sdp_pdu pdus[] = {                         \
                        args, { }                                       \
                };                                                      \
                static struct test_data data;                           \
                data.mtu = _mtu;                                        \
                data.pdu_list = g_memdup(pdus, sizeof(pdus));           \
                tester_add(name, &data, NULL, test_sdp, NULL);          \
        } while (0)

here you copy pdus, but you should also memdup .raw_data, otherwise
it will reach it's end of scope.

Slightly reduced test-case that illustrates that:

$ cat test-sdp.i
struct a {
  void *b;
  long c
};
enum { d = 5 } typedef *e;
e g_malloc0_n();
typedef enum { f, g } h;
*g_io_channel_unix_new();
e g_memdup();
struct i {
  _Bool j;
  void *k;
  long l
};
struct m {
  struct i *n
};
struct context {
  int o;
  int fd;
  struct m *data
};
int q;
struct i r;
struct a s[];
t(e u) {
  struct context *context = u;
  r = context->data->n[q];
  s[0].b = r.k;
  s[0].c = r.l;
  writev(context->fd, s, 2);
  return 0;
}
v(int channel, h cond, e u) {
  struct context *context = u;
  g_source_remove(context->o);
  g_free(u);
  tester_test_passed();
}
int *w;
int aa[];
*x(data) {
  struct context *context = g_malloc0_n(1, sizeof(struct context));
  socketpair(1, d, 0, aa);
  w = g_io_channel_unix_new(aa[0]);
  context->o = g_io_add_watch(w, g, v, context);
  context->fd = aa[1];
  context->data = data;
}
y() {
  struct context *context = x();
  g_idle_add(t, context);
}
z;
main() {
  tester_init(z);
  {
    struct i ab[] = {.1, (char[]){4, 11, 0, 1}, sizeof(0)};
    static struct m data;
    data.n = g_memdup(ab, sizeof(ab));
    tester_add("", &data, 0, y);
  }
  tester_run();
}

$ ./test

 - init
 - setup
 - setup complete
 - run
=================================================================
==29724==ERROR: AddressSanitizer: stack-use-after-scope on address
0x7fffffffdc00 at pc 0x7ffff744c678 bp 0x7fffffffd9e0 sp 0x7fffffffd190
READ of size 4 at 0x7fffffffdc00 thread T0
    #0 0x7ffff744c677 in read_iovec
/home/marxin/Programming/gcc/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:956
    #1 0x7ffff744cded in __interceptor_writev
/home/marxin/Programming/gcc/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1150
    #2 0x408160 in t
/home/marxin/BIG/osc/Base:System/bluez/bluez-5.50/xxx/test-sdp.i:31
    #3 0x7ffff7ed8626  (/usr/lib64/libglib-2.0.so.0+0x4d626)
    #4 0x7ffff7edbc14 in g_main_context_dispatch
(/usr/lib64/libglib-2.0.so.0+0x50c14)
    #5 0x7ffff7edbfd7  (/usr/lib64/libglib-2.0.so.0+0x50fd7)
    #6 0x7ffff7edc2d1 in g_main_loop_run (/usr/lib64/libglib-2.0.so.0+0x512d1)
    #7 0x41ad10 in tester_run src/shared/tester.c:830
    #8 0x408603 in main
/home/marxin/BIG/osc/Base:System/bluez/bluez-5.50/xxx/test-sdp.i:63
    #9 0x7ffff7018fea in __libc_start_main ../csu/libc-start.c:308
    #10 0x403789 in _start
(/home/marxin/BIG/osc/Base:System/bluez/bluez-5.50/xxx/test+0x403789)

Address 0x7fffffffdc00 is located in stack of thread T0 at offset 48 in frame
    #0 0x408394 in main
/home/marxin/BIG/osc/Base:System/bluez/bluez-5.50/xxx/test-sdp.i:55

  This frame has 2 object(s):
    [48, 52) '<unknown>' <== Memory access at offset 48 is inside this variable
    [64, 88) 'ab' (line 58)
HINT: this may be a false positive if your program uses some custom stack
unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-use-after-scope
/home/marxin/Programming/gcc/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:956
in read_iovec
Shadow bytes around the buggy address:
  0x10007fff7b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7b70: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1
=>0x10007fff7b80:[f8]f2 f8 f8 f8 f3 f3 f3 f3 f3 00 00 00 00 00 00
  0x10007fff7b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007fff7bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
You are receiving this mail because:
You are the assignee for the bug.
