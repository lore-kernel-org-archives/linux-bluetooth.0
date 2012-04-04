Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
References: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
Date: Wed, 4 Apr 2012 07:54:56 -0400
Message-ID: <CAJdJm_PS=7=aOJDt29Qi9R=LZteGUE4czi4ux32a7tZS2hkjPQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add DeviceInformationService plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Apr 4, 2012 at 4:28 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Add Device Information Service GATT Client for reading peer
> device PNP_ID and store it.
>
> Chen Ganir (4):
>  Add DeviceInformation GATT Client
>  DeviceInfo: Add connection logic
>  DeviceInfo: Discover Characteristics
>  DeviceInfo: Read PNP ID
>
>  Makefile.am             |    8 ++-
>  deviceinfo/deviceinfo.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++
>  deviceinfo/deviceinfo.h |   24 ++++++
>  deviceinfo/main.c       |   52 +++++++++++++
>  deviceinfo/manager.c    |   82 ++++++++++++++++++++
>  deviceinfo/manager.h    |   24 ++++++
>  doc/device-api.txt      |    4 +
>  src/device.c            |   34 ++++++++
>  src/device.h            |    4 +
>  9 files changed, 423 insertions(+), 2 deletions(-)
>  create mode 100644 deviceinfo/deviceinfo.c
>  create mode 100644 deviceinfo/deviceinfo.h
>  create mode 100644 deviceinfo/main.c
>  create mode 100644 deviceinfo/manager.c
>  create mode 100644 deviceinfo/manager.h

Looks good to me.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
