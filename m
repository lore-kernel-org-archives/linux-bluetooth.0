Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 11:00:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0] network: Remove unnecessary field from connect_req
Message-ID: <20121026080047.GA20213@x220>
References: <1351230929-4484-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351230929-4484-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Oct 26, 2012, Mikel Astiz wrote:
> The device pointer in struct connect_req can be completely removed since
> the callback already receives such pointer, and the network_peer takes
> care of the device refcounting.
> ---
>  profiles/network/manager.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied. Thanks.

Johan
