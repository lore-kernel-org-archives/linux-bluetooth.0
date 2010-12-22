Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 00:52:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 08/18] Add a way to retrieve ATT primary services
Message-ID: <20101222225258.GE10702@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-9-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-9-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
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

I tried to continue applying the patches starting with this one, but it
doesn't apply cleanly anymore probably due to me skipping patch 7 with
its compilation errors. So I'll once again stop processing the patch set
here.

Johan
