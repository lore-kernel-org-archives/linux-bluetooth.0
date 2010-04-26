Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 26 Apr 2010 15:27:52 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: David Miller <davem@davemloft.net>
Cc: error27@gmail.com, marcel@holtmann.org, andrei.emeltchenko@nokia.com,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] bluetooth: handle l2cap_create_connless_pdu() errors
Message-ID: <20100426182752.GA23633@vigoh>
References: <20100422123347.GA5265@vigoh>
 <20100426113627.GS29093@bicker>
 <20100426150919.GA12813@vigoh>
 <20100426.111259.112594696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100426.111259.112594696.davem@davemloft.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Miller <davem@davemloft.net> [2010-04-26 11:12:59 -0700]:

> From: "Gustavo F. Padovan" <gustavo@padovan.org>
> Date: Mon, 26 Apr 2010 12:09:19 -0300
> 
> > Hi Dan,
> > 
> > * Dan Carpenter <error27@gmail.com> [2010-04-26 13:36:27 +0200]:
> > 
> >> l2cap_create_connless_pdu() can sometimes return ERR_PTR(-ENOMEM) or
> >> ERR_PTR(-EFAULT).
> >> 
> >> Signed-off-by: Dan Carpenter <error27@gmail.com>
> >> ---
> >> In v2 I wrote the patch on top of Gustavo Padovon's devel tree
> 
> This is the kind of bug that could cause a crash if the path actually
> executes.
> 
> Therefore it tires me that that submitter was told to regenerate this
> patch against some devel tree that is -next bound, when in fact this
> is the kind of fix that warrants inclusion right now into net-2.6

My bad here. So I think we should pick the first version of the Dan's patch. 
It applies against bluetooth-testing right now and then against net-2.6 too.

Marcel, is that ok to you?

> 
> Marcel, please do whatever magic you need to so I can get this into
> Linus's tree as I did the rest of the ERR_PTR() fixes from Dan already.
> No reason to treat Bluetooth special and defer these fixes to -next.
> 
> Thanks.

-- 
Gustavo F. Padovan
http://padovan.org
