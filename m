Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 11:52:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove MGMT_ADDR_INVALID macro
Message-ID: <20120405085238.GA29038@x220>
References: <1333453614-4954-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333453614-4954-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 03, 2012, Andre Guedes wrote:
> This patch removes the MGMT_ADDR_INVALID macro. If the address type
> isn't LE, we consider it is BR/EDR type.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/mgmt.c             |   14 +++++++-------
>  2 files changed, 7 insertions(+), 8 deletions(-)

Applied to the bluetooth-next tree. Thanks.

Johan
