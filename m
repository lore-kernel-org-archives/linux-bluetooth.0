Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Date: Tue, 18 Nov 2014 19:31:15 -0800
Message-ID: <CAHrH25RC9HwEm-Td1cH8A7swJdSpkcO5P-y9qjB=m9OHzMMGcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/12] core: Use shared/gatt-client.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

> On Mon, Nov 17, 2014 at 11:22 AM, Arman Uguray <armansito@chromium.org> wrote:
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
>   shared/att: Add bt_att_get_fd.
>   shared/att: Directly close fd on ATT violations.
>   shared/gatt-client: Call ready_handler only in init.
>   core: device: Use bt_att_register_disconnect.
>   core: device: Use shared/gatt-client for GATT.
>   core: Introduce gatt-callbacks
>   profiles/gatt: Don't handle GATT service.
>   profiles/gatt: Rename profile to gap.
>   profiles/gap: Rewrite using bt_gatt_client.
>   profiles/gap: Add Google copyright.
>   TODO: Update GAttrib related items.
>
>  Makefile.am              |   1 +
>  Makefile.plugins         |   4 +-
>  TODO                     |  25 +--
>  attrib/gattrib.c         |   8 +
>  attrib/gattrib.h         |   3 +
>  profiles/gap/gas.c       | 307 +++++++++++++++++++++++++++++++
>  profiles/gatt/gas.c      | 457 -----------------------------------------------
>  src/device.c             | 456 +++++++++++++++++++++++++++++++---------------
>  src/device.h             |   2 -
>  src/gatt-callbacks.h     |  42 +++++
>  src/shared/att-types.h   |   3 +-
>  src/shared/att.c         |  25 ++-
>  src/shared/att.h         |   1 +
>  src/shared/gatt-client.c |   3 +-
>  14 files changed, 711 insertions(+), 626 deletions(-)
>  create mode 100644 profiles/gap/gas.c
>  delete mode 100644 profiles/gatt/gas.c
>  create mode 100644 src/gatt-callbacks.h
>
> --
> 2.1.0.rc2.206.gedb03e5
>

ping
