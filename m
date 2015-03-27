Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
References: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
Date: Fri, 27 Mar 2015 17:39:41 +0200
Message-ID: <CABBYNZ+0Gyy83mWffxN5mLs4pi+JtRFrrXHHDf57JJ1hs70MQw@mail.gmail.com>
Subject: Re: [BlueZ v6 00/13] Implement LE Advertisement D-Bus API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Mar 27, 2015 at 12:08 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Implementation of the LE Advertisement D-Bus API.
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
> v4 -> v5:
>  * Rebase
>  * Use g_dbus_client_set_proxy_handlers instead of g_dbus_proxy_set_ready_watch
>  * Add MGMT interface calls to actually advertise.
>
> v5 -> v6:
>  * Minor patch cruft cleanup
>  * Rename btd_advertising_manager to btd_advertising and fix filename change.
>
>
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
>  TODO                          |  20 +-
>  src/adapter.c                 |  19 ++
>  src/advertising.c             | 665 ++++++++++++++++++++++++++++++++++++++++++
>  src/advertising.h             |  25 ++
>  src/shared/advertising-data.c | 585 +++++++++++++++++++++++++++++++++++++
>  src/shared/advertising-data.h |  69 +++++
>  tools/advertisement-example   | 170 +++++++++++
>  8 files changed, 1546 insertions(+), 10 deletions(-)
>  create mode 100644 src/advertising.c
>  create mode 100644 src/advertising.h
>  create mode 100644 src/shared/advertising-data.c
>  create mode 100644 src/shared/advertising-data.h
>  create mode 100644 tools/advertisement-example
>
> --
> 2.2.0.rc0.207.ga3a616c

Ive applied patches 1-4, now for shared I think it is better to use
bt_ prefix, perhaps bt_advertisement or bt_ad if the former makes the
functions name too big.


-- 
Luiz Augusto von Dentz
