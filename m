Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
References: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
Date: Mon, 3 Nov 2014 17:26:42 +0200
Message-ID: <CABBYNZKiiBXMfjRbWo+sp1Gd3LmUsxJ8QKPOHJoAFU3BOpaDhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 0/8] Unit tests for gattrib API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Oct 31, 2014 at 8:14 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Since we want to replace GAttrib with a bt_att shim for a smooth transition
> to bt_att profiles, this patch cleans up the API and adds unit tests for
> GAttrib functions.
>
> This adds tests for all but the register / unregister functions, which
> I will send in a separate patch since they are slightly more complicated due
> to catchalls.
>
> v1 -> v2:
>   * Add g_attrib_register tests
>   * Cleanup of unit/test-gattrib.c
>   * Bugfix for GATTRIB_ALL_REQS
>
> v2 -> v3:
>   * Just move g_attrib_is_encrypted to static (Luiz)
>   * Check that registered-for PDUs were delivered
>   * Respond to Request PDU when registered for it.
>   * Copy result PDUs since they aren't guaranteed to live beyond callback.
>
> v3 -> v4:
>   * Rework to use g_main_loop_run() for running
>   * Reuse pdu_data struct in expect_response
>
> v4 -> v5:
>   * Rebase, fix compilation problems
>   * Only init log on --verbose
>
> Michael Janssen (8):
>   attrib: Add mtu argument to g_attrib_new
>   attrib: remove g_attrib_is_encrypted
>   Add unit tests for gattrib
>   attrib: Add unit tests for g_attrib_register
>   attrib: fix GATTRIB_ALL_REQS behavior
>   unit/gattrib: Check expected PDUs were delivered
>   unit/gattrib: Respond to the request PDU.
>   unit/gattrib: Only init log on --verbose
>
>  .gitignore           |   1 +
>  Makefile.am          |   7 +
>  attrib/gattrib.c     |  44 ++--
>  attrib/gattrib.h     |   4 +-
>  attrib/gatttool.c    |  17 +-
>  attrib/interactive.c |  17 +-
>  src/attrib-server.c  |  12 ++
>  src/device.c         |  11 +-
>  unit/test-gattrib.c  | 576 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 664 insertions(+), 25 deletions(-)
>  create mode 100644 unit/test-gattrib.c
>
> --
> 2.1.0.rc2.206.gedb03e5

Ive applied this set, but notice that I have to change quite many
things that check-patch was complaining and there was still a build
problem in android/gatt.c:1442:g_attrib_new which you did not update
so I had to fix it myself.

Btw, after applying I realize the very first test had some problems:

bluetoothd[14700]: attrib/gattrib.c:g_attrib_ref() 0x5da8670: ref=2
==14700== Conditional jump or move depends on uninitialised value(s)
==14700==    at 0x4032A6: test_refcount (test-gattrib.c:136)
==14700==    by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9EB1A: g_test_run_suite (in
/usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x402197: main (test-gattrib.c:579)
==14700==  Uninitialised value was created by a stack allocation
==14700==    at 0x403250: test_refcount (test-gattrib.c:125)
==14700==
bluetoothd[14700]: attrib/gattrib.c:g_attrib_unref() 0x5da8670: ref=1
==14700== Conditional jump or move depends on uninitialised value(s)
==14700==    at 0x4032D3: test_refcount (test-gattrib.c:140)
==14700==    by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9EB1A: g_test_run_suite (in
/usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x402197: main (test-gattrib.c:579)
==14700==  Uninitialised value was created by a stack allocation
==14700==    at 0x403250: test_refcount (test-gattrib.c:125)
==14700==
bluetoothd[14700]: attrib/gattrib.c:g_attrib_unref() 0x5da8670: ref=0
==14700== Conditional jump or move depends on uninitialised value(s)
==14700==    at 0x4032E3: test_refcount (test-gattrib.c:144)
==14700==    by 0x4E9E5E0: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9E7A5: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x4E9EB1A: g_test_run_suite (in
/usr/lib64/libglib-2.0.so.0.3800.2)
==14700==    by 0x402197: main (test-gattrib.c:579)
==14700==  Uninitialised value was created by a stack allocation
==14700==    at 0x403250: test_refcount (test-gattrib.c:125)
==14700==



-- 
Luiz Augusto von Dentz
