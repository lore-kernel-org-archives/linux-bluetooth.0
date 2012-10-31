Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 16:51:36 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 11/12] Bluetooth: AMP: Use l2cap_physical_cfm in
 phylink complete evt
Message-ID: <20121031185136.GF1679@joana>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351691197-8394-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-31 15:46:36 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When receiving HCI Phylink Complete event run amp_physical_cfm
> which initialize BR/EDR L2CAP channel associated with High Speed
> link and run l2cap_physical_cfm which shall send L2CAP Create
> Chan Request.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/amp.h   |    1 +
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/amp.c           |   24 ++++++++++++++++++++++++
>  net/bluetooth/hci_event.c     |   15 ++-------------
>  4 files changed, 28 insertions(+), 13 deletions(-)

Patches 1-11 have been applied to bluetooth-next. Thanks.

	Gustavo
