Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Mar 2013 13:34:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Bluetooth: Check req->err in hci_req_add
Message-ID: <20130308113450.GA10655@x220.ger.corp.intel.com>
References: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
 <1362692892-28716-7-git-send-email-andre.guedes@openbossa.org>
 <20130308075009.GB817@x220>
 <20130308110845.GA31311@aemeltch-MOBL1>
 <20130308112540.GA10170@x220.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130308112540.GA10170@x220.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 08, 2013, Johan Hedberg wrote:
> On Fri, Mar 08, 2013, Andrei Emeltchenko wrote:
> > On Fri, Mar 08, 2013 at 09:50:09AM +0200, Johan Hedberg wrote:
> > > Hi Andre,
> > > 
> > > On Thu, Mar 07, 2013, Andre Guedes wrote:
> > > > +	if (req->err)
> > > > +		return;
> > > 
> > > Same thing here with the error check, I think if (err < 0) is more
> > > consistent.
> > 
> > Using "if (err)" seems to be OK for kernel and looks shorter.
> 
> It certainly seems to be more common than in user space, but I wouldn't say
> it's the most common form:
> 
> jh@x220:linux{master}$ git grep 'if (err)' net/bluetooth/|wc -l
> 34
> jh@x220:linux{master}$ git grep 'if (err < 0)' net/bluetooth/|wc -l
> 89
> jh@x220:linux{master}$ 

Looking elsewhere than net/bluetooth/ in the kernel tree the balance
seems to be the other way around though, so I wont insist on this.

Andre, if you do the fix to BT_ERR() you can also add my acks to all
patches in your v3 of this set.

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
