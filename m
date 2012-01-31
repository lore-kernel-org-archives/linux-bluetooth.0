Return-Path: <cyrus@holtmann.org>
Message-ID: <1328022757.1955.218.camel@aeonflux>
Subject: Re: [PATCH v3 1/6] Bluetooth: LE scan should send Discovering events
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 31 Jan 2012 07:12:37 -0800
In-Reply-To: <CACJA=fWWnFA27QGGvoZKU1TrXWWS5jB0e62EaPyjH6DA0G1-xA@mail.gmail.com>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	 <1327531949-29463-2-git-send-email-andre.guedes@openbossa.org>
	 <1327959331.1955.165.camel@aeonflux>
	 <CACJA=fWWnFA27QGGvoZKU1TrXWWS5jB0e62EaPyjH6DA0G1-xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> Send MGMT Discovering events once LE scan starts/stops so the
> >> userspace can track when local adapters are discovering LE devices.
> >>
> >> This way, we also keep the same behavior of inquiry which sends MGMT
> >> Discovering events once inquiry starts/stops even if it is triggered
> >> by an external tool (e.g. hcitool).
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  include/net/bluetooth/hci_core.h |    1 +
> >>  net/bluetooth/hci_core.c         |    2 ++
> >>  net/bluetooth/hci_event.c        |    5 +++++
> >>  3 files changed, 8 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index 25f449f..4e569d8 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -61,6 +61,7 @@ struct discovery_state {
> >>               DISCOVERY_STOPPED,
> >>               DISCOVERY_STARTING,
> >>               DISCOVERY_INQUIRY,
> >> +             DISCOVERY_LE_SCAN,
> >>               DISCOVERY_RESOLVING,
> >>               DISCOVERY_STOPPING,
> >>       } state;
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 91166db..fd22035 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -361,6 +361,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
> >>       struct discovery_state *discov = &hdev->discovery;
> >>
> >>       if (discov->state == DISCOVERY_INQUIRY ||
> >> +                                     discov->state == DISCOVERY_LE_SCAN ||
> >>                                       discov->state == DISCOVERY_RESOLVING)
> >>               return true;
> >
> > I think we need to start using a switch statement here.
> 
> Ok, then I'll have a code refactoring patch to handle this separately.

that is fine with me.

Regards

Marcel


