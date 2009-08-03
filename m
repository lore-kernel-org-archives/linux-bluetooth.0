Return-Path: <cyrus@holtmann.org>
Date: Mon, 03 Aug 2009 13:29:24 -0700 (PDT)
Message-Id: <20090803.132924.151782729.davem@davemloft.net>
To: hidave.darkstar@gmail.com
Cc: marcel@holtmann.org, oliver@hartkopp.net, alan@lxorguk.ukuu.org.uk,
 netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH]bluetooth: rfcomm_init bug fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090803142616.GA1973@darkstar>
References: <20090803142616.GA1973@darkstar>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dave Young <hidave.darkstar@gmail.com>
Date: Mon, 3 Aug 2009 22:26:16 +0800

> rfcomm tty may be used before rfcomm_tty_driver initilized,
> The problem is that now socket layer init before tty layer, if userspace
> program do socket callback right here then oops will happen.
> 
> reporting in:
> http://marc.info/?l=linux-bluetooth&m=124404919324542&w=2
 ...
> Reported-by: Oliver Hartkopp <oliver@hartkopp.net>
> Tested-by: Oliver Hartkopp <oliver@hartkopp.net>
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com>

Applied, thanks.
