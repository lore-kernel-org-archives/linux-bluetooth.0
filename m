Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 13:05:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/8] Scan Parameters Plugin
Message-ID: <20120928100553.GA23456@x220>
References: <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348586802-32613-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 25, 2012, Claudio Takahasi wrote:
> This patch series implements a new GATT based service/plugin for Scan
> Parameters: Optional service for HID devices.
> 
> This service enables a GATT Client to store the LE scan parameters on
> a GATT Server device, allowing the GATT Server to use this information
> to adjust the scanning settings to optimize power consumption and/or
> reconnection latency.
> 
> v1 changes: Using new profile abstraction (replaces btd_device drivers)
> v2 changes: Add profile parameter to device probe function
> 
> Claudio Takahasi (8):
>   scan: Add plugin skeleton
>   scan: Register profile
>   scan: Add ATTIO callbacks registration
>   scan: Add write scan interval window
>   scan: Enable Scan Refresh notification
>   scan: Register notification handler
>   scan: Write parameters when requested
>   scan: Avoid discover if scan handle is known
> 
>  Makefile.am                  |   8 +-
>  profiles/scanparam/main.c    |  55 +++++++++
>  profiles/scanparam/manager.c |  92 +++++++++++++++
>  profiles/scanparam/manager.h |  26 ++++
>  profiles/scanparam/scan.c    | 274 +++++++++++++++++++++++++++++++++++++++++++
>  profiles/scanparam/scan.h    |  26 ++++
>  6 files changed, 479 insertions(+), 2 deletions(-)
>  create mode 100644 profiles/scanparam/main.c
>  create mode 100644 profiles/scanparam/manager.c
>  create mode 100644 profiles/scanparam/manager.h
>  create mode 100644 profiles/scanparam/scan.c
>  create mode 100644 profiles/scanparam/scan.h

All patches in this set have been applied. Thanks.

Johan
