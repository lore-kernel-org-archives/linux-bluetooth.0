Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 19:51:00 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Filter duplicated reports in LE scan
Message-ID: <20120601225100.GD24769@joana>
References: <1338505301-25384-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338505301-25384-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-05-31 20:01:41 -0300]:

> This patch enables filtering duplicated advertising reports during
> LE scan.
> 
> Some LE devices advertise using very small intervals generating lots
> of equal advertising report events to the host. Each event generates
> a mgmt_device_found event which is copied to userspace.
> 
> Enabling this feature, duplicated advertising reports are filtered
> at controller's link layer. This way, the controller doesn't wake up
> the host to report duplicated advertising reports and, consequently,
> less data is copied to userspace.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |    1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
