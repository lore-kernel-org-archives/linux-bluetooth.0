Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 3 Aug 2011 17:25:50 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/7] RSSI Monitor
Message-ID: <20110803202550.GF28119@joana>
References: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <CAKT1EBeh+BxAkt-k+CchSMGwV--RgtiPkhi=JqAajgLYF0CiOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKT1EBeh+BxAkt-k+CchSMGwV--RgtiPkhi=JqAajgLYF0CiOw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-08-03 16:36:43 -0300]:

> Hi Briglia/Marcel/Padovan:
> 
> On Tue, Aug 2, 2011 at 3:35 PM, Anderson Briglia
> <anderson.briglia@openbossa.org> wrote:
> > This RFC is about RSSI monitoring since controllers do not have a specific
> > command for this and we need it for Proximity Profile, at least.
> >
> > The RFC implements a mechanism to set threshold levels in order to send
> > alerts to userspace when a RSSI value reaches one of the configured thresholds.
> >
> > Management Interface contains a list of RSSI Monitors. Elements are inserted
> > or deleted from this list using two new Management commands: Enable and Disable
> > RSSI Monitor.
> >
> > A timer was added to do HCI Read RSSI requests to the controller and get RSSI
> > values updated. If there is monitored connection (eg.: RSSI Monitor list size >
> > 0), the timer is reseted after two seconds and the RSSI for each monitored conn
> > is updated. Using the RSSI value, a Management Event is sent if one of the
> > thresholds were reached and the alert is different from the last one sent.
> >
> > Userspace is responsible to add and remove RSSI Monitors. Each monitor must
> > have low and high thresholds values for RSSI. A RSSI Monitor is disabled when
> > the connection is no longer available or the userspace sends a command to
> > remove it. If there is no RSSI Monitor remaining in the list, the RSSI Read
> > polling timer is removed.
> 
> Should be the entries persistent across connections? In the suggested
> approach the RSSI threshold monitor for a given address is
> automatically removed when the connection is lost.
> By other hand, persistence introduces another problem: trust that the
> userspace will disable the monitor.

Is it really worth? There are some reconnections to justify the persistent
entry? The wast of memory worth the savings in interactions between
kernel-userpace through the mgmt?

	Gustavo
