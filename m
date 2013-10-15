Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 20:56:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/10] Bluetooth: Make mgmt_new_ltk() return void
Message-ID: <20131015235622.GG2305@joana>
References: <1381872389-34389-10-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381872389-34389-10-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-10-15 Marcel Holtmann <marcel@holtmann.org>:

> The return value of mgmt_new_ltk() function is not used and
> so just change it to return void.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  net/bluetooth/mgmt.c             | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)

All 10 patches have been applied to bluetooth-next. Thanks.

	Gustavo
