Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Date: Mon, 16 Feb 2015 11:13:38 +0200
Message-ID: <CABBYNZLYNq69wxYhSAzbzTtkNC_eQciwkoufptmq3tfchg=CBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 00/14] Rewrite local GATT server using shared/gatt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 12, 2015 at 5:17 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v1: Addressed comments by jamuraa and vudentz:
>   - Now passing bt_att instead of bdaddr_t in gatt_db callbacks and functions.
>     I have not run the tests on the android side here, so I would appreciate it
>     if you can run them.
>   - Renamed src/gatt-server to src/gatt-database for now. Added TODO item for
>     refactoring this later.
>   - Updated the TODO items for GATT.
>
> This patch set includes patches that rewrite the local GATT server using
> shared/gatt. This in effect invalidates the existing src/attrib-server in
> favor of a new src/gatt-server.
>
> Arman Uguray (14):
>   CHROMIUM: shared/att: Add bt_att_get_fd
>   CHROMIUM: shared/gatt: Pass bt_att instead of bdaddr_t
>   CHROMIUM: core: Introduce btd_gatt_database
>   CHROMIUM: core: Attach gatt-server to bt_att
>   CHROMIUM: core: gatt: Add GATT/GAP services to local db
>   CHROMIUM: core: Add GATT UUIDs to Adapter1.UUIDs
>   CHROMIUM: core: Support per-client CCC state
>   CHROMIUM: core: Setup added/removed handlers in GATT database
>   CHROMIUM: core: Add Service Changed characteristic
>   CHROMIUM: core: device: Add getter for GATT server
>   CHROMIUM: core: gatt-server: Send "Service Changed"
>   CHROMIUM: core: adapter: Send UUIDs changed for GATT services
>   CHROMIUM: shared/gatt: Don't incorrectly terminate discovery
>   TODO: Update GATT items.
>
>  Makefile.am               |   1 +
>  TODO                      |  54 ++--
>  android/gatt.c            |  98 ++++--
>  src/adapter.c             |  59 +++-
>  src/device.c              |  52 +++-
>  src/device.h              |   1 +
>  src/gatt-client.c         |   1 +
>  src/gatt-database.c       | 766 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/gatt-database.h       |  29 ++
>  src/main.c                |   3 +
>  src/shared/att.c          |   8 +
>  src/shared/att.h          |   2 +
>  src/shared/gatt-client.c  |   6 +-
>  src/shared/gatt-db.c      |  10 +-
>  src/shared/gatt-db.h      |   8 +-
>  src/shared/gatt-helpers.c |   3 +-
>  src/shared/gatt-server.c  |  32 +-
>  tools/btgatt-server.c     |  18 +-
>  unit/test-gatt.c          |   5 +-
>  19 files changed, 1052 insertions(+), 104 deletions(-)
>  create mode 100644 src/gatt-database.c
>  create mode 100644 src/gatt-database.h
>
> --
> 2.2.0.rc0.207.ga3a616c

First 2 are now applied, I reworking the btd_gatt_database API.



-- 
Luiz Augusto von Dentz
