Return-Path: <cyrus@holtmann.org>
Date: Thu, 07 Oct 2010 01:02:18 -0700 (PDT)
Message-Id: <20101007.010218.57483410.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: linville@tuxdriver.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth-2.6 2010-10-05
From: David Miller <davem@davemloft.net>
In-Reply-To: <20101005171349.GA16520@vigoh>
References: <20101005171349.GA16520@vigoh>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Tue, 5 Oct 2010 14:13:49 -0300

> In this patch set we have two fixes for regressions in L2CAP due to ERTM code
> we added in L2CAP for 2.6.36, a bugfix in the L2CAP Streaming Mode that was
> making the kernel crash. And a fix for a deadlock issue between the sk_sndbuf
> and the backlog queue in ERTM. The rest are also needed bug fixes.

Pulled, thanks.
