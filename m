Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:27:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Process num completed data blocks event
Message-ID: <20120108202749.GC16731@x220.P-661HNU-F1>
References: <1325673718-18915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325673718-18915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 04, 2012, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds support for Number Of Completed Data Blocks Event.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |   13 ++++++++++
>  net/bluetooth/hci_event.c   |   54 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 0 deletions(-)

The patch has been applied to my bluetooth-next tree. Thanks.

Johan
