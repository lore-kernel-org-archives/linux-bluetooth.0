Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKD=urtd9P1yo+BDCp1_LrkGHBxozKmjZk-+mcjogO4UQ@mail.gmail.com>
References: <1425024999-29789-1-git-send-email-armansito@chromium.org>
	<CABBYNZKD=urtd9P1yo+BDCp1_LrkGHBxozKmjZk-+mcjogO4UQ@mail.gmail.com>
Date: Mon, 2 Mar 2015 16:30:24 +0200
Message-ID: <CABBYNZ+Srd6btfk5BJERsm8AxK=+QzS_=Ysgt6nRfh1moRvW5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/16] Implement GATT server D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Feb 27, 2015 at 4:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Fri, Feb 27, 2015 at 10:16 AM, Arman Uguray <armansito@chromium.org> wrote:
>> *v2: - Introduced g_dbus_client_new_full instead of adding a new argument to
>>        g_dbus_client_new.
>>
>>      - Removed the crash fix patch. I'll fix this properly in a separate patch
>>        set by making discovery procedures cancelable.
>>
>> *v1: - Removed src/gatt.* based on email discussion.
>>
>>      - After some discussions on IRC, made ObjectManager mandatory on a
>>        per-service-subtree basis to reduce the number of unnecessary
>>        object processing and caching. One initial idea was to pass the
>>        service subtree directly to RegisterService but one of the
>>        concerns was that we should allow applications to use existing
>>        tooling for the standard ObjectManager interface.
>>
>>      - Minor fixes based on comments, also fixed things so that
>>        descriptors with CCC and CEP UUIDs cannot be registered by
>>        external apps.
>>
>>      - Included a fix for recent crashes seen in unit/test-gatt.
>>
>> This patch set implements the GATT server D-Bus API and provides an
>> example application in Python to demonstrate how the API can be used
>> to export GATT services of various functionality.
>>
>> Some of the basics of the code is very similar to what was already in
>> src/gatt-dbus.c, especially the bits that use gdbus/client to fetch
>> and interact with remote objects. However, src/gatt-dbus had a lot of
>> code that used the now-defunct src/gatt (which was going to be the new
>> GATT abstraction for bluetoothd before we built shared/gatt), so I
>> decided to remove gatt-dbus entirely and start from scratch with
>> src/gatt-manager.
>>
>> Apart from these the code is fairly straight-forward. New additions to
>> src/gatt-database have been made to allow upper layers to store CCC
>> descriptors and send out notifications. The API automatically creates
>> CCC and CEP (Characteristic Extended Properties) descriptors based on
>> characteristic properties.
>>
>> Arman Uguray (16):
>>   gdbus/client: Don't GetManagedObjects w/o handlers
>>   gdbus/client: Allow specifying ObjectManager path
>>   doc/gatt-api.txt: New ObjectManager requirements
>>   core: gatt: Add GattManager1 stubs
>>   core: gatt: Implement GattManager1.RegisterService
>>   core: gatt: Register characteristics
>>   core: gatt: Support ReadValue for characteristics
>>   core: gatt: Support WriteValue for characteristics
>>   core: gatt: Make CCC addition API public
>>   core: gatt: Create CCC for external characteristic
>>   core: gatt: Add btd_gatt_database_notify function
>>   core: gatt: Send not/ind for D-Bus characteristics
>>   core: gatt: Create CEP for external characteristic
>>   core: gatt: Register descriptors
>>   core: gatt: Support descriptor reads/writes
>>   tools: Added a Python example for GATT server API
>>
>>  Makefile.am         |    3 +-
>>  doc/gatt-api.txt    |   74 ++-
>>  gdbus/client.c      |   27 +-
>>  gdbus/gdbus.h       |    4 +
>>  src/adapter.c       |   18 +-
>>  src/gatt-database.c |  114 ++++-
>>  src/gatt-database.h |   16 +
>>  src/gatt-dbus.c     |  658 ------------------------
>>  src/gatt-dbus.h     |   25 -
>>  src/gatt-manager.c  | 1383 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  src/gatt-manager.h  |   23 +
>>  src/gatt.c          |  321 ------------
>>  src/gatt.h          |  121 -----
>>  src/main.c          |    5 -
>>  tools/gatt-example  |  463 +++++++++++++++++
>>  15 files changed, 2089 insertions(+), 1166 deletions(-)
>>  delete mode 100644 src/gatt-dbus.c
>>  delete mode 100644 src/gatt-dbus.h
>>  create mode 100644 src/gatt-manager.c
>>  create mode 100644 src/gatt-manager.h
>>  delete mode 100644 src/gatt.c
>>  delete mode 100644 src/gatt.h
>>  create mode 100755 tools/gatt-example
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>
> Ive applied patches 1-3, the reason I stop there is that while review
> the other patches it looks like gatt-manager.c will have too many
> dependencies on gatt-database.c, so many that I would consider have
> this on the same file otherwise we end up with bad API that use
> handles causing extra lookups, while if this code were in the same
> files all the CCC handling becomes quite simple and we don't even need
> another struct since btd_gatt_database could be used directly as
> context instead.

I went ahead and did the change to gatt-database.c for patches until
core: gatt: Support WriteValue for characteristics, note add some
fixes, lets try to gets the remaining rebased as well.
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
