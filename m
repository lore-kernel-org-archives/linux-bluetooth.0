Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
Date: Wed, 22 Oct 2014 08:25:06 +0200
Message-ID: <CABD6X-+URkwy0eEVMoUusc3ymFb6fdnFZ0z+jfPdVNq+ibXRQQ@mail.gmail.com>
Subject: Re: [PATCHv5 00/14] Included service discovery
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16 October 2014 12:17, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> v3:
> In this version after primary service discovery,
> secondary services are discovered. Next included
> services are resolved. With this approach we
> don't have recursively search for included service,
> like it was TODO in previous proposal.
> There is also small coding style fix suggested by Arman.
>
> v4:
> If no secondary services found, continue include services search (fixed
> in gatt-client.c).
> Fixed wrong debug logs (primary->secondary).
> Fixed searching descriptors
>
> v5:
> Ignore Unsupported Group Type Error in response to secondary service
> discovery and continue included services discovery.
>
> Marcin Kraglak (14):
>   shared/gatt: Add discover_secondary_services()
>   shared/gatt: Add initial implementation of discover_included_services
>   shared/gatt: Discover included services 128 bit UUIDS
>   shared/gatt: Add extra check in characteristic iterator
>   shared/gatt: Add included service iterator
>   shared/gatt: Remove not needed function parameter
>   shared/gatt: Distinguish Primary from Secondary services
>   tools/btgatt-client: Print type of service
>   shared/gatt: Discover secondary services
>   shared/gatt: Discover included services
>   shared/gatt: Add gatt-client include service iterator
>   tools/btgatt-client: Print found include services
>   shared/gatt: Fix searching descriptors
>   shared/gatt: Add function bt_gatt_result_included_count()
>
>  src/shared/gatt-client.c  | 263 +++++++++++++++++++++++++++--
>  src/shared/gatt-client.h  |  18 ++
>  src/shared/gatt-helpers.c | 418 +++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/gatt-helpers.h |  10 +-
>  tools/btgatt-client.c     |  17 +-
>  5 files changed, 690 insertions(+), 36 deletions(-)
>
> --
> 1.9.3
>

Ping
