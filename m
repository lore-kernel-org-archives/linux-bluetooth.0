Return-Path: <cyrus@holtmann.org>
Message-ID: <1346430004.23377.23.camel@aeonflux>
Subject: Re: [PATCHv2] Bluetooth: Remove unneeded zero init
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 31 Aug 2012 09:20:04 -0700
In-Reply-To: <1346420369-11909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346339195.23377.8.camel@aeonflux>
	 <1346420369-11909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> hdev is allocated with kzalloc so zero initialization is not needed.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    9 ---------
>  net/bluetooth/hci_core.c         |    2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


