Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetooth:btusb - Change 1 to true in bool type variable assignment.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432578220-4216-1-git-send-email-shailendra.capricorn@gmail.com>
Date: Mon, 25 May 2015 20:58:25 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <FA4300CC-D654-40DD-B5BF-6508FEC4BAE3@holtmann.org>
References: <1432578220-4216-1-git-send-email-shailendra.capricorn@gmail.com>
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shailendra,

> The reset is a bool type variable.So assigning true to reset instead
> of 1.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
> drivers/bluetooth/btusb.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

