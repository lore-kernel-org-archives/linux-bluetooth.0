Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jun 2011 00:09:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Add link_type information to the mgmt Connected
 event
Message-ID: <20110616210924.GA14812@dell.ger.corp.intel.com>
References: <1307745283-12160-1-git-send-email-vinicius.gomes@openbossa.org>
 <20110616205639.GD2594@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110616205639.GD2594@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 16, 2011, Gustavo F. Padovan wrote:
> > -int mgmt_connected(u16 index, bdaddr_t *bdaddr)
> > +int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
> >  {
> >  	struct mgmt_ev_connected ev;
> > 
> >  	bacpy(&ev.bdaddr, bdaddr);
> > +	ev.link_type = link_type;
> > 
> >  	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
> >  }
> 
> Seems good to me. Anyone else has comments on it?

It seems this is using the SCO_LINK, ESCO_LINK, ACL_LINK, and LE_LINK
defines, right? If we're going to add an address or link type I think
it'd be good to have the random vs public information for LE addresses
included from the start.

Johan
