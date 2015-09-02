Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2] bluetooth: btmrvl: skb resource leak, and double free.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441198270-24054-1-git-send-email-kieranbingham@gmail.com>
Date: Wed, 2 Sep 2015 09:19:10 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, akarwar@marvell.com
Message-Id: <C6EE6513-FAF0-4FE1-B000-0BEE57A6B520@holtmann.org>
References: <1441198270-24054-1-git-send-email-kieranbingham@gmail.com>
To: Kieran Bingham <kieranbingham@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kieran,

> if btmrvl_tx_pkt() is called, and the branch
>  if (skb_headroom(skb) < BTM_HEADER_LEN)
> evaluates positive, a new skb is allocated via skb_realloc_headroom.
> 
> The original skb is stored in a tmp variable, before being free'd.
> However on success, the new skb, is not free'd, nor is it
> returned to the caller which will then double-free the original skb.
> 
> This issue exists from the original driver submission in
> commit: #132ff4e5fa8dfb71a7d99902f88043113947e972
> 
> If this code path had been alive, it would have been noted from the
> double-free causing a panic.
> 
> All skb's here should be allocated through bt_skb_alloc which
> adds 8 bytes as headroom, which is plenty against the 4 bytes
> pushed on by this driver.
> 
> This code path is dead, and buggy at the same time, so the cleanest
> approach is to remove the affected branch.
> 
> Reported by coverity (CID 113422)
> 
> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 14 --------------
> 1 file changed, 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

