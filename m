Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 11:08:36 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use GFP_KERNEL in hci_conn_add()
Message-ID: <20120130190836.GA31558@x220.globalsuite.net>
References: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Jan 30, 2012, Andre Guedes wrote:
> This function is called in process context only, so it should use
> GFP_KERNEL to allocate memory.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
