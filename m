Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 12:54:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/4] Cleanup browse_req
Message-ID: <20120209105427.GF5330@x220.ger.corp.intel.com>
References: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Feb 08, 2012, Andre Guedes wrote:
> Hi all,
> 
> This patch series does some cleanup in struct browse_req. This series
> depends on the last series I just sent to the ML.
> 
> BR,
> 
> Andre
> 
> Andre Guedes (4):
>   device: Use att_io in device_browse_primary
>   device: Remove unused function parameter
>   device: Move GAttrib reference to device
>   device: Remove unused fields from browse_req
> 
>  src/device.c |   54 +++++++++++++++++++++---------------------------------
>  1 files changed, 21 insertions(+), 33 deletions(-)

Applied. Thanks.

Johan
