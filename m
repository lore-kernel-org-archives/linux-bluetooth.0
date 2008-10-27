Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch 1/2] btsdio: free sk_buff with kfree_skb
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
Cc: sergio@larces.uece.br, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20081026.230904.103613855.davem@davemloft.net>
References: <4904194D.1080806@larces.uece.br>
	 <20081026.230904.103613855.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 09:37:42 +0100
Message-Id: <1225096662.7157.7.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> > free sk_buff with kfree_skb, instead of kree
> >  
> > Signed-off-by: Sergio Luis <sergio@larces.uece.br>
> 
> Since this is pretty obvious I'm applying this directly, I hope
> Marcel doesn't mind :-)

that is fine with me. No need to run this through me.

Regards

Marcel


