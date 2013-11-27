Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 11:34:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] sixaxis support
Message-ID: <20131127093415.GA29451@x220.p-661hnu-f1>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 25, 2013, Szymon Janc wrote:
> Hi All,
> 
> This is yet another attempt to get PS3 controller support into BlueZ upstream.
> 
> I based my work on Fedora out-of-tree patch (hence copyright info) and tried
> to take into consideration comments from previous upstreaming attempt.
> 
> I find sixaxis name short and neat so I sticked with it.
> 
> I didn't really like the idea of hardcoding SDP records so I took different
> approach of doing reverse SDP search while cable associated device first
> connects. This is done before authorizing incoming HID connection.
> 
> Some functions unavailable to exteral plugins were renamed with btd_ prefix
> (or explicitly marked in bletooth.ver) to export them (patch 1-8).
> 
> Patch 9-10 add sixaxis external plugin that depends on udev. This plugin is
> responsible for preparing newly USB connected PS3 sixaxis device and creating
> btd_device with proper PNP information.
> 
> Patch 12 adds support for handling first connection of sixaxis device in input
> plugin itself. This is something I would like to get comments and suggestions.
> Currently this is rather sixaxis oriented, but could be made more generic (some
> hooks registration) if desired.
> 
> This serie is not implemententing any LED (or other features) setting support.
> I have an impression that those should not be handled by BlueZ but some other
> entity (util tools or driver itself perhabs?) as this is not related to
> transport itself and should be set/used on USB connection as well.
> 
> This was tested with Dualshock3 and seems to be working nicely here.
> 
> Comments are welcome.
> 
> -- 
> BR
> Szymon Janc
> 
> Szymon Janc (13):
>   core: Export some symbols from libbluetooth
>   Rename adapter_get_device to btd_adapter_get_device
>   Rename device_set_temporary to btd_device_set_temporary
>   Rename device_set_trusted to btd_device_set_trusted
>   Rename device_device_set_name to btd_device_device_set_name
>   Rename device_get_uuids to btd_device_get_uuids
>   Rename adapter_get_address to btd_adapter_get_address
>   Rename adapter_find_device to btd_adapter_find_device
>   plugins: Add initial code for sixaxis plugin
>   plugins/sixaxis: Add initial code for udev handling
>   plugins/sixaxis: Add support for configuring new controllers
>   device: Add device_discover_services function
>   input: Add support for handling sixaxis devices
> 
>  Makefile.plugins              |   8 ++
>  bootstrap-configure           |   1 +
>  configure.ac                  |   5 +
>  plugins/neard.c               |  10 +-
>  plugins/sixaxis.c             | 286 ++++++++++++++++++++++++++++++++++++++++++
>  plugins/wiimote.c             |   2 +-
>  profiles/audio/avctp.c        |  18 +--
>  profiles/audio/avdtp.c        |  11 +-
>  profiles/health/hdp.c         |  10 +-
>  profiles/health/hdp_util.c    |   6 +-
>  profiles/input/device.c       |   4 +-
>  profiles/input/manager.c      |   4 +-
>  profiles/input/server.c       | 104 ++++++++++++++-
>  profiles/network/connection.c |   2 +-
>  profiles/network/server.c     |   4 +-
>  profiles/sap/server.c         |   3 +-
>  src/adapter.c                 |  74 ++++++-----
>  src/adapter.h                 |   6 +-
>  src/attrib-server.c           |   6 +-
>  src/bluetooth.ver             |   2 +
>  src/device.c                  |  70 +++++++----
>  src/device.h                  |  10 +-
>  src/profile.c                 |  14 +--
>  23 files changed, 551 insertions(+), 109 deletions(-)
>  create mode 100644 plugins/sixaxis.c

This looked good enough to me, so all patches have been applied. Thanks.

I did apply one small patch on top of this though to make the include
statements consistent with the direction we're trying to push the tree
in.

Johan
