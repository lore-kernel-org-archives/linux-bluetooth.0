Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418166065-21055-1-git-send-email-armansito@chromium.org>
References: <1418166065-21055-1-git-send-email-armansito@chromium.org>
Date: Mon, 15 Dec 2014 13:48:02 +0200
Message-ID: <CABBYNZJRgPE-ektzjsSGbfcsPZ1PUajexzBq5qzqqKYvqctGog@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 00/12] core: Use shared/gatt-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 10, 2014 at 1:00 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v1:
>   - Addressed comments by Johan and Luiz.
>
>
> This patch set integrates shared/gatt-client into bluetoothd. The following
> items have been tackled here:
>
>   1. src/device now uses shared/gatt-client to perform service discovery. State
>   updates such as disconnections, service changed events, etc. are done using
>   callback APIs of the new shared framework and attrib/gatt is no longer used to
>   perform GATT operations directly. A GAttrib instance is maintained for
>   backwards compatibility with profiles that haven't been converted yet.
>
>   2. A new gatt-callbacks API has been added which mirrors the attio APIs for
>   shared/gatt-client. Profiles/plugins are notified using these APIs when the
>   bearer disconnects, when services change, and when gatt-client is ready.
>
>   3. The profiles/gatt plugin has been rewritten. Since the GATT service is
>   handled by shared/gatt-client, this profile no longer deals with service
>   changed events performs out of place MTU exchanges, which used to get
>   performed in an arbitrary order. The profile has been renamed to profiles/gap
>   as it now only deals with the GAP service, and reads the "Appearance" and
>   "Device Name" characteristics using the new shared stack.
>
> Arman Uguray (12):
>   attrib/gattrib: Add g_attrib_get_att.
>   shared/att: Add err argument to disconnect cb
>   shared/gatt-client: Set op->success correctly
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
>  Makefile.am              |   1 +
>  Makefile.plugins         |   4 +-
>  attrib/gattrib.c         |   8 +
>  attrib/gattrib.h         |   3 +
>  profiles/gap/gas.c       | 322 +++++++++++++++++++++++++
>  profiles/gatt/gas.c      | 457 ------------------------------------
>  src/attrib-server.c      |   2 +-
>  src/device.c             | 598 +++++++++++++++++++++++++++++++++--------------
>  src/device.h             |   2 +-
>  src/gatt-callbacks.h     |  36 +++
>  src/shared/att-types.h   |   3 +-
>  src/shared/att.c         |  23 +-
>  src/shared/att.h         |   2 +-
>  src/shared/gatt-client.c |   6 +-
>  tools/btgatt-client.c    |   4 +-
>  tools/btgatt-server.c    |   4 +-
>  16 files changed, 832 insertions(+), 643 deletions(-)
>  create mode 100644 profiles/gap/gas.c
>  delete mode 100644 profiles/gatt/gas.c
>  create mode 100644 src/gatt-callbacks.h
>
> --
> 2.2.0.rc0.207.ga3a616c

Looks like you will need to rebase this set do not apply anymore.


-- 
Luiz Augusto von Dentz
