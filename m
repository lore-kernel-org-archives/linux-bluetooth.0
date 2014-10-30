Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
References: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 30 Oct 2014 15:29:41 -0700
Message-ID: <CAHrH25Sg36wm4z5=bh-r8h42Axk1Dq-m5BeY4_U8aCkQ-Hs9Qw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 00/10] Unit tests for gattrib API
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On Wed, Oct 29, 2014 at 7:45 PM, Michael Janssen <jamuraa@chromium.org> wrote:
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
> Michael Janssen (10):
>   Remove unused g_attrib_set_debug function
>   attrib: Remove MTU-probing code
>   attrib: Add mtu argument to g_attrib_new
>   attrib: remove g_attrib_is_encrypted
>   Add unit tests for gattrib
>   attrib: Add unit tests for g_attrib_register
>   attrib: fix GATTRIB_ALL_REQS behavior
>   unit/gattrib: Check expected PDUs were delivered
>   unit/gattrib: Respond to the request PDU.
>   unit/gattrib: copy result PDU
>
>  .gitignore           |   1 +
>  Makefile.am          |   7 +
>  attrib/gattrib.c     |  61 +++---
>  attrib/gattrib.h     |   7 +-
>  attrib/gatttool.c    |  17 +-
>  attrib/interactive.c |  17 +-
>  src/attrib-server.c  |  12 ++
>  src/device.c         |  11 +-
>  unit/test-gattrib.c  | 578 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 666 insertions(+), 45 deletions(-)
>  create mode 100644 unit/test-gattrib.c
>
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

ping
