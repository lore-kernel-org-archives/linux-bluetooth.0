Return-Path: <cyrus@holtmann.org>
Message-ID: <1329118233.28848.62.camel@aeonflux>
Subject: Re: [PATCH 1/2] bluetooth: Use more current logging styles
From: Marcel Holtmann <marcel@holtmann.org>
To: Joe Perches <joe@perches.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Date: Mon, 13 Feb 2012 08:30:33 +0100
In-Reply-To: <1329118080.31068.4.camel@joe2Laptop>
References: <cover.1329102581.git.joe@perches.com>
	 <44b8744770a55924c68f8ad0ca274816d2d6148f.1329102581.git.joe@perches.com>
	 <1329114913.28848.50.camel@aeonflux> <1329115573.30878.1.camel@joe2Laptop>
	 <1329117706.28848.55.camel@aeonflux> <1329118080.31068.4.camel@joe2Laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

> > > There shouldn't be a newline at all with the
> > > actual functions bt_err or bt_info except
> > > at the uses.
> > then you might wanna read your patch again ;)
> 
> Yup, there's no newline with bt_info
> and there shouldn't be one with bt_err
> either.  There is though.  Oh well.
> Easy to fix at your end if you like.

and why exactly is this my job now to fix your broken patch?

Regards

Marcel


