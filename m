Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Date: Tue, 9 Dec 2014 14:53:56 +0200
Message-ID: <CABBYNZJh6c+_oUerwxi3eFpLR+ZMePBXWaL0sXYtE-BXk6HxHQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/15] core: Use shared/gatt for GATT client role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Dec 9, 2014 at 2:40 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set integrates shared/gatt into the core bluetoothd for GATT
> client role. This set makes the following changes:
>
>   - Made small fixes and added getters to support legacy code paths.
>
>   - Removed explicit primary and included service discovery logic within
>     src/device in favor of initializing a bt_gatt_client. This includes
>     deferring service/profile registration until the bt_gatt_client is ready,
>     and proper handling for "Service Changed" events using gatt_db's service
>     added/removed callbacks. When new services are added during a connection,
>     the profiles are explicitly probed. The code still creates and maintains
>     instances of struct gatt_primary to support legacy plugins.
>
>   - Introduced gatt-callbacks.h. This defines callbacks that are invoked when
>     services are removed, the gatt-client becomes ready, and when the connection
>     is closed. These callbacks are similar and parallel to the existing ones
>     defined in attio.h and provide an alternate solution for shared/gatt.
>     gatt-callbacks.h is not meant to be the long-term solution and these may
>     perhaps be better served by new GATT specific functions added to the
>     btd_profile/btd_service framework.
>
>   - Rewrote the built-in GAP/GATT profile. It no longer handles the GATT
>     service and does no MTU exchange (which was racy and did not belong in a
>     profile in the first place) as these are handled by shared/gatt-client.
>     Renamed the profile to profiles/gap as it only handles the remote GAP
>     service and added handling for the "Device Name" characteristic. The profile
>     now uses gatt-callbacks instead of attio and bt_gatt_client/gatt_db instead
>     of GAttrib.
>
> Arman Uguray (15):
>   attrib/gattrib: Add g_attrib_get_att.
>   shared/att: Add bt_att_get_fd.
>   attrib: Check if attrib is NULL in functions
>   shared/att: cancel_all before calling disconnect cb
>   shared/gatt-db: Make accessors work on const ptr
>   shared/gatt-db: Add UUID arg to foreach_service
>   core: device: Use bt_att_register_disconnect.
>   core: device: Use shared/gatt-client for GATT.
>   core: Rename device_attach_attrib
>   core: Use gatt_db service callbacks
>   core: Introduce gatt-callbacks
>   profiles/gatt: Don't handle GATT service.
>   profiles/gatt: Rename profile to gap.
>   profiles/gap: Rewrite using bt_gatt_client.
>   profiles/gap: Add Google copyright.
>
>  Makefile.am            |   1 +
>  Makefile.plugins       |   4 +-
>  attrib/gattrib.c       |  31 ++-
>  attrib/gattrib.h       |   3 +
>  profiles/gap/gas.c     | 321 +++++++++++++++++++++++++++
>  profiles/gatt/gas.c    | 457 --------------------------------------
>  src/attrib-server.c    |   2 +-
>  src/device.c           | 591 +++++++++++++++++++++++++++++++++++--------------
>  src/device.h           |   2 +-
>  src/gatt-callbacks.h   |  36 +++
>  src/shared/att-types.h |   3 +-
>  src/shared/att.c       |  12 +-
>  src/shared/att.h       |   1 +
>  src/shared/gatt-db.c   |  41 ++--
>  src/shared/gatt-db.h   |  28 ++-
>  tools/btgatt-client.c  |   9 +-
>  tools/btgatt-server.c  |   2 +-
>  unit/test-gatt.c       |   4 +-
>  18 files changed, 885 insertions(+), 663 deletions(-)
>  create mode 100644 profiles/gap/gas.c
>  delete mode 100644 profiles/gatt/gas.c
>  create mode 100644 src/gatt-callbacks.h
>
> --
> 2.2.0.rc0.207.ga3a616c

I went ahead and applied the fixes not related to core changes, please
rebase the rest and work in the comments.


-- 
Luiz Augusto von Dentz
