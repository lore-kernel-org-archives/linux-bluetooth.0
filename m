Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 16:34:26 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Report error for HCI reset ioctl when device
 is down
Message-ID: <20130901153426.GF7440@joana>
References: <1377575878-2629-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377575878-2629-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> Even if this is legacy API, there is no reason to not report a proper
> error when trying to reset a HCI device that is down.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
