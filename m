Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 15:31:42 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH bluetooth-next] Fixes kernel panic in incomming l2cap
 connections with defer_setup
Message-ID: <20110713183142.GA23921@joana>
References: <1310554946-765-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310554946-765-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

* ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-07-13 14:02:26 +0300]:

> From: Ilia Kolomisnky <iliak@ti.com>
> 
> Another fix considering incomming l2cap connections with
> defer_setup enabled. In situations when incomming connection is
> extracted with l2cap_sock_accept, it's bt_sock info will have
> 'parent' member zerroed, but 'parent' may be used unconditionally
> in l2cap_conn_start() and l2cap_security_cfm() when defer_setup
> is enabled.

I want to see a hcidump and kernel log with dynamic debug enabled first.
The fix might be somewhere else and not here.

	Gustavo
