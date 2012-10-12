Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085821.19673.10.camel@aeonflux>
Subject: Re: [RFCv1 2/7] Bluetooth: AMP: Handle complete frames in l2cap
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 13 Oct 2012 01:50:21 +0200
In-Reply-To: <1350051005-6015-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1350051005-6015-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Check flags type in switch statement and handle new frame
> type ACL_COMPLETE used for High Speed data over AMP.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/l2cap_core.c  |   15 ++++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


