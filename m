Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jun 2012 22:20:42 -0300 (BRT)
Message-Id: <20120611.222042.1513738698665636019.pcacjr@zytor.com>
To: paulo.alcantara@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove magic value in disconnect mgmt
 handler
From: pcacjr@zytor.com
In-Reply-To: <1339463618-5862-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339463618-5862-1-git-send-email-paulo.alcantara@openbossa.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>
Date: Mon, 11 Jun 2012 22:13:38 -0300

> This patch replaces the magic value of variable 'reason' by the
> proper macro.
> 
> Signed-off-by: Paulo Alcantara <paulo.alcantara@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ignore this patch. The commit message is wrong.

The correct one is: "[PATCH v2] Bluetooth: Remove magic value in unpair_device
handler".

Thanks,

Paulo
