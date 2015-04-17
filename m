Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 17 Apr 2015 15:18:34 +0300
Message-ID: <CABBYNZ+Gi6nw-UnGb45UJRd1t31fBmmup-Z7F1G-3128qNZwDQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 00/13] Add support for Advertisement Data
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 16, 2015 at 5:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> v2: Fix parsing of ServiceData and add a patch to create device objects
> for non-connectable devices.
>
> This adds support for ServiceData and ManufacturerData and make the
> necessary to bluetoothctl to print them:
>
> [bluetooth]# info XX:XX:XX:XX:XX:XX
> Device XX:XX:XX:XX:XX:XX
>         Alias: XX-XX-XX-XX-XX-XX
>         Paired: no
>         Trusted: no
>         Blocked: no
>         Connected: no
>         LegacyPairing: no
>         ManufacturerData Key: 0x004c
>         ManufacturerData Value: 0x0c
>         ManufacturerData Value: 0x0e
>         ManufacturerData Value: 0x00
>         ManufacturerData Value: 0xf1
>         ManufacturerData Value: 0xa6
>         ManufacturerData Value: 0xdc
>         ManufacturerData Value: 0xa1
>         ManufacturerData Value: 0xc0
>         ManufacturerData Value: 0x51
>         ManufacturerData Value: 0x80
>         ManufacturerData Value: 0xa7
>         ManufacturerData Value: 0x83
>         ManufacturerData Value: 0x62
>         ManufacturerData Value: 0x95
>         ManufacturerData Value: 0x18
>         ManufacturerData Value: 0x79
>
> [bluetooth]# info XX:XX:XX:XX:XX:XX
> Device XX:XX:XX:XX:XX:XX
>         Name: URI Beacon
>         Alias: URI Beacon
>         Paired: no
>         Trusted: no
>         Blocked: no
>         Connected: no
>         LegacyPairing: no
>         UUID: Unknown                   (0000fed8-0000-1000-8000-00805f9b34fb)
>         ServiceData Key: fed8
>         ServiceData Value: 0x00
>         ServiceData Value: 0x20
>         ServiceData Value: 0x00
>         ServiceData Value: 0x63
>         ServiceData Value: 0x72
>         ServiceData Value: 0x6f
>         ServiceData Value: 0x73
>         ServiceData Value: 0x73
>         ServiceData Value: 0x77
>         ServiceData Value: 0x61
>         ServiceData Value: 0x6c
>         ServiceData Value: 0x6b
>         ServiceData Value: 0x2d
>         ServiceData Value: 0x70
>         ServiceData Value: 0x72
>         ServiceData Value: 0x6f
>         ServiceData Value: 0x6a
>         ServiceData Value: 0x65
>         ServiceData Value: 0x63
>         ServiceData Value: 0x74
>         ServiceData Value: 0x08
>
> Currently the data is not stored persistently since it may change over
> time, but it should be relatively easy to change that in case we want to
> persist the information over restart/reboot.
>
> Luiz Augusto von Dentz (13):
>   doc/device-api: Add ServiceData and ManufacturerData
>   shared/ad: Add bt_ad_foreach_manufacturer_data
>   shared/ad: Add bt_ad_has_manufacturer_data
>   core/dbus-common: Add dict helpers for basic keys
>   core: Add implementation of ManufacturerData
>   client: Fix no handling dict properly
>   client: Make command info print ManufacturerData
>   shared/ad: Add bt_ad_foreach_service_data
>   shared/ad: Add bt_ad_has_service_data
>   core: Add implementation of ServiceData
>   client: Make command info print ServiceData
>   core/eir: Fix service data parsing
>   core/adapter: Create device even if not-connectable
>
>  client/main.c      |  12 ++++-
>  doc/device-api.txt |  11 +++++
>  src/adapter.c      |  17 +++++--
>  src/dbus-common.c  |  27 ++++++++---
>  src/dbus-common.h  |   5 ++
>  src/device.c       | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |   2 +
>  src/eir.c          |   4 ++
>  src/shared/ad.c    | 120 ++++++++++++++++++++++++++++++++++++----------
>  src/shared/ad.h    |  26 ++++++++++
>  10 files changed, 322 insertions(+), 39 deletions(-)
>
> --
> 2.1.0

Pushed.


-- 
Luiz Augusto von Dentz
