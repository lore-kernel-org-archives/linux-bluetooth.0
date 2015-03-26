Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
References: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 26 Mar 2015 16:22:54 +0200
Message-ID: <CABBYNZJkLvHdy95acCCuWNtXGzhkf8K2aOa4uVdCWgGX8fWMsQ@mail.gmail.com>
Subject: Re: [BlueZ v5 00/13] Implement LE Advertisement D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Mar 26, 2015 at 1:00 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Implementation of the LE Advertisement API.
>
> Things that are missing still (and added to the TODO):
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
> v4 -> v5:
>  * Rebase
>  * Use g_dbus_client_set_proxy_handlers instead of g_dbus_proxy_set_ready_watch
>  * Add MGMT interface calls to actually advertise.

Apparently you forgot to rename advertising-manager.c to
advertising.c, the former is awful long and I would also change to the
struct name to btd_advertising.

> Michael Janssen (13):
>   core: advertising: add LEAdvertisingManager stubs
>   core/advertising: Implement RegisterAdvertisement
>   tools: Python script to test Advertisement API
>   core/advertising: implement UnregisterAdvertisement
>   shared: add advertising-data
>   core/advertising: use advertising_data
>   core/advertising: Parse ServiceUUIDs
>   core/advertising: Parse SolicitUUIDs
>   core/advertising: Parse ManufacturerSpecificData
>   core/advertising: Parse ServiceData
>   Update TODO for LE Advertising
>   shared/advertising: implement advertising_data_generate
>   core/advertising: Add and Remove AD using MGMT
>
>  Makefile.am                   |   3 +
>  TODO                          |  21 +-
>  src/adapter.c                 |  19 ++
>  src/advertising.c             | 666 ++++++++++++++++++++++++++++++++++++++++++
>  src/advertising.h             |  25 ++
>  src/shared/advertising-data.c | 585 +++++++++++++++++++++++++++++++++++++
>  src/shared/advertising-data.h |  69 +++++
>  tools/advertisement-example   | 170 +++++++++++
>  8 files changed, 1548 insertions(+), 10 deletions(-)
>  create mode 100644 src/advertising.c
>  create mode 100644 src/advertising.h
>  create mode 100644 src/shared/advertising-data.c
>  create mode 100644 src/shared/advertising-data.h
>  create mode 100644 tools/advertisement-example
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
