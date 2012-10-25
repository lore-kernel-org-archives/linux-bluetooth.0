Return-Path: <cyrus@holtmann.org>
Message-ID: <1351170502.1785.89.camel@aeonflux>
Subject: Re: [RFCv1 04/11] Bluetooth: AMP: Process Logical Link complete evt
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Oct 2012 06:08:22 -0700
In-Reply-To: <1351167652-12346-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351167652-12346-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> After receiving HCI Logical Link Complete event finish EFS
> configuration by sending L2CAP Conf Response with success code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    2 ++
>  net/bluetooth/hci_event.c     |   42 +++++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c    |    4 ++--
>  3 files changed, 46 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


