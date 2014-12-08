Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 20:41:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] core: add D-Bus property for ManufacturerData
Message-ID: <20141208184151.GB16755@t440s.ger.corp.intel.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
 <1411599462-8680-2-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411599462-8680-2-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Sep 24, 2014, Scott James Remnant wrote:
> ---
>  doc/device-api.txt | 10 +++++++
>  src/adapter.c      |  1 +
>  src/device.c       | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |  2 ++
>  src/eir.c          | 30 ++++++++++++++++++++
>  src/eir.h          | 10 +++++++
>  6 files changed, 135 insertions(+)

The D-Bus property part of this patch looks ok'ish, however we've
already got manufacturer data parsing upstream so that needs to be
removed (and the rest adapted to the upstream API for this). The D-Bus
documentation should also be split to a separate patch.

Johan
