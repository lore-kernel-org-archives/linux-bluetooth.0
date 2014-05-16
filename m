Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Add missing msecs to jiffies conversion
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400251737-16342-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 16 May 2014 08:23:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6F8EDDDA-9905-4FD6-853D-3E0105285121@holtmann.org>
References: <1400251737-16342-1-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> conn_info_age value is calculated in ms, so need to be converted to
> jiffies.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> net/bluetooth/mgmt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

