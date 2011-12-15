Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:33:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] gobex: fix transfer search in transfer_complete
Message-ID: <20111215113328.GA6824@x220>
References: <1323793282-24497-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323793282-24497-1-git-send-email-mikel.astiz@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Dec 13, 2011, Mikel Astiz wrote:
> The previous approach searched the transfer pointer itself, assuming
> that the transfers has not been modified if the pointer is in the list.
> However the callback could have removed the transfer and registered
> another one, which can eventually point to the same memory location.
> 
> This is solved by looking for the transfer id instead of the pointer.
> ---
>  gobex/gobex-transfer.c |   30 +++++++++++++++++++-----------
>  1 files changed, 19 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan
