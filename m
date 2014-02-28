Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 09:45:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Use __le64 type for LE random numbers
Message-ID: <20140228074508.GA724@localhost.P-661HNU-F1>
References: <1393545628-29566-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393545628-29566-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 27, 2014, Marcel Holtmann wrote:
> The random numbers in Bluetooth Low Energy are 64-bit numbers and should
> also be little endian since the HCI specification is little endian.
> 
> Change the whole Low Energy pairing to use __le64 instead of a byte
> array.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  4 ++--
>  include/net/bluetooth/hci_core.h |  8 ++++----
>  include/net/bluetooth/mgmt.h     |  2 +-
>  net/bluetooth/hci_conn.c         |  6 +++---
>  net/bluetooth/hci_core.c         | 13 ++++++-------
>  net/bluetooth/hci_event.c        |  2 +-
>  net/bluetooth/mgmt.c             |  2 +-
>  net/bluetooth/smp.c              | 22 ++++++++++------------
>  net/bluetooth/smp.h              |  2 +-
>  9 files changed, 29 insertions(+), 32 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
