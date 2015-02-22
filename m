Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Date: Sun, 22 Feb 2015 13:26:02 +0200
Message-ID: <CABBYNZJb+jG8Zf6MZONdGyAf-ZrEPAUhLhvvAv6c_6+yfcj59Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/18] Implement GATT server D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Sat, Feb 21, 2015 at 3:56 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch set implements the GATT server D-Bus API and provides an
> example application in Python to demonstrate how the API can be used
> to export GATT services of various functionality.
>
> Some of the basics of the code is very similar to what was already in
> src/gatt-dbus.c, especially the bits that use gdbus/client to fetch
> and interact with remote objects. However, src/gatt-dbus had a lot of
> code that used the now-defunct src/gatt (which was going to be the new
> GATT abstraction for bluetoothd before we built shared/gatt), so I
> decided to remove gatt-dbus entirely and start from scratch with
> src/gatt-manager.
>
> Apart from these the code is fairly straight-forward. New additions to
> src/gatt-database have been made to allow upper layers to store CCC
> descriptors and send out notifications. The API automatically creates
> CCC and CEP (Characteristic Extended Properties) descriptors based on
> characteristic properties.
>
> Arman Uguray (18):
>   core: gatt: Add GattManager1 stubs
>   gdbus: Don't refresh objects/props if disconnected
>   shared/gatt: Cancel timeouts when attrib removed
>   bluetooth.conf: Add DBus.Properties interface
>   core: gatt: Fix malformed error name in client API
>   core: gatt: Implement GattManager1.RegisterService
>   core: gatt: Register characteristics
>   core: gatt: Support ReadValue for characteristics
>   core: gatt: Support WriteValue for characteristics
>   core: gatt: Make CCC addition API public
>   core: gatt: Create CCC for external characteristic
>   core: gatt: Add btd_gatt_database_notify function
>   core: gatt: Send not/ind for D-Bus characteristics
>   core: gatt: Fix PropertiesChanged for "Flags"
>   core: gatt: Create CEP for external characteristic
>   core: gatt: Register descriptors
>   core: gatt: Support descriptor reads/writes
>   tools: Added a Python example for GATT server API
>
>  Makefile.am          |    2 +-
>  gdbus/client.c       |    8 +
>  src/adapter.c        |   18 +-
>  src/bluetooth.conf   |    3 +
>  src/gatt-client.c    |    7 +-
>  src/gatt-database.c  |  114 ++++-
>  src/gatt-database.h  |   16 +
>  src/gatt-dbus.c      |  658 ------------------------
>  src/gatt-dbus.h      |   25 -
>  src/gatt-manager.c   | 1373 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/gatt-manager.h   |   23 +
>  src/gatt.c           |    5 -
>  src/shared/gatt-db.c |   62 ++-
>  tools/gatt-example   |  484 ++++++++++++++++++
>  14 files changed, 2067 insertions(+), 731 deletions(-)
>  delete mode 100644 src/gatt-dbus.c
>  delete mode 100644 src/gatt-dbus.h
>  create mode 100644 src/gatt-manager.c
>  create mode 100644 src/gatt-manager.h
>  create mode 100755 tools/gatt-example
>
> --
> 2.2.0.rc0.207.ga3a616c

I went ahead and applied the fixes first, please next time make sure
you send them separately since fixes should take priority, I will
continue the review on Monday. One thing apparently you haven't touch
was gatt-api.txt document to state that we will be using ObjectManager
to fetch the objects, I think we have previously discussed that we
would do so but then checking the API it perhaps doesn't need to
mandatory since the service object should contains the characteristics
and descriptors, then all we need is to use g_dbus_proxy_new once we
got the connected internally since it will fallback to
Properties.GetAll if ObjectManager is not available. Also this sort of
API probably should have a note about being re-entrant in case we will
be fetching the objects/properties during RegisterService.



-- 
Luiz Augusto von Dentz
