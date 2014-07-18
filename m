Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Use EOPNOTSUPP instead of ENOTSUPP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405671326-32431-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 18 Jul 2014 11:22:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <20C90689-7821-44A4-96D6-9E5C45452492@holtmann.org>
References: <1405671326-32431-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The EOPNOTSUPP and ENOTSUPP errors are very similar in meaning, but
> ENOTSUPP is a fairly new addition to POSIX. Not all libc versions know
> about the value the kernel uses for ENOTSUPP so it's better to use
> EOPNOTSUPP to ensure understandable error messages.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c   | 2 +-
> net/bluetooth/l2cap_core.c | 2 +-
> net/bluetooth/l2cap_sock.c | 2 +-
> net/bluetooth/smp.c        | 4 ++--
> 4 files changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

