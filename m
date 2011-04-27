Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 19:06:11 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Remove l2cap_sk_list
Message-ID: <20110427220611.GA8537@piper>
References: <1303940957-22694-1-git-send-email-padovan@profusion.mobi>
 <1303940957-22694-2-git-send-email-padovan@profusion.mobi>
 <1303940957-22694-3-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303940957-22694-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 18:49 Wed 27 Apr, Gustavo F. Padovan wrote:
> A new list was added to replace the socket based one. This new list
> doesn't depent on sock and then fits better inside l2cap_core.c code.
> 
> It also rename l2cap_chan_alloc() to l2cap_chan_create() and
> l2cap_chan_free() to l2cap_chan_destruct()

I think that l2cap_chan_destroy() would sound better. create/destroy sound
more related than create/destruct.

> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    6 +-
>  net/bluetooth/l2cap_core.c    |  165 ++++++++++++++++++++++-------------------
>  net/bluetooth/l2cap_sock.c    |    6 +-
>  3 files changed, 95 insertions(+), 82 deletions(-)
> 


Cheers,
-- 
Vinicius
