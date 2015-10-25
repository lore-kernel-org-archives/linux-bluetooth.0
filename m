Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: avoid endless loop
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445698256-10407-2-git-send-email-alex.aring@gmail.com>
Date: Mon, 26 Oct 2015 05:11:37 +0900
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	kernel@pengutronix.de,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Message-Id: <D10520FE-A8A8-49D9-B6BA-E6682CBCFB42@holtmann.org>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com> <1445698256-10407-2-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> When -EAGAIN as return value for receive handling will do a retry of
> parsing I can trigger a endless loop when iphc decompression e.g.
> returns an errno because some missing function "-ENOTSUPP" or something
> else. Somebody from outside can trigger an endless loop when sending a
> an IPHC header which triggers this behaviour.
> 
> NOTE: This really depends only if -EAGAIN means "try again to call the
> receive handler with the skb". Sometimes we also drop (and kfree) the
> skb, I think something is broken there... depends on the error branch.
> When receiving failed simple free skb and return errno (which is not
> -EAGAIN).

I am lost on this comment, you need to explain this more and might actually want to put a comment in the code on this.

Regards

Marcel

