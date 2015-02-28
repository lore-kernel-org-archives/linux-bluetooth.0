Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425096695-22608-1-git-send-email-armansito@chromium.org>
References: <1425096695-22608-1-git-send-email-armansito@chromium.org>
Date: Fri, 27 Feb 2015 20:22:26 -0800
Message-ID: <CAHrH25RtvLSCbpuBu+LtH8KtMJby4p1pRo9P-vr+wkk3NH9D7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Make discovery procedures cancellable
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Fri, Feb 27, 2015 at 8:11 PM, Arman Uguray <armansito@chromium.org> wrote:
> *v2: Fix comments by Marcel:
>     - Moved MTU exchange id patch out of 1/3.
>     - Renamed bt_gatt_async_req to bt_gatt_request.
>
> *v1: Fix errors from checkpatch
>
> This patch set makes the GATT discovery helper procedures cancellable.
> bt_gatt_client now cancels discovery and MTU exchange procedures in
> bt_gatt_client_cancel_all.
>
> Arman Uguray (3):
>   shared/gatt: Make discovery operations cancelable
>   shared/gatt: Cancel discovery requests in client
>   unit/test-gatt: Unref pending discovery requests
>
>  src/shared/gatt-client.c  | 113 +++++++++++++++------
>  src/shared/gatt-helpers.c | 252 ++++++++++++++++++++++++++--------------------
>  src/shared/gatt-helpers.h |  37 ++++---
>  unit/test-gatt.c          |  25 +++--
>  4 files changed, 271 insertions(+), 156 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c
>

Pushed.

-Arman
