Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414082009-40903-1-git-send-email-jamuraa@chromium.org>
References: <1414082009-40903-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 23 Oct 2014 10:50:52 -0700
Message-ID: <CAJLTA8iaAd8jrLdPMy16Ha70EzKyHwBmOK3Rgi3W4M9x88AuYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/5] Unit tests for GAttrib
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu Oct 23 2014 at 9:33:36 AM Michael Janssen <jamuraa@chromium.org> wrote:
>
> Since we want to shim GAttrib for a smooth transition to bt_att
> profiles, this patch cleans up the API and adds unit tests for
> GAttrib functions.
>
> This adds tests for all but the register / unregister functions, which
> I will send in a separate patch since they are slightly more complicated due
> to catchalls.
>
> Michael Janssen (5):
>   Remove unused g_attrib_set_debug function
>   attrib: Remove MTU-probing code
>   attrib: Add mtu argument to g_attrib_new
>   attrib: remove g_attrib_is_encrypted
>   Add unit test for gattrib
>
>  .gitignore           |   1 +
>  Makefile.am          |   7 +
>  attrib/gattrib.c     |  38 +---
>  attrib/gattrib.h     |   7 +-
>  attrib/gatttool.c    |  17 +-
>  attrib/interactive.c |  17 +-
>  src/attrib-server.c  |   9 +-
>  src/device.c         |  11 +-
>  unit/test-gattrib.c  | 584 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 645 insertions(+), 46 deletions(-)
>  create mode 100644 unit/test-gattrib.c
>
> --
> 2.1.0.rc2.206.gedb03e5
>

I just realized this patchset is missing a bunch of style fixes (also,
it has a massive block comment) in unit/test-gattrib.c.  A v2 will
come which fixes style to conform with HACKING.   If there are other
comments I will incorporate those too.
