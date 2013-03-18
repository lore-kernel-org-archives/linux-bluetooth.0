Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 14:08:10 -0400 (EDT)
Message-Id: <20130318.140810.1336756541135122611.davem@davemloft.net>
To: silviupopescu1990@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, johan.hedberg@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: use PTR_RET instead of IS_ERR + PTR_ERR
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAPWTe+JzznuWYKksAfxkD=u9kv8DuAF4v2AWVxd2OUeDtCYKBA@mail.gmail.com>
References: <1363111995-26866-1-git-send-email-silviupopescu1990@gmail.com>
	<20130313.053145.2200448840921851390.davem@davemloft.net>
	<CAPWTe+JzznuWYKksAfxkD=u9kv8DuAF4v2AWVxd2OUeDtCYKBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Silviu Popescu <silviupopescu1990@gmail.com>
Date: Mon, 18 Mar 2013 20:05:42 +0200

>>> +     return PTR_RET(bt_class)
 ..
> That being said, I'd like to understand a bit better what exactly I messed up.

There's no semicolon at the end of the return statement.
