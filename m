Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
References: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
Date: Wed, 25 Mar 2015 12:43:56 +0200
Message-ID: <CABBYNZLkt=9QHdCDxBekk4jby1P2NL9B1NFqOD34PZEEnzVz0Q@mail.gmail.com>
Subject: Re: [BlueZ v4 00/15] Introduce LE Advertisement D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Mon, Mar 23, 2015 at 5:10 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Introduces and starts implementation of a LE Advertisement API.
>
> Things that are missing still (and added to the TODO):
>  * MGMT API for modifying the LE Advertisements
>  * Semantics for multiple Advertisements (currently any more than one will fail)
>  * TX Power property parsing / interface
>
> v1 -> v2:
>  * Cleanup based on comments from Arman
>  * Add g_dbus_proxy_set_read_watch function to avoid ObjectManager dependency
>  * Consolidate script updates into single test script
>
> v2 -> v3:
>  * Change "ManufacturerSpecificData" to "ManufacturerData"
>  * Add advertisement-api.txt to EXTRA_DIST
>  * Add Release() callback to org.bluez.LEAdvertisement1
>  * Remove IncludePower from the LEAdvertisement1 API
>
> v3 -> v4:
>  * Rename "g_dbus_proxy_set_read_watch" to "g_dbus_proxy_set_ready_watch"
>
> Michael Janssen (15):
>   doc: Add LE Advertisement D-Bus API documentation
>   core: advertising: add LEAdvertisingManager stubs
>   gdbus/client: add g_dbus_proxy_set_ready_watch
>   unit/test-dbus-client: test for g_dbus_set_ready_watch
>   advertising-manager: Implement RegisterAdvertisement
>   tools: Python script to test Advertisement API
>   build: add advertising-api.txt to docs distributed
>   advertising-manager: implement UnregisterAdvertisement
>   shared: add advertising-data
>   advertising-manager: use advertising_data
>   advertising-manager: Parse ServiceUUIDs
>   advertising-manager: Parse SolicitUUIDs
>   advertising-manager: Parse ManufacturerSpecificData
>   advertising-manager: Parse ServiceData
>   Update TODO for LE Advertising
>
>  Makefile.am                   |   5 +-
>  TODO                          |  21 +-
>  doc/advertising-api.txt       | 101 +++++++
>  gdbus/client.c                |  17 ++
>  gdbus/gdbus.h                 |   3 +
>  src/adapter.c                 |  19 ++
>  src/advertising-manager.c     | 614 ++++++++++++++++++++++++++++++++++++++++++
>  src/advertising-manager.h     |  25 ++
>  src/shared/advertising-data.c | 349 ++++++++++++++++++++++++
>  src/shared/advertising-data.h |  69 +++++
>  tools/advertisement-example   | 170 ++++++++++++
>  unit/test-gdbus-client.c      |  66 +++++
>  12 files changed, 1448 insertions(+), 11 deletions(-)
>  create mode 100644 doc/advertising-api.txt
>  create mode 100644 src/advertising-manager.c
>  create mode 100644 src/advertising-manager.h
>  create mode 100644 src/shared/advertising-data.c
>  create mode 100644 src/shared/advertising-data.h
>  create mode 100644 tools/advertisement-example
>
> --
> 2.2.0.rc0.207.ga3a616c

Patch 01/15 was already applied, since I applied my patch for of gdbus
you will probably need to rebase and once you do please change the
name of the file to just advertising.c and make the prefix
core/advertising: for the patches touching it.


-- 
Luiz Augusto von Dentz
