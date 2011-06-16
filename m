Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 18:57:18 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add link_type information to the mgmt Connected
 event
Message-ID: <20110616215718.GA23537@piper.indt.org>
References: <1307745283-12160-1-git-send-email-vinicius.gomes@openbossa.org>
 <20110616205639.GD2594@joana>
 <20110616210924.GA14812@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110616210924.GA14812@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 00:09 Fri 17 Jun, Johan Hedberg wrote:
> Hi,
> 
> On Thu, Jun 16, 2011, Gustavo F. Padovan wrote:
> > > -int mgmt_connected(u16 index, bdaddr_t *bdaddr)
> > > +int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
> > >  {
> > >  	struct mgmt_ev_connected ev;
> > > 
> > >  	bacpy(&ev.bdaddr, bdaddr);
> > > +	ev.link_type = link_type;
> > > 
> > >  	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
> > >  }
> > 
> > Seems good to me. Anyone else has comments on it?
> 
> It seems this is using the SCO_LINK, ESCO_LINK, ACL_LINK, and LE_LINK
> defines, right? If we're going to add an address or link type I think
> it'd be good to have the random vs public information for LE addresses
> included from the start.

Yes, we have to think about exporting the type of the address, I just am
not sure that the Connected event is the right place, for me, the story this
event tells is more like: "we are connected to device X over link Y". I
don't know how to fit address type information in that message.

The Device Found event, on the other hand, seems more appropriate for address
type information.

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
