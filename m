Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 08:58:40 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/6] Bluetooth: Add new l2cap_chan struct members for high
 speed channels
In-Reply-To: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1210110858010.26189@mathewm-linux>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Thu, 11 Oct 2012, Andrei Emeltchenko wrote:

> From: Mat Martineau <mathewm@codeaurora.org>
>
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
> include/net/bluetooth/l2cap.h |   29 +++++++++++++++++++++++++++++
> net/bluetooth/l2cap_core.c    |    5 +++++
> 2 files changed, 34 insertions(+)

Did you have to do anything other than rebase these 6 patches?

I can post a PATCHv1 set tomorrow or Monday.


--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


