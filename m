Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 20:39:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] core: add D-Bus property for TxPower
Message-ID: <20141208183951.GA16755@t440s.ger.corp.intel.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411599462-8680-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Sep 24, 2014, Scott James Remnant wrote:
> This is presented as a raw property rather than a parsed "PathLoss"
> property because in the case of many devices, this specific field will
> not be present and instead the TX power will have to be parsed from
> manufacturer-specific data anyway.
> 
> It's better therefore to document the Path Loss equation rather than
> hide it.
> ---
>  doc/device-api.txt | 12 ++++++++++++
>  src/adapter.c      |  6 ++++--
>  src/device.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  src/device.h       |  1 +
>  4 files changed, 58 insertions(+), 2 deletions(-)

I don't have any particular objections to this patch except that the
API documentation should be in a separate patch.

Johan
