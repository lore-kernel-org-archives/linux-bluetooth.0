Return-Path: <cyrus@holtmann.org>
Message-ID: <1331573727.14217.80.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: Fix type in cpu_to_le conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:35:27 -0700
In-Reply-To: <1331560774-10748-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1331560774-10748-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use struct hci_cp_write_def_link_policy to overcome sparse
> warnigs below:
> 
> ...
> net/bluetooth/hci_event.c:633:21: warning: incorrect type in assignment
> (different base types)
> net/bluetooth/hci_event.c:633:21:    expected unsigned short [unsigned]
> [assigned] [usertype] link_policy
> net/bluetooth/hci_event.c:633:21:    got restricted __le16 [usertype] <noident>
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


