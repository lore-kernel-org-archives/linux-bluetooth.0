Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Oct 2012 11:39:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] adapter: Convert adapter_get_address into simple
 getter
Message-ID: <20121005083901.GA25602@x220>
References: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Oct 05, 2012, Szymon Janc wrote:
> Most uses of adapter_get_address were in form of:
> 
> bdaddr_t addr;
> adapter_get_address(adapter, &addr);
> foo(&addr);
> 
> Changing it to getter makes code simpler and avoid number of not
> needed memcpy.
> 
> ---
>  attrib/client.c              |    2 +-
>  audio/manager.c              |   48 +++++---------
>  plugins/adaptername.c        |    4 +-
>  plugins/dbusoob.c            |    8 +--
>  plugins/neard.c              |   16 ++---
>  plugins/service.c            |   57 ++++++-----------
>  plugins/wiimote.c            |    5 +-
>  profiles/alert/server.c      |    4 +-
>  profiles/gatt/gas.c          |   16 ++---
>  profiles/health/hdp.c        |   14 ++---
>  profiles/health/hdp_util.c   |   24 ++++---
>  profiles/input/device.c      |    2 +-
>  profiles/input/manager.c     |   11 +---
>  profiles/network/manager.c   |   10 +--
>  profiles/network/server.c    |    8 +--
>  profiles/proximity/monitor.c |   13 ++--
>  profiles/sap/manager.c       |    5 +-
>  src/adapter.c                |   13 ++--
>  src/adapter.h                |    2 +-
>  src/attrib-server.c          |   18 +++---
>  src/device.c                 |  143 +++++++++++++++++-------------------------
>  src/manager.c                |    5 +-
>  src/profile.c                |   28 ++++-----
>  23 files changed, 179 insertions(+), 277 deletions(-)

All patches have been applied. Thanks.

Johan
