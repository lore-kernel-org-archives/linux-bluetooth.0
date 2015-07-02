Return-Path: <cyrus@holtmann.org>
Date: Thu, 02 Jul 2015 12:18:21 -0700 (PDT)
Message-Id: <20150702.121821.1272949529563088472.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth 2015-07-02
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150702073038.GA25214@t440s.lan>
References: <20150702073038.GA25214@t440s.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 2 Jul 2015 10:30:38 +0300

> A couple of regressions crept in because of a patch to use proper list
> APIs rather than manually reading & writing the next/prev pointers
> (commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5). Turns out this was
> masking a few bugs: a missing INIT_LIST_HEAD() call and incorrectly
> using list_del() rather than list_del_init(). The two patches in this
> set fix these, and it'd be nice they could still make it to 4.2-rc1 to
> avoid new bug reports from users.
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
