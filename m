Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Oct 2012 13:42:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH] device: Fix modifying list while iterating
Message-ID: <20121017104236.GA12356@x220.ger.corp.intel.com>
References: <1350468429-30882-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350468429-30882-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Oct 17, 2012, Mikel Astiz wrote:
> A list should not be modified while iterating on it, and in this case
> the solution is trivial: the code is just trying to free the whole list
> with a previous call to profile->device_remove() per list item.
> ---
>  src/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
