Return-Path: <cyrus@holtmann.org>
Message-ID: <1328798209.28848.27.camel@aeonflux>
Subject: Re: [RFCv3 10/16] Bluetooth: Use chan lock in chan delete functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:36:49 +0100
In-Reply-To: <1328797057-26331-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Change sk lock to chan lock in functions deleting L2CAP
> channels.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   21 +++++++++++++++------
>  net/bluetooth/l2cap_sock.c |    2 ++
>  2 files changed, 17 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


