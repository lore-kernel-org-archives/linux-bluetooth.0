Return-Path: <johan.hedberg@gmail.com>
Date: Tue, 30 Aug 2016 14:49:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Introduce helper functions for socket
 cookie handling
Message-ID: <20160830114901.GA1988@t440s.P-661HNU-F1>
References: <1472526040-21804-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472526040-21804-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 30, 2016, Marcel Holtmann wrote:
> Instead of manually allocating cookie information each time, use helper
> functions for generating and releasing cookies.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)

All seven patches in this set have been applied to bluetooth-next.
Thanks.

Johan
