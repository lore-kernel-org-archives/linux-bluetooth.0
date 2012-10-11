Return-Path: <cyrus@holtmann.org>
Message-ID: <1349968334.27233.182.camel@aeonflux>
Subject: Re: [RFC 1/6] Bluetooth: Add new l2cap_chan struct members for high
 speed channels
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Date: Thu, 11 Oct 2012 17:12:14 +0200
In-Reply-To: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> An L2CAP channel using high speed continues to be associated with a
> BR/EDR l2cap_conn, while also tracking an additional hci_conn
> (representing a physical link on a high speed controller) and hci_chan
> (representing a logical link).  There may only be one physical link
> between two high speed controllers.  Each physical link may contain
> several logical links, with each logical link representing a channel
> with specific quality of service.
> 
> During a channel move, the destination channel id, current move state,
> and role (initiator vs. responder) are tracked and used by the channel
> move state machine.  The ident value associated with a move request
> must also be stored in order to use it in later move responses.
> 
> The active channel is stored in local_amp_id.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   29 +++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c    |    5 +++++
>  2 files changed, 34 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


