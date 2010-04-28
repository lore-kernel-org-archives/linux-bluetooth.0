Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 23:00:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update service class on adapter-by-adapter basis
Message-ID: <20100428200031.GA24732@jh-x301>
References: <1272484066-19133-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272484066-19133-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 28, 2010, Elvis Pfutzenreuter wrote:
> When a service is added (or removed) for a specific adapter,
> only the service class of that specific adapter shall be updated.
> ---
>  src/adapter.c      |    5 +++++
>  src/adapter.h      |    2 ++
>  src/manager.c      |   16 ++--------------
>  src/manager.h      |    2 +-
>  src/sdpd-service.c |   27 +++++++++++++++++----------
>  src/sdpd.h         |    1 -
>  6 files changed, 27 insertions(+), 26 deletions(-)

Thanks for the quick response! The patch is now pushed upstream.

Johan
