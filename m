Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 29 Sep 2011 16:28:47 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] bluetooth: hci_ll: clean up types a bit
Message-ID: <20110929192847.GD2605@joana>
References: <20110926061412.GA11832@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110926061412.GA11832@elgon.mountain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <dan.carpenter@oracle.com> [2011-09-26 09:14:12 +0300]:

> I'm doing an audit of places where min_t() casting truncates a
> variable such as:
> 	len = min_t(unsigned int, ll->rx_count, count);
> Here ll->rx_count is unsigned long, but we cast it to unsigned int
> and lose the significant bits.
> 
> Looking at the code ->rx_count is never more than 256 so we could
> just make it an int.

Where is this 256 maximum? I'm not seeing it?

	Gustavo
