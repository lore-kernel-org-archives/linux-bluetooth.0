Return-Path: <cyrus@holtmann.org>
Subject: RE: [bluetooth-next V2] Bluetooth: handle device reset event
From: Marcel Holtmann <marcel@holtmann.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Cohen, Guy" <guy.cohen@intel.com>,
	"Rindjunsky, Ron" <ron.rindjunsky@intel.com>,
	"Paskar, Gregory" <gregory.paskar@intel.com>
In-Reply-To: <6F5C1D715B2DA5498A628E6B9C124F04016C15DFA3@hasmsx504.ger.corp.intel.com>
References: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
	 <1268096587.3712.36.camel@localhost.localdomain>
	 <6F5C1D715B2DA5498A628E6B9C124F04016C0E97A6@hasmsx504.ger.corp.intel.com>
	 <1268239760.3712.84.camel@localhost.localdomain>
	 <6F5C1D715B2DA5498A628E6B9C124F04016C15DFA3@hasmsx504.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 12:57:11 -0700
Message-ID: <1268683031.3897.81.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> > > > > A Bluetooth device experiencing hardware failure may issue
> > > > > a HARDWARE_ERROR hci event. The reaction to this event is device
> > > > > reset flow implemented in following sequence.
> > > > >
> > > > > 1. Notify: HCI_DEV_DOWN
> > > > > 2. Reinitialize internal structures.
> > > > > 3. Call driver flush function
> > > > > 4. Send HCI reset request to the device.
> > > > > 5. Send HCI init sequence reset to the device.
> > > > > 6. Notify HCI_DEV_UP.
> > > >
> > > > I prefer if we create a generic per controller workqueue first before
> > > > having a workqueue for every task. Something similar to what the
> > > > mac80211 layer offers right now.
> > >
> > > That would be good approach but we are using default kernel workqueue in
> > this solution so there is no workqueue for every task.
> > > I'm not sure if this effort should block this patch.
> > 
> > I have an initial patch that I have to dig out. It is actually not that
> > complicated. And I would prefer to get that one first before we apply
> > this patch.
> 
> Okay, I can test this particular flow with your patch if you send it to me.

I pushed the per controller workqueue patch into bluetooth-testing.git
tree. Please adapt your patch to that and test it.

> > The reason why I really wanna solve this is because of potential race
> > conditions between the workqueue and a device removal. I have a bad
> > feeling that even with the current sysfs workqueue we have a race
> > condition hiding somewhere. So if going forward we have to shift more
> > and more code into workqueues we need a single point where this can be
> > fixed.
> 
> Understood.
> 
> In that context I would need to do some more instrumentation to test this kind of race for this feature. 

I could be very well that we are protected against such a race. However
with moving from tasklet into workqueue I am always cautious. And I
wanna make sure that we keep the complexity simple. I want one place to
fix if it breaks and not twenty.

Regards

Marcel


