Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332765928-6251-1-git-send-email-chen.ganir@ti.com>
References: <1332765928-6251-1-git-send-email-chen.ganir@ti.com>
Date: Mon, 26 Mar 2012 11:09:56 -0400
Message-ID: <CAJdJm_O1yiniHrn3kZNSPCdY=SMuX_FNuf66QJCCYqv9wLjHAg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add DeviceInformationService plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Mar 26, 2012 at 8:45 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Add Device Information Service GATT Client for reading peer
> device PNP_ID and store it.
>
> Chen Ganir (5):
>  Add DeviceInformation GATT Client
>  DeviceInfo: Add connection logic
>  DeviceInfo: Discover Characteristics
>  Fix device version in GetProperties
>  DeviceInfo: Read PNP ID
>
>  Makefile.am             |    9 ++-
>  deviceinfo/deviceinfo.c |  218 +++++++++++++++++++++++++++++++++++++++++++++++
>  deviceinfo/deviceinfo.h |   24 +++++
>  deviceinfo/main.c       |   55 ++++++++++++
>  deviceinfo/manager.c    |   82 ++++++++++++++++++
>  deviceinfo/manager.h    |   24 +++++
>  src/device.c            |   35 +++++++-
>  src/device.h            |    3 +
>  8 files changed, 446 insertions(+), 4 deletions(-)
>  create mode 100644 deviceinfo/deviceinfo.c
>  create mode 100644 deviceinfo/deviceinfo.h
>  create mode 100644 deviceinfo/main.c
>  create mode 100644 deviceinfo/manager.c
>  create mode 100644 deviceinfo/manager.h

Except for the build error, I see no other issues on the GATT part of
these patches. Someone else needs to review/comment on the part
touching src/device.c though (maybe Johan himself?)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
