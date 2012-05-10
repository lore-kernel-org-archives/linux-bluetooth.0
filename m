Return-Path: <cyrus@holtmann.org>
Date: Wed, 09 May 2012 21:21:10 -0400 (EDT)
Message-Id: <20120509.212110.437114897180819434.davem@davemloft.net>
To: joe@perches.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
	coreteam@netfilter.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] net: Add and use ether_addr_equal
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1336538937.git.joe@perches.com>
References: <cover.1336538937.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joe Perches <joe@perches.com>
Date: Tue,  8 May 2012 21:56:44 -0700

> Add a boolean function to test 2 ethernet addresses for equality
> Convert compare_ether_addr uses to ether_addr_equal

This series looks great, I'll apply all of it.

Thanks Joe.

That case you didn't convert in mac80211 is probably the
bug Johannes was talking about which started this whole
discussion.
