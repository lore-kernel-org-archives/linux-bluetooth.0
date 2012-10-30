Return-Path: <cyrus@holtmann.org>
Message-ID: <1351615906.1828.7.camel@aeonflux>
Subject: Re: [RFCv2 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in phylink
 complete evt
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 30 Oct 2012 09:51:46 -0700
In-Reply-To: <1351612384-12392-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351612384-12392-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When receiving HCI Phylink Complete event run amp_physical_cfm
> which initialize BR/EDR L2CAP channel associated with High Speed
> link and run l2cap_physical_cfm which shall send L2CAP Create
> Chan Request.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/amp.h   |    1 +
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/amp.c           |   24 ++++++++++++++++++++++++
>  net/bluetooth/hci_event.c     |   15 ++-------------
>  4 files changed, 28 insertions(+), 13 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


