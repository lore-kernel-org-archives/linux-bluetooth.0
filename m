Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332765928-6251-4-git-send-email-chen.ganir@ti.com>
References: <1332765928-6251-1-git-send-email-chen.ganir@ti.com>
	<1332765928-6251-4-git-send-email-chen.ganir@ti.com>
Date: Mon, 26 Mar 2012 10:29:29 -0400
Message-ID: <CAJdJm_OA0x2pZG4OsUwCd0s+tBzyfzQf-U4Ws6Qc__uwXXLK-A@mail.gmail.com>
Subject: Re: [PATCH 3/5] DeviceInfo: Discover Characteristics
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Mar 26, 2012 at 8:45 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Add logic to discover all characteristics and build a
> characteristic list.
> ---
>  deviceinfo/deviceinfo.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++-
>  deviceinfo/deviceinfo.h |    2 +-
>  deviceinfo/manager.c    |    5 +++-
>  3 files changed, 71 insertions(+), 3 deletions(-)

This patch introduces a build failure:

deviceinfo/deviceinfo.c: In function ‘configure_deviceinfo_cb’:
deviceinfo/deviceinfo.c:108:19: error: variable ‘end’ set but not used
[-Werror=unused-but-set-variable]
cc1: all warnings being treated as errors

Please make sure every patch on the series is buildable (when applied
on order). In this case, you should introduce the variable only on the
commit where it is used.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
