Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 20:43:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] core: add D-Bus property for ServiceData
Message-ID: <20141208184310.GC16755@t440s.ger.corp.intel.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
 <1411599462-8680-3-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411599462-8680-3-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Sep 24, 2014, Scott James Remnant wrote:
> Since the standard doesn't make any specific requirement that a UUID
> present in a Service Data field be also present in a specific UUIDs
> field, the UUIDs are also added to that list as well.
> ---
>  doc/device-api.txt |  9 ++++++
>  src/adapter.c      |  1 +
>  src/device.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |  1 +
>  src/eir.c          | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  src/eir.h          | 11 +++++++
>  6 files changed, 179 insertions(+)

This too looks fine, but the documentation and EIR parsing parts should
be split into their own patches.

Johan
