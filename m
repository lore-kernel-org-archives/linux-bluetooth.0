Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Oct 2009 19:37:11 -0700 (PDT)
Message-Id: <20091019.193711.147629067.davem@davemloft.net>
To: hidave.darkstar@gmail.com
Cc: marcel@holtmann.org, alan@lxorguk.ukuu.org.uk, oliver@hartkopp.net,
 netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bluetooth: scheduling while atomic bug fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091019062441.GA4102@darkstar.vlan7>
References: <20091019062441.GA4102@darkstar.vlan7>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dave Young <hidave.darkstar@gmail.com>
Date: Mon, 19 Oct 2009 14:24:41 +0800

> Due to driver core changes dev_set_drvdata will call kzalloc which should be
> in might_sleep context, but hci_conn_add will be called in atomic context
> 
> Like dev_set_name move dev_set_drvdata to work queue function.
> 
> oops as following:
 ...
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com>

Applied.
