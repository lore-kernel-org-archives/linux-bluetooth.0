Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Sep 2014 11:21:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: [PATCH][linux-bluetooth 3/3] 6lowpan: Refactored lowpan_rcv so
 it's RFC compliant
Message-ID: <20140911092110.GA20541@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-5-git-send-email-martin.townsend@xsilon.com>
 <20140911085353.GB19675@omega>
 <20140911090950.GD19675@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140911090950.GD19675@omega>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 11, 2014 at 11:09:50AM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Thu, Sep 11, 2014 at 10:53:53AM +0200, Alexander Aring wrote:
> ...
> > 
> > I know this issue and we should not do that in this way.
> > 
> > Why?
> > 
> > Because this works only for fragmentation with IPHC, for example if we
> > support mesh or Broadcast or HC1 compression. We should call after
> > successfully reassembled "means lowpan_frag_rcv returns 1" the lowpan_rcv again.
> > So this is a recursion and we don't should use recursion to much, but it
> > should only be one recursion, so I think that's okay. :-)
> > 
> 
> I reconsider about that, this is not okay. A attacker can send data to
> occur this stack overflow...
> 
> We need another solution for this. Maybe your current one, but handling
> fragmentation at the beginning and then evaulate dispatch values.
> 

I look more in RFC 4944, it seems that mesh and BC0 and MESH always fits
into a single fragmentation... but they don't say anything about max
value and if we have encryption on... I am not sure now if there is a case
where this can happen or not. Simple -> check fragmentation if
fragmentation then goahead until it's reassembled. After reassembled
check for all other dispatch values.

This should be sure that we handle all packets if fragmented or not.

- Alex
