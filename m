Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424247519-21684-1-git-send-email-armansito@chromium.org>
References: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Date: Wed, 18 Feb 2015 16:56:04 +0200
Message-ID: <CABBYNZKq_115dAvyBfKa00orycCT_96v7j8j98bXtQ8+g+-9pw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/8] Rewrite local GATT server using shared/gatt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Feb 18, 2015 at 10:18 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v2: Rebased remaining patches.
>
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
>
> Arman Uguray (8):
>   core: adapter: Initialize GATT database
>   core: Attach gatt-server to bt_att
>   core: Add GATT UUIDs to Adapter1.UUIDs
>   core: device: Add getter for GATT server
>   core: gatt: Send not/ind to devices
>   core: adapter: Send UUIDs changed for GATT services
>   shared/gatt: Don't incorrectly terminate discovery
>   TODO: Update GATT items.
>
>  TODO                     | 54 ++++++++++++++++++---------------
>  src/adapter.c            | 77 +++++++++++++++++++++++++++++++++++++++++-------
>  src/adapter.h            |  2 ++
>  src/device.c             | 55 ++++++++++++++++++++++++----------
>  src/device.h             |  1 +
>  src/gatt-database.c      | 25 ++++++++++++++--
>  src/shared/gatt-client.c |  3 +-
>  7 files changed, 162 insertions(+), 55 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, note that I did add support for BR/EDR that was missing, but
now we need to fix the following problems:


bluetoothd[28074]: plugins/gatt-example.c:gatt_example_adapter_probe()
Battery service could not be registered
bluetoothd[28074]: gatt-example-adapter-driver: Input/output error (5)
bluetoothd[28074]: Not enough free handles to register service
bluetoothd[28074]: Error adding Link Loss service
bluetoothd[28074]: Not enough free handles to register service
bluetoothd[28074]: Not enough free handles to register service
bluetoothd[28074]:
profiles/proximity/reporter.c:reporter_adapter_probe() Proximity
Reporter for adapter 0x5e86af0
bluetoothd[28074]: profiles/time/server.c:time_server_init() path
/org/bluez/hci0
bluetoothd[28074]: Not enough free handles to register service
bluetoothd[28074]: Current Time Service could not be registered
bluetoothd[28074]: gatt-time-server: Input/output error (5)
bluetoothd[28074]: Not enough free handles to register service
bluetoothd[28074]: Not enough free handles to register service

I guess it might be possible to leave attrib-server.h API but rewrite
the internals so that it actually uses bt_gatt_server and gatt_db, or
we can just rewrite the plugins and remove attrib-server altogether.


-- 
Luiz Augusto von Dentz
