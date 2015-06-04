Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Jun 2015 10:04:04 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: vhci: Clean up coding style fix
Message-ID: <20150604030404.GA17476@t440s>
References: <20150602105003.GA2880@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150602105003.GA2880@ubuntu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

On Tue, Jun 02, 2015, Mutharaju, Prasanna (P.) wrote:
> From : Prasanna Karthik <mkarthi3@visteon.com>
> 
> fix spaces required around that '=' reported by checkpatch
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
>  drivers/bluetooth/hci_vhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to bluetooth-next. Thanks.

Btw, I had to manually fix-up the author name for the patch since your
patch was incorrectly formatted. Please use git format-patch/send-email
in the future.

Johan
