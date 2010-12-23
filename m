Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 10:27:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add a way to retrieve ATT primary services
Message-ID: <20101223082710.GB15764@jh-x301>
References: <20101222225258.GE10702@jh-x301>
 <1293063673-25058-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293063673-25058-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Dec 22, 2010, Vinicius Costa Gomes wrote:
> As the primary services were discovered by the core bluetoothd, we need
> a way to export that information.
> 
> The service discovery uses the same primary list as the device, there's no
> need to free that list when the discovery finishes. That list will be removed
> when the device is free'd.
> ---
>  src/adapter.c     |    6 +++---
>  src/device.c      |   15 +++++++++++++++
>  src/device.h      |    3 +++
>  src/glib-helper.c |    1 -
>  4 files changed, 21 insertions(+), 4 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
