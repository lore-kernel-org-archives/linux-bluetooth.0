Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2014 09:39:30 +0200
From: Johan Hedberg <johan.hedberg@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach: bcm43xx: Use final baudrate to download the
 firmware
Message-ID: <20141031073930.GA18888@t440s.P-661HNU-F1>
References: <1413990529-1628-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413990529-1628-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Wed, Oct 22, 2014, Loic Poulain wrote:
> Speed up bcm43xx init by setting the final baudrate before firmware
> download.
> ---
>  tools/hciattach.c         |  2 +-
>  tools/hciattach.h         |  3 ++-
>  tools/hciattach_bcm43xx.c | 63 +++++++++++++++++++++++++++++------------------
>  3 files changed, 42 insertions(+), 26 deletions(-)

Applied. Thanks.

Johan
