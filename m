Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Sep 2014 07:55:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Martin Townsend <mtownsend1973@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140925055504.GA24765@omega>
References: <1410875570.4860.23.camel@jrissane-mobl.ger.corp.intel.com>
 <20140916140459.GB6104@omega>
 <54184CDB.9050200@xsilon.com>
 <20140916173806.GC6104@omega>
 <54188817.80707@xsilon.com>
 <20140916193723.GD6104@omega>
 <54189522.9090405@xsilon.com>
 <20140916200754.GE6104@omega>
 <54189B6E.5080905@xsilon.com>
 <20140916203032.GG6104@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140916203032.GG6104@omega>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 16, 2014 at 10:30:32PM +0200, Alexander Aring wrote:
...
> 
> Maybe simple do that what Jukka said, to handle the kfree_skb inside of
> lowpan_process_data. What's wrong now with that?
> 

ping. Really bad issue, what's about the state to fix it?

- Alex
