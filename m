Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 12:55:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gatt: Remove offset parameter from gatt_read_char
Message-ID: <20121001095553.GB2423@x220.ger.corp.intel.com>
References: <1348864484-30206-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348864484-30206-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Fri, Sep 28, 2012, Jefferson Delfes wrote:
> The Core spec allows to implement Read Long Characteristic Value as a
> Read Request, followed by zero or more Read Blob Requests, therefore the
> offset parameter is unnecessary and is always 0 for normal use.
> ---
>  attrib/client.c                    | 12 ++++++------
>  attrib/gatt.c                      | 15 ++++-----------
>  attrib/gatt.h                      |  4 ++--
>  attrib/gatttool.c                  |  5 +----
>  attrib/interactive.c               | 16 ++--------------
>  profiles/deviceinfo/deviceinfo.c   |  2 +-
>  profiles/heartrate/heartrate.c     |  2 +-
>  profiles/input/hog_device.c        | 12 ++++++------
>  profiles/proximity/monitor.c       |  4 ++--
>  profiles/thermometer/thermometer.c |  8 ++++----
>  10 files changed, 29 insertions(+), 51 deletions(-)

Applied. Thanks.

Johan
