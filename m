Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 12:50:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] device: Split att_connect_cb
Message-ID: <20120209105038.GC5330@x220.ger.corp.intel.com>
References: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Feb 08, 2012, Andre Guedes wrote:
> In order to reduce code complexity, all code related to
> device_browse_primary was moved to a new function called
> browse_primary_connect_cb. This way att_connect_cb has
> only code related to att_connect.
> ---
>  src/device.c |   48 +++++++++++++++++++++++++++++++++---------------
>  1 files changed, 33 insertions(+), 15 deletions(-)

All three patches have been applied. Thanks.

Johan
