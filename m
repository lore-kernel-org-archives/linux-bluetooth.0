Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 12:41:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Remove unused code from device_browse_sdp()
Message-ID: <20130215104115.GB15390@x220>
References: <1360024356-6838-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360024356-6838-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Feb 04, 2013, Anderson Lizardo wrote:
> The "search" parameter was always NULL, and therefore code depending on
> it being non-NULL will never be reached.
> ---
>  src/device.c |   23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Applied. Thanks.

Johan
