Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 17 Apr 2013 10:22:33 +0200
Message-ID: <CANT-zCXQAOL+2_Jq0QoCZH78D3qpANMGEmczHhMSU_UvFfaaxw@mail.gmail.com>
Subject: Re: [RFC v2 00/11] struct btd_service in core
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 5, 2013 at 1:45 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> v1 does not apply anymore so I'm sending an updated version of the patchset.
>
> v2 is similar to the pervious version but with minor changes in patch 1 as pointed out by Johan and Anderson. Besides, patch 11 has been updated to the latest changes in profiles/audio.
>
> From original cover-letter:
>
> This RFC proposes a somewhat intrusive change in the core with the adoption of struct btd_service, with the following main goals:
>
> 1. Support for multiple instances of the same UUID.
> 2. Better support for connection-handling plugins/components (e.g. automotive).
> 3. Exposure of remote services in D-Bus (not implemented here).
> 4. Improve code readability and reduce profile-implementation code size.
>
> Mikel Astiz (11):
>   core: Add btd_service to represent device services
>   device: Use btd_service to represent profiles
>   device: Replace connected_profiles with btd_service
>   device: Find services instead of profiles
>   device: Replace pending profile list with services
>   profile: Use btd_service for probing profiles
>   audio: Hold a reference to btd_service
>   network: Hold a reference to btd_service
>   input: Hold a reference to btd_service
>   service: Add callbacks to track state changes
>   profile: Use btd_service for connect/disconnect
>
>  Makefile.am                          |   1 +
>  Makefile.plugins                     |   4 +-
>  profiles/audio/avrcp.c               |  16 +--
>  profiles/audio/control.c             |  48 ++++++-
>  profiles/audio/control.h             |  12 +-
>  profiles/audio/manager.c             |  88 ++++--------
>  profiles/audio/manager.h             |   9 --
>  profiles/audio/sink.c                |  24 ++--
>  profiles/audio/sink.h                |   4 +-
>  profiles/audio/source.c              |  25 ++--
>  profiles/audio/source.h              |   5 +-
>  profiles/cyclingspeed/cyclingspeed.c |   9 +-
>  profiles/deviceinfo/deviceinfo.c     |  11 +-
>  profiles/gatt/gas.c                  |  10 +-
>  profiles/health/hdp_manager.c        |  10 +-
>  profiles/heartrate/heartrate.c       |  10 +-
>  profiles/input/device.c              |  95 +++++++------
>  profiles/input/device.h              |  13 +-
>  profiles/input/hog.c                 |   8 +-
>  profiles/input/manager.c             |  51 +------
>  profiles/input/manager.h             |  25 ----
>  profiles/network/connection.c        |  77 ++++++-----
>  profiles/network/connection.h        |   8 +-
>  profiles/network/manager.c           | 123 ++---------------
>  profiles/network/manager.h           |  25 ----
>  profiles/proximity/manager.c         |  28 ++--
>  profiles/proximity/reporter.c        |   8 +-
>  profiles/proximity/reporter.h        |   5 +-
>  profiles/sap/manager.c               |   1 +
>  profiles/scanparam/scan.c            |   9 +-
>  profiles/thermometer/thermometer.c   |  11 +-
>  src/device.c                         | 242 +++++++++++++++++++++-----------
>  src/device.h                         |   5 -
>  src/profile.c                        |  40 ++++--
>  src/profile.h                        |  14 +-
>  src/service.c                        | 260 +++++++++++++++++++++++++++++++++++
>  src/service.h                        |  61 ++++++++
>  37 files changed, 825 insertions(+), 570 deletions(-)
>  delete mode 100644 profiles/input/manager.h
>  delete mode 100644 profiles/network/manager.h
>  create mode 100644 src/service.c
>  create mode 100644 src/service.h
>
> --
> 1.8.1.4
>

Ping.

Cheers,
Mikel
