Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 23:59:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: Refactor hci_disconn_complete_evt
Message-ID: <20131107215907.GB10164@x220.p-661hnu-f1>
References: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
 <1383856570-30480-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383856570-30480-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Nov 07, 2013, Andre Guedes wrote:
> hci_disconn_complete_evt() logic is more complicated than what it
> should be, making it hard to follow and add new features.
> 
> So this patch does some code refactoring by handling the error cases
> in the beginning of the function and by moving the main flow into the
> first level of function scope. No change is done in the event handling
> logic itself.
> 
> Besides organizing this messy code, this patch makes easier to add
> code for handling LE auto connection (which will be added in a further
> patch).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
