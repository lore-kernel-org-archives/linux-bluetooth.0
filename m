Return-Path: <cyrus@holtmann.org>
Message-ID: <1331574238.14217.87.camel@aeonflux>
Subject: Re: [PATCHv2 2/6] Bluetooth: Correct length calc in L2CAP conf rsp
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:43:58 -0700
In-Reply-To: <1331547191-15307-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1331547191-15307-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> cmd->len is in le format so convert it to host format before use.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


