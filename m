Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:29:24 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Subject: Re: [RFCv1 01/20] Bluetooth: Add new l2cap_chan struct members for
 high speed channels
Message-ID: <20121001082922.GJ10053@aemeltch-MOBL1>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
 <1347387691-5285-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347387691-5285-2-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 11, 2012 at 11:21:12AM -0700, Mat Martineau wrote:
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

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Best regards 
Andrei Emeltchenko 

