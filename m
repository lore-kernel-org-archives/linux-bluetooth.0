Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Oct 2008 23:09:04 -0700 (PDT)
Message-Id: <20081026.230904.103613855.davem@davemloft.net>
To: sergio@larces.uece.br
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] btsdio: free sk_buff with kfree_skb
From: David Miller <davem@davemloft.net>
In-Reply-To: <4904194D.1080806@larces.uece.br>
References: <4904194D.1080806@larces.uece.br>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sergio Luis <sergio@larces.uece.br>
Date: Sun, 26 Oct 2008 04:16:29 -0300

> free sk_buff with kfree_skb, instead of kree
>  
> Signed-off-by: Sergio Luis <sergio@larces.uece.br>

Since this is pretty obvious I'm applying this directly, I hope
Marcel doesn't mind :-)
