Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 12:51:39 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: Antti Julku <antti.julku@nokia.com>
Cc: ext Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com,
        padovan@profusion.mobi
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
Message-ID: <20110428095139.GJ18898@null>
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1295971990.1520.53.camel@aeonflux>
 <4DB935D9.5080302@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DB935D9.5080302@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 28, 2011 at 12:39:37PM +0300, Antti Julku wrote:
> 
> Hi,
> 
> On 01/25/2011 06:13 PM, ext Marcel Holtmann wrote:
> >Hi Lukasz,
> >
> >>It can happen that controller will schedule ACL data
> >>containing L2CAP connect request to host just before
> >>encryption change event, even though link is encrypted on
> >>LMP level before L2CAP connect request come.
> >>With this fix, L2CAP layer will handle such scenario.
> >
> >I really don't like to have a work around for this. It is clearly a bug
> >in the controller.
> 
> We see this security block issue all the time in our automated
> testing at Nokia. RFCOMM connections to an Ubuntu PC fail randomly
> because of security block, for example when sending files over OPP.
> 
> Hcidump always shows L2CAP before Encrypt Change:
> > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0041
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
>       Connection refused - security block
> > HCI Event: Encrypt Change (0x08) plen 4
>     status 0x00 handle 42 encrypt 0x01
> 
> It's easy to reproduce at least with these dongles:
> 
> Alink BLUEUSB21 (BCM)
> Belkin BT2.1 F8T017 (BCM)
> DeLock 2.1 (CSR)
> PTS 2.1 (CSR)
> 
> So most of our BT 2.1 dongles seem to be buggy. It would be nice to
> have a workaround since it happens with so many dongles.

Could the actual reason be some change in usb stack? Could it have lower
priority for event pipe than for data pipe? In that case event for security
change might arrive to bt stack too late.

At lest I haven't seen this kind of behaviour with serial attached chips. So I
think this is something USB specific.

-- 
Ville
