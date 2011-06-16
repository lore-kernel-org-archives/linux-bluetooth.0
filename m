Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Bluetooth: Add link_type information to the mgmt
 Connected event
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 16 Jun 2011 14:50:33 -0700
In-Reply-To: <20110616210924.GA14812@dell.ger.corp.intel.com>
References: <1307745283-12160-1-git-send-email-vinicius.gomes@openbossa.org>
	 <20110616205639.GD2594@joana>
	 <20110616210924.GA14812@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308261035.2196.27.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

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

we need to make up our own values here since even LE_LINK is not
official Bluetooth specification value.

Regards

Marcel


