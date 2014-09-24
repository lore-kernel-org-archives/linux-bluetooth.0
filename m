Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Sep 2014 11:08:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/9] shared/gatt-client: Handle "Service Changed"
Message-ID: <20140924080812.GB14486@t440s.ger.corp.intel.com>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Sep 23, 2014, Arman Uguray wrote:
> This patch set adds handling for indications from the "Service Changed"
> characteristic. gatt-client automatically caches the value handle of the Service
> Changed characteristic and listens to indications from it, if the characteristic
> exists. When an indication is received, services within the modified range are
> automatically re-discovered and gatt-client's internal service cache gets
> updated. Upper layers can register a callback, which then gets invoked to notify
> them of modifications to the service cache.
> 
> Arman Uguray (9):
>   shared/gatt-helpers: Allow service discovery by handle range.
>   shared/gatt-client: Make service discovery more modular.
>   shared/gatt-client: Register "Service Changed" handler as part of
>     init.
>   shared/gatt-client: Remove effected services from cache on Service
>     Changed.
>   shared/gatt-client: Rediscover services within changed range.
>   shared/gatt-client: Add handler for "Service Changed" if GATT service
>     changes.
>   shared/gatt-client: Add bt_gatt_client_set_service_changed.
>   tools/btgatt-client: Set service changed handler.
>   TODO: shared/gatt-client now handles Service Changed
> 
>  TODO                      |   7 -
>  src/shared/gatt-client.c  | 590 +++++++++++++++++++++++++++++++++++++++-------
>  src/shared/gatt-client.h  |   7 +
>  src/shared/gatt-helpers.c |  40 +++-
>  src/shared/gatt-helpers.h |   5 +
>  tools/btgatt-client.c     |  34 +++
>  6 files changed, 585 insertions(+), 98 deletions(-)

All patches in this set have been applied. Thanks.

Johan
