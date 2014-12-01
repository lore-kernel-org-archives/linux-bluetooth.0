Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417196962-3876-1-git-send-email-armansito@chromium.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Date: Mon, 1 Dec 2014 11:49:38 +0200
Message-ID: <CABBYNZL9MYvD6XNYHH8CURt5-CL6c-8iM3J4a_oMnYUsyL2YFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] shared/gatt: Use gatt-db for client role.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 28, 2014 at 7:49 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set integrates shared/gatt-db into shared/gatt-client:
>   1. shared/gatt-client's internal service_list structure has been
>      removed entirely in favor of gatt-db.
>   2. The high level structures defined in gatt-client.h
>      (bt_gatt_service_t, bt_gatt_characteristic_t, bt_gatt_descriptor_t)
>      and the corresponding iterator structures and functions have been
>      removed.
>   3. Code using the iterators (unit/test-gatt, tools/btgatt*) now access
>      the client cache via gatt-client's gatt-db.
>   4. Small bug fixes in gatt-db.
>
> Arman Uguray (8):
>   shared/gatt-db: Fix bug in maximum handle check.
>   shared/gatt-db: Add helper to get service handles.
>   shared/gatt-client: Store services in gatt_db.
>   shared/gatt-client: Use gatt_db in bt_gatt_register_notify
>   tools/btgatt-server: Add the "services" command
>   tools/btgatt-client: Use gatt-db instead of iterators
>   unit/test-gatt: Use gatt-db for CLIENT tests
>   shared/gatt-client: Remove GATT structs and iterators
>
>  src/shared/gatt-client.c | 1189 +++++++++++++++++++++-------------------------
>  src/shared/gatt-client.h |   73 +--
>  src/shared/gatt-db.c     |   41 +-
>  tools/btgatt-client.c    |  175 +++----
>  tools/btgatt-server.c    |   90 ++++
>  unit/test-gatt.c         |  241 +++++++---
>  6 files changed, 911 insertions(+), 898 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Ive applied the first 2, please check the comments about the third.


-- 
Luiz Augusto von Dentz
