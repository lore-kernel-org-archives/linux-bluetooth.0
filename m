Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v1] Bluetooth: Fix potential NULL dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431588488-16666-1-git-send-email-jaganath.k@samsung.com>
Date: Sat, 6 Jun 2015 08:45:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8CD6A39B-470E-4B5E-9B03-2D94D499952B@holtmann.org>
References: <1431588488-16666-1-git-send-email-jaganath.k@samsung.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> addr can be NULL and it should not be dereferenced before NULL checking.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
> net/bluetooth/rfcomm/sock.c |   20 ++++++++++++--------
> 1 file changed, 12 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

And I am expecting to see a similar patch for the rfcomm_sock_connect case as well.

Regards

Marcel

