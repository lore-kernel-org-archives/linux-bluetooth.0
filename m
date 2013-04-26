Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Apr 2013 14:50:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH BlueZ v5 0/3] struct btd_service in core
Message-ID: <20130426115007.GA22715@x220.ger.corp.intel.com>
References: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Apr 26, 2013, Mikel Astiz wrote:
> v5 updated as suggested by Johan:
> - Fixed memory leak in v4 2/3.
> - Static variables initialized.
> - Avoid dependencies to GLib types.
> 
> Mikel Astiz (3):
>   service: Add error-code btd_service
>   service: Add callbacks to track state changes
>   profile: Use btd_service for connect/disconnect
> 
>  Makefile.plugins              |  4 +--
>  profiles/audio/control.c      | 20 +++--------
>  profiles/audio/manager.c      | 44 +++++++-----------------
>  profiles/audio/manager.h      |  5 ---
>  profiles/audio/sink.c         | 18 +++++-----
>  profiles/audio/source.c       | 18 +++++-----
>  profiles/input/device.c       | 21 +++++-------
>  profiles/input/device.h       |  5 ++-
>  profiles/input/manager.c      | 11 ------
>  profiles/input/manager.h      | 25 --------------
>  profiles/network/connection.c | 39 ++++++---------------
>  profiles/network/connection.h |  4 +--
>  profiles/network/manager.c    | 79 ++++---------------------------------------
>  profiles/network/manager.h    | 25 --------------
>  src/device.c                  | 33 +++++++++++-------
>  src/device.h                  |  7 ----
>  src/profile.c                 | 29 ++++++++++------
>  src/profile.h                 |  6 ++--
>  src/service.c                 | 58 +++++++++++++++++++++++++++++--
>  src/service.h                 |  9 +++++
>  20 files changed, 171 insertions(+), 289 deletions(-)
>  delete mode 100644 profiles/input/manager.h
>  delete mode 100644 profiles/network/manager.h

All patches have been applied (after a quick s/unsigned/unsigned int/
change on patch 2/3). Thanks.

Johan
