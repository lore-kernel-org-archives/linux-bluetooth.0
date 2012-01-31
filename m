Return-Path: <cyrus@holtmann.org>
Message-ID: <1328022490.1955.214.camel@aeonflux>
Subject: Re: [RESEND 3/3] Bluetooth: Use list _safe deleting from conn
 chan_list
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 31 Jan 2012 07:08:10 -0800
In-Reply-To: <1327999384-16094-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1327999384-16094-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fixes possible bug when deleting element from the list in
> function hci_chan_list_flush. list_for_each_entry_rcu is used
> and after deleting element from the list we also free pointer
> and then list_entry_rcu is taken from freed pointer.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


