Return-Path: <cyrus@holtmann.org>
Date: Thu, 06 Mar 2014 17:22:21 -0500 (EST)
Message-Id: <20140306.172221.439306848276682730.davem@davemloft.net>
To: alex.aring@gmail.com
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	alex.bluesman.smirnov@gmail.com, dbaryshkov@gmail.com,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] 6lowpan: header cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <1394026145-18981-1-git-send-email-alex.aring@gmail.com>
References: <1394026145-18981-1-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alexander Aring <alex.aring@gmail.com>
Date: Wed,  5 Mar 2014 14:29:03 +0100

> this patch series fix a missing include of 6LoWPAN header and move it
> into the include/net directory. Since we did some code sharing with
> bluetooth 6LoWPAN the header turns into a generic header for 6LoWPAN.
> Instead to use a relative path in bluetooth 6LoWPAN we can now use
> include <net/6lowpan.h>.

Series applied, thanks Alex.
