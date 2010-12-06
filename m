Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] bluetooth: Use printf extension %pMbt
From: Joe Perches <joe@perches.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>,
 =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20101206181507.GC883@vigoh>
References: <cover.1291419007.git.joe@perches.com>
	 <b966e9510dec12556a3d1313b026cb2c8281e4d6.1291419007.git.joe@perches.com>
	 <20101206181507.GC883@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 06 Dec 2010 10:50:13 -0800
Message-ID: <1291661413.17494.219.camel@Joe-Laptop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-12-06 at 16:15 -0200, Gustavo F. Padovan wrote:
> This patch doesn't apply to the bluetooth-next-2.6 tree.
> Can you please rebase it against the bluetooth-next-2.6 tree?

No worries, it was done against next-20101202.

Do you care about using %pMR vs %pMbt as Michał suggested in
https://lkml.org/lkml/2010/12/4/21 ?

I think %pMbt more specific, Michał %pMR more generic.
Doesn't matter much to me.  Do tell, I'll resubmit either way.
