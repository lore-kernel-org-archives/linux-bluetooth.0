Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 19:01:49 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 2/6] Bluetooth: Remove unnecessary check
Message-ID: <20120413220149.GD1680@joana>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1334126932-27327-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334126932-27327-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

* Mikel Astiz <mikel.astiz.oss@gmail.com> [2012-04-11 08:48:48 +0200]:

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The function already fails if the given size is greater than the MTU, so
> there is no need to consider that case afterwards.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  net/bluetooth/sco.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Applied to bluetooth-next, thanks.

	Gustavo
