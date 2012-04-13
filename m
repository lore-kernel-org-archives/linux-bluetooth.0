Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 18:59:51 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v0 1/6] Bluetooth: Use unsigned int instead of signed int
Message-ID: <20120413215950.GC1680@joana>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1334126932-27327-2-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334126932-27327-2-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

* Mikel Astiz <mikel.astiz.oss@gmail.com> [2012-04-11 08:48:47 +0200]:

> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The involved values are all unsigned and thus unsigned int should be
> used instead of signed int. Assigning ~0 to a signed int results in -1,
> which is confusing and error-prone, while the code is trying to set the
> maximum value possible.
> 
> The code still works because the C standard defines that unsigned
> comparison will be performed in these cases, when comparing an unsigned
> int and a signed int.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next thanks.

	Gustavo
