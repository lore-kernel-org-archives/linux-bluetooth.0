Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: Fix Device Scan and connection collision
Date: Wed, 18 Jul 2012 10:27:55 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4AF385@DNCE05.ent.ti.com>
References: <1342596961-3446-1-git-send-email-ramm@ti.com>
 <20120718082410.GA10318@x220.ger.corp.intel.com>
 <2683478DEE33CD4DAF508ABCF391F6A40B4AF312@DNCE05.ent.ti.com>
 <20120718102027.GA14515@x220.ger.corp.intel.com>
In-Reply-To: <20120718102027.GA14515@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Wednesday, July 18, 2012 1:20 PM
> To: Malovany, Ram
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v4] Bluetooth: Fix Device Scan and connection collision
> 
> Hi Ram,
> 
> On Wed, Jul 18, 2012, Malovany, Ram wrote:
> > > >  	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
> NAME_NEEDED);
> > > > -	if (hci_resolve_name(hdev, e) == 0) {
> > > > +	if (e && hci_resolve_name(hdev, e) == 0) {
> > > >  		e->name_state = NAME_PENDING;
> > > >  		return true;
> > > >  	}
> > >
> > > This missing NULL check is the first fix. You might actually consider
> > > doing:
> > >
> > > 	if (!e)
> > > 		return false;
> > >
> >
> > I didn't want to change the coding in this specific file , as you can
> > see in the function:
> >
> > hci_inquiry_complete_evt() , calling it the same way.
> > But I can changed them both if needed. Do you want me to ?
> 
> The code in hci_inquiry_complete_evt() is a bit different though. There
> you have something else instead of a simple return statement if e is
> NULL (set the discovery state and unlock hdev) so changing that part
> wouldn't really simplify the code much. In your case the code does
> however get a bit simpler since all you need to do is return false.
> 


OK  - will update it according to your comments. Thanks

> Johan


Regards,

Ram
