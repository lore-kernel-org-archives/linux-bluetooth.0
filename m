Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 15:04:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add DeviceInformationService plugin
Message-ID: <20120404120429.GA5525@x220>
References: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333528137-9305-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Apr 04, 2012, chen.ganir@ti.com wrote:
> From: Chen Ganir <chen.ganir@ti.com>
> 
> Add Device Information Service GATT Client for reading peer
> device PNP_ID and store it.
> 
> Chen Ganir (4):
>   Add DeviceInformation GATT Client
>   DeviceInfo: Add connection logic
>   DeviceInfo: Discover Characteristics
>   DeviceInfo: Read PNP ID
> 
>  Makefile.am             |    8 ++-
>  deviceinfo/deviceinfo.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++
>  deviceinfo/deviceinfo.h |   24 ++++++
>  deviceinfo/main.c       |   52 +++++++++++++
>  deviceinfo/manager.c    |   82 ++++++++++++++++++++
>  deviceinfo/manager.h    |   24 ++++++
>  doc/device-api.txt      |    4 +
>  src/device.c            |   34 ++++++++
>  src/device.h            |    4 +
>  9 files changed, 423 insertions(+), 2 deletions(-)
>  create mode 100644 deviceinfo/deviceinfo.c
>  create mode 100644 deviceinfo/deviceinfo.h
>  create mode 100644 deviceinfo/main.c
>  create mode 100644 deviceinfo/manager.c
>  create mode 100644 deviceinfo/manager.h

All four patches have been applied though I did have to fix up your
additions to device-api.txt since you weren't being consistent with the
indentation with the rest of the file.

Johan
