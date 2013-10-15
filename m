Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 20:52:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add l2cap_chan_no_resume stub for A2MP
Message-ID: <20131015235217.GF2305@joana>
References: <1381880831-65322-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381880831-65322-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-10-15 Marcel Holtmann <marcel@holtmann.org>:

> The A2MP client for L2CAP channels needs to use l2cap_chan_no_resume
> empty stub function.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h | 4 ++++
>  net/bluetooth/a2mp.c          | 1 +
>  2 files changed, 5 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
