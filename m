Return-Path: <cyrus@holtmann.org>
Date: Sun, 9 Mar 2014 21:42:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for handling signature resolving
 keys
Message-ID: <20140309194232.GA26670@localhost.P-661HNU-F1>
References: <1394392757-49734-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394392757-49734-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 09, 2014, Marcel Holtmann wrote:
> The connection signature resolving key (CSRK) is used for attribute
> protocol signed write procedures. This change generates a new local
> key during pairing and requests the peer key as well.
> 
> Newly generated key and received key will be provided to userspace
> using the New Signature Resolving Key management event.
> 
> The Master CSRK can be used for verification of remote signed write
> PDUs and the Slave CSRK can be used for sending signed write PDUs
> to the remote device.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  8 +++++
>  include/net/bluetooth/mgmt.h     | 12 +++++++
>  net/bluetooth/mgmt.c             | 30 ++++++++++++++++++
>  net/bluetooth/smp.c              | 67 +++++++++++++++++++++++++++++++++++++---
>  net/bluetooth/smp.h              |  2 ++
>  5 files changed, 114 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
