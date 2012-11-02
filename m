Return-Path: <cyrus@holtmann.org>
Message-ID: <1351816257.1828.20.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Process Create Chan Request
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Nov 2012 01:30:57 +0100
In-Reply-To: <1351777023-10018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1351700642.1828.13.camel@aeonflux>
	 <1351777023-10018-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add processing L2CAP Create Chan Request. When channel is created
> save associated high speed link hs_hcon.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   63 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


