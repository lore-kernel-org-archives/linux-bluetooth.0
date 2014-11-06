Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
References: <1415240111-10596-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 6 Nov 2014 17:43:01 +0200
Message-ID: <CABBYNZK_1GjncnakjdDy=o9n7qfNB2DWsBKqsvP=bRWbNM12Hg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] GAttrib cleanup and switch to bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Nov 6, 2014 at 4:15 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch set cleans up gattrib and adds some missing functionality
> to switch GAttrib to a shim on top of bt_att.  After this is merged,
> profiles using GAttrib can be transitioned to bt_att.
>
> v1 -> v2:
>  * Keep old copyright on gattrib.c
>  * Use 0x00 for sentinel value on BT_ATT_ALL_REQUESTS to futureproof
>
> Michael Janssen (4):
>   unit-gattrib: Fix uninitialized variable
>   gattrib: Remove unused GATTRIB_ALL_EVENTS
>   shared/att: Add support for BT_ATT_ALL_REQUESTS
>   GATT shim to src/shared bt_att
>
>  attrib/gattrib.c       | 734 ++++++++++---------------------------------------
>  attrib/gattrib.h       |   1 -
>  src/shared/att-types.h |   3 +
>  src/shared/att.c       |  11 +-
>  unit/test-gattrib.c    |  18 +-
>  5 files changed, 160 insertions(+), 607 deletions(-)
>
> --
> 2.1.2

Ive applied 1-3, the last one we need ensure it passes both unit tests
and end-to-end tests before going ahead with it.


-- 
Luiz Augusto von Dentz
