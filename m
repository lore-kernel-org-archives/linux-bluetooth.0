Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2014 20:12:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Fix skb allocation check for A2MP
Message-ID: <20140307181219.GA24347@localhost.P-661HNU-F1>
References: <1356146573-9639-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356146573-9639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Dec 22, 2012, Gustavo Padovan wrote:
> vtable's method alloc_skb() needs to return a ERR_PTR in case of err and
> not a NULL.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/a2mp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
