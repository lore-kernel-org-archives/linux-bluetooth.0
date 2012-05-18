Return-Path: <cyrus@holtmann.org>
Message-ID: <1337314755.5970.288.camel@aeonflux>
Subject: Re: [PATCHv2] Bluetooth: Fix early return from l2cap_chan_del
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Date: Thu, 17 May 2012 21:19:15 -0700
In-Reply-To: <1337314449-27842-1-git-send-email-mathewm@codeaurora.org>
References: <1337314449-27842-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> This fixes a regression from commit
> 2ead70b8390d199ca04cd35311b51f5f3676079e that is present in all
> kernels starting at v3.0.
> 
> When L2CAP information was moved to struct l2cap_chan, a check was
> added to l2cap_chan_del to avoid certain cleanup operations when ERTM
> or streaming mode had not yet been initialized.  The logic in the
> check did not take in to account that chan->conf_state is set to 0 in
> l2cap_chan_ready, so l2cap_chan_del failed to cancel timers and leaked
> memory any time the ERTM queues or lists were not empty.
> 
> This change makes sure that l2cap_chan_del only returns early if
> ERTM initialization was not performed.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |    7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


