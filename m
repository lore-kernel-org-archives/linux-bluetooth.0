Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2014 15:40:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Send HCI_Read_Clock_Offset before
 disconnecting
Message-ID: <20140627124002.GA1755@t440s.lan>
References: <1403872336-46436-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403872336-46436-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jun 27, 2014, Marcel Holtmann wrote:
> When the connection is in master role and it is going to be
> disconnected based on the disconnection timeout, then send
> the HCI_Read_Clock_Offset command in an attempt to update the
> clock offset value in the inquiry cache.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |  5 +++++
>  net/bluetooth/hci_conn.c    | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+)

Applied (with push --force) to bluetooth-next. Thanks.

Johan
