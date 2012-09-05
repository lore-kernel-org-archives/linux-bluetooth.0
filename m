Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 12:33:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v4 00/18] Unaligned memory access fixes
Message-ID: <20120905093321.GB25573@x220>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Sep 04, 2012, Szymon Janc wrote:
> Changes since V2:
> 
> - fixed issues pointed by Anderson
> - some other fixes, cleanups
> - proposed change to bt_get_unaligned macro (PATCH 15) to avoid offending
>   pointer cast, this allow to use this macro instead of memcpy (in places
>   where it is more clean compared to memcpy e.g. where memcpy requires
>   temporary variable) - this is not commonly used since most macro uses
>   are now replaced with helper functions.
> 
> -- 
> BR
> Szymon Janc
> 
> Szymon Janc (18):
>   Add helper functions for putting integers on unaligned memory address
>   sdp: Fix compilation errors due to unaligned memory access
>   sdp: Use bt_get_be* helpers instead of bt_get_unaligned
>   l2test: Fix compilation errors due to unaligned memory access
>   rctest: Fix compilation errors due to unaligned memory access
>   scotest: Fix compilation errors due to unaligned memory access
>   sap: Fix compilation errors due to unaligned memory access
>   adaptername: Refactor handle_inotify_cb
>   sdpd-request: Fix build errors due to unaligned memory access
>   sdpd-service: Fix build errors due to unaligned memory access
>   hciemu: Fix build errors due to unaligned memory access
>   avrcp: Fix compilation errors due to unaligned memory access
>   eir: Use bt_get_* helper functions to access unaligned memory
>   mgmt: Use bt_get_* helper functions to access unaligned memory
>   Refactor bt_get_unaligned macro
>   sap-u8500: Fix compile error due to unaligned memory access
>   monitor: Fix compilation errors due to unaligned memory access
>   sdp: Fix build error due to unaligned memory access
> 
>  attrib/att.h             |    6 +--
>  audio/avrcp.c            |   10 ++---
>  lib/bluetooth.h          |   89 +++++++++++++++++++++++++++++++++++++-------
>  lib/sdp.c                |   92 +++++++++++++++++++++++-----------------------
>  monitor/control.c        |    7 +++-
>  monitor/hcidump.c        |   21 +++++++----
>  plugins/adaptername.c    |   48 ++++++++++++------------
>  profiles/sap/sap-u8500.c |   10 +++--
>  profiles/sap/server.c    |    9 ++---
>  src/eir.c                |    6 ++-
>  src/mgmt.c               |   18 ++++-----
>  src/sdpd-request.c       |   62 ++++++++++++++++---------------
>  src/sdpd-service.c       |   21 +++++------
>  test/hciemu.c            |    6 ++-
>  test/l2test.c            |    9 +++--
>  test/rctest.c            |    5 ++-
>  test/scotest.c           |    5 ++-
>  17 files changed, 253 insertions(+), 171 deletions(-)

Patches 1-14 have been applied. Thanks.

Johan
