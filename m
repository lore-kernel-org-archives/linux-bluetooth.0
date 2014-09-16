Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Sep 2014 11:17:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916091713.GC3418@omega>
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com>
 <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
 <20140916065703.GA1244@omega>
 <5417F49A.2010608@xsilon.com>
 <20140916090608.GB3418@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140916090608.GB3418@omega>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 16, 2014 at 11:06:08AM +0200, Alexander Aring wrote:
...
> > Are you saying that skb->len needs setting here? or just that to do on the fly decompression it's required?
> > 
> 
and I was wrong here, I mean we need the IPv6 header payload need to set
according "skb->len - sizeof(...ipv6hdr)".

that's currently setted while uncompression, but for our use case with
fragmentation while receiving FRAG1 skb->len is wrong.


btw.
I also detected right now that makes also trouble with next header
compression payload size attributes. But this is a complete other issue.
We need make this as next step when we insert next header framework.

Otherwise we can't uncompress on the fly while receiving FRAG1, but we
need to handle this in that way to remove the ugly workaround solution.

Nobody says that this would be easy.

- Alex
