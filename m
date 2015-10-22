Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v4 3/3] Bluetooth: Make hci_disconnect() behave correctly for all states
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445500179-5316-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 22 Oct 2015 11:38:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6D501364-2508-40A7-A4F2-CA9E30E50C6B@holtmann.org>
References: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com> <1445500179-5316-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are a few places that don't explicitly check the connection
> state before calling hci_disconnect(). To make this API do the right
> thing take advantage of the new hci_abort_conn() API and also make
> sure to only read the clock offset if we're really connected.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

