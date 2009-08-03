Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH]bluetooth: rfcomm_init bug fix
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
Cc: hidave.darkstar@gmail.com, oliver@hartkopp.net,
	alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20090803.132924.151782729.davem@davemloft.net>
References: <20090803142616.GA1973@darkstar>
	 <20090803.132924.151782729.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 16:54:26 -0700
Message-Id: <1249343666.3094.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> > rfcomm tty may be used before rfcomm_tty_driver initilized,
> > The problem is that now socket layer init before tty layer, if userspace
> > program do socket callback right here then oops will happen.
> > 
> > reporting in:
> > http://marc.info/?l=linux-bluetooth&m=124404919324542&w=2
>  ...
> > Reported-by: Oliver Hartkopp <oliver@hartkopp.net>
> > Tested-by: Oliver Hartkopp <oliver@hartkopp.net>
> > Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
> 
> Applied, thanks.

do you mind at least waiting for an ACK from my side. I haven't even
looked at the final patch.

Regards

Marcel


