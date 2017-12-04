Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 4 Dec 2017 17:05:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: meshctl: Can't connect via Node Identity advertisement
Message-ID: <20171204150502.GA30627@x1c.home>
References: <1512344374.16639.18.camel@ewol.com>
 <20171204123606.GA29257@x1c.lan>
 <1512395982.27418.14.camel@ewol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512395982.27418.14.camel@ewol.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Mon, Dec 04, 2017, Steve Brown wrote:
> I added the command as you suggested. 
> 
> I had to change them to net-connect and node-connect because of command
> completion.
> 
> If I issue a node-connect while the mesh-shell ident command is active,
> it connects.
> 
> If you think there's interest, I'll post the patch.

I think we should definitely add support for this upstream, but after
thinking a bit more about it, maybe we could simply extend the existing
connect command instead of adding a new one. Node Identity is always in
the context of a given NetKey Index, so I think it'd be just as natural
to have a second optional parameter to the existing connect command
which would be the element address. If only one parameter is given then
meshctl looks for Net ID, if two are given it looks for Node ID. Sounds
reasonable?

Johan
