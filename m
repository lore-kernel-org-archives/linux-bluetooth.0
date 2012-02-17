Return-Path: <cyrus@holtmann.org>
Message-ID: <1329472107.28848.166.camel@aeonflux>
Subject: Re: [PATCHv2 3/3] Bluetooth: Prefix hex numbers with object name
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 10:48:27 +0100
In-Reply-To: <1329471657-18278-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1329471657-18278-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Several hex numbers were printed without object name which
> complicates debugging.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c   |    2 +-
>  net/bluetooth/l2cap_core.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


