Return-Path: <cyrus@holtmann.org>
Date: Sat, 11 Jan 2014 18:56:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/11] attrib: Modify gatt_cb_t signature
Message-ID: <20140111165648.GA5063@x220.p-661hnu-f1>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Jan 11, 2014, Anderson Lizardo wrote:
> Use standard C types instead of GLib ones (which are unnecessary here)
> and move the "status" parameter to the first position, so it is
> consistent with other callbacks.
> ---
>  attrib/gatt.c                        | 10 +++++-----
>  attrib/gatt.h                        |  2 +-
>  attrib/gatttool.c                    |  9 ++++-----
>  attrib/interactive.c                 |  9 ++++-----
>  profiles/cyclingspeed/cyclingspeed.c |  2 +-
>  profiles/deviceinfo/deviceinfo.c     |  4 ++--
>  profiles/gatt/gas.c                  |  4 ++--
>  profiles/heartrate/heartrate.c       |  2 +-
>  profiles/input/hog.c                 |  6 +++---
>  profiles/proximity/monitor.c         | 12 ++++++------
>  profiles/scanparam/scan.c            |  7 +++----
>  profiles/thermometer/thermometer.c   |  4 ++--
>  src/device.c                         |  5 ++---
>  13 files changed, 36 insertions(+), 40 deletions(-)

All patches in this set have been applied. Thanks.

Johan
