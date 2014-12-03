Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Date: Wed, 3 Dec 2014 18:04:25 +0200
Message-ID: <CABBYNZ+QoevPv8R24-J67Aicx-q21esp4iTKOGAnjYZE33YsGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/8] shared/gatt: Use gatt-db for client role.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 3, 2014 at 2:12 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v1:
>   - bt_gatt_client_new now accepts a gatt_db. bt_gatt_client no longer
>     constructs a gatt_db directly.
>   - Other fixes suggested during reviews.
>
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
>   shared/gatt-db: Add gatt_db_isempty.
>   shared/gatt-client: Store services in gatt_db.
>   shared/gatt-client: Use gatt_db in bt_gatt_register_notify
>   tools/btgatt-server: Add the "services" command
>   tools/btgatt-client: Use gatt-db instead of iterators
>   unit/test-gatt: Use gatt-db for CLIENT tests
>   shared/gatt-client: Remove GATT structs and iterators
>   TODO: Add item for gatt-db service callbacks.
>
>  TODO                     |    6 +
>  src/shared/gatt-client.c | 1196 +++++++++++++++++++++-------------------------
>  src/shared/gatt-client.h |   78 +--
>  src/shared/gatt-db.c     |    8 +
>  src/shared/gatt-db.h     |    2 +
>  tools/btgatt-client.c    |  184 ++++---
>  tools/btgatt-server.c    |   90 ++++
>  unit/test-gatt.c         |  262 ++++++----
>  8 files changed, 926 insertions(+), 900 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied after fixing the build, you should probably start using git
rebase --exec make, anyway thanks a lot for the patches.


-- 
Luiz Augusto von Dentz
