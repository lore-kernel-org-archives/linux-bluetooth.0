Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] Bluetooth: Fix to set proper bdaddr_type for RFCOMM connect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383639342-9972-1-git-send-email-sw0312.kim@samsung.com>
Date: Tue, 5 Nov 2013 13:07:43 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Syam Sidhardhan <s.syam@samsung.com>
Message-Id: <B6D77945-548E-48FA-992A-02260BD3F427@holtmann.org>
References: <FF845DCC-A87F-4B35-A9A4-0F031DC7CE0B@holtmann.org> <1383639342-9972-1-git-send-email-sw0312.kim@samsung.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seung-Woo,

> L2CAP socket validates proper bdaddr_type for connect, so this
> patch fixes to set explictly bdaddr_type for RFCOMM connect.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> net/bluetooth/rfcomm/core.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

