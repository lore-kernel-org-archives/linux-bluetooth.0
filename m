Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Date: Tue, 23 Dec 2014 16:21:59 -0200
Message-ID: <CABBYNZLCpWb1v0nJK65iWJQnig0VJBBDRhTpCuHwEeug1_+0bQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/17] Implement doc/gatt-api.txt for client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Dec 19, 2014 at 7:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set implements the D-Bus API outlined in doc/gatt-api.txt for
> GATT client role. The main highlights are:
>   - All exported objects are managed by a btd_gatt_client, each
>     in turn owned by a btd_device. All D-Bus logic is isolated to
>     src/gatt-client
>
>   - A GattService1 hierarchy is exported for a GATT service only if no
>     btd_service exists for it, i.e. no internal profile has claimed the
>     service.
>
>   - Objects are exported when the gatt-client is ready and are removed
>     when the device disconnects, as there is nothing interesting that an
>     external application can do with services without a connection and
>     before the gatt-client becomes ready.
>
>   - Objects are added/removed after "Service Changed" events.
>
> Arman Uguray (17):
>   core: gatt: Introduce gatt-client.
>   core: gatt: Export GATT services on D-Bus
>   core: gatt: Export GATT characteristics on D-Bus
>   core: gatt: Export GATT descriptors on D-Bus
>   core: gatt: Implement GattCharacteristic1.ReadValue
>   core: gatt: Implement GattDescriptor1.ReadValue
>   core: gatt: Implement GattCharacteristic1.StartNotify
>   core: gatt: Implement GattCharacteristic1.StopNotify
>   core: gatt: Expose charac. extended properties.
>   shared/gatt-client: Expose MTU.
>   core: gatt: Implement GattCharacteristic1.WriteValue.
>   core: gatt: Don't always issue read-long for ReadValue
>   core: gatt: Implement GattDescriptor1.WriteValue.
>   core: gatt: Reference count chrcs and descs.
>   core: gatt: Handle Service Changed.
>   core: device: Add function to get GATT service
>   core: gatt: Don't export claimed services
>
>  Makefile.am              |    1 +
>  src/device.c             |   51 +-
>  src/device.h             |    4 +
>  src/gatt-client.c        | 1943 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/gatt-client.h        |   30 +
>  src/shared/gatt-client.c |   14 +-
>  src/shared/gatt-client.h |    8 +-
>  7 files changed, 2044 insertions(+), 7 deletions(-)
>  create mode 100644 src/gatt-client.c
>  create mode 100644 src/gatt-client.h
>
> --
> 2.2.0.rc0.207.ga3a616c

Patches 1-6 are now applied, I might continue with WriteValue but due
to the heavy changes I had done this code does not apply cleanly
anymore.


-- 
Luiz Augusto von Dentz
