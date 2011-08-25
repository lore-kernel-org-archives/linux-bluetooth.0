Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 21:26:21 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/5 v2] Bluetooth: prioritizing data over HCI
Message-ID: <20110825002621.GB5462@joana>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
 <1313587384-2653-5-git-send-email-luiz.dentz@gmail.com>
 <20110824200446.GD2662@joana>
 <CABBYNZJB8sOawyqJM-p3yyhRKQBq46Q2qm3V0Jio4FwFm-OWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJB8sOawyqJM-p3yyhRKQBq46Q2qm3V0Jio4FwFm-OWVA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-25 00:53:04 +0300]:

> Hi Gustavo,
> 
> On Wed, Aug 24, 2011 at 11:04 PM, Gustavo Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Luiz,
> >
> > * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-17 16:23:03 +0300]:
> >
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> This implement priority based scheduler using skbuffer priority set via
> >> SO_PRIORITY socket option.
> >>
> >> It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
> >> each item in this list refer to a L2CAP connection and it is used to
> >> queue the data for transmission.
> >>
> >> Each connection continue to have a queue but it is only used for time
> >> critical packets such the L2CAP commands and it is always processed
> >> before the channels thus it can be considered the highest priority.
> >
> > I think we can drop the connection and queue create a channel by default for
> > the special L2CAP channels, BR/EDR and LE signalling, SMP and AMP Manager.
> > Those will have high priority of course. Standardize this in just one way to
> > send packets would be better. It simplifies the sending logic and reduces the
> > code.
> 
> Sure, but then we need something to identify this special hci_chan and
> it needs to be added to the list to be processed together, not sure if
> it will simplify that much in the end.

It could be created and added to the connection hash when we create the
l2cap_conn and then have a l2cap_conn->hchan for it. IMHO this simplifies the
scheduler and the logic.

<...>

> >
> > IMHO when le_pkts equals zero(i.e., ACL and LE use the same buffer) we should
> > handle LE sending together with the ACL sending. This way we are prioritizing
> > ACL data over LE if we call hci_sched_acl before hci_sched_le.
> 
> iirc Peter has some patch that merges them, the problem is that
> conn->type cannot be set to ACL since it is used for other purposes,
> but perhaps we gonna have a different type to identify the buffer type
> the connection is using.

Yeah, I've read it just after reply to this email. ;)

	Gustavo
