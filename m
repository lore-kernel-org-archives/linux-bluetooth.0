Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512400869.29399.1.camel@ewol.com>
Subject: Re: meshctl: Can't connect via Node Identity advertisement
To: Johan Hedberg <johan.hedberg@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 04 Dec 2017 08:21:09 -0700
In-Reply-To: <20171204150502.GA30627@x1c.home>
References: <1512344374.16639.18.camel@ewol.com>
         <20171204123606.GA29257@x1c.lan> <1512395982.27418.14.camel@ewol.com>
         <20171204150502.GA30627@x1c.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, 2017-12-04 at 17:05 +0200, Johan Hedberg wrote:
> Hi Steve,
> 
> On Mon, Dec 04, 2017, Steve Brown wrote:
> > I added the command as you suggested. 
> > 
> > I had to change them to net-connect and node-connect because of
> > command
> > completion.
> > 
> > If I issue a node-connect while the mesh-shell ident command is
> > active,
> > it connects.
> > 
> > If you think there's interest, I'll post the patch.
> 
> I think we should definitely add support for this upstream, but after
> thinking a bit more about it, maybe we could simply extend the
> existing
> connect command instead of adding a new one. Node Identity is always
> in
> the context of a given NetKey Index, so I think it'd be just as
> natural
> to have a second optional parameter to the existing connect command
> which would be the element address. If only one parameter is given
> then
> meshctl looks for Net ID, if two are given it looks for Node ID.
> Sounds
> reasonable?
> 
> Johan

I'll do that. Saves lots of duplicated code.

Steve

