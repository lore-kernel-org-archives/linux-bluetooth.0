Return-Path: <cyrus@holtmann.org>
Message-ID: <1326473954.6454.268.camel@aeonflux>
Subject: Re: [RFC 1/2] Bluetooth: Use chan instead of sk
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Jan 2012 17:59:14 +0100
In-Reply-To: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326468103-12731-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove unneeded conversion from sk to chan.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


