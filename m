Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 21:55:12 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 3/6] Bluetooth: Check for flow control mode
Message-ID: <20111218235512.GK2621@joana>
References: <1323348786-18134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323348786-18134-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111218234735.GJ2621@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20111218234735.GJ2621@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Gustavo Padovan <padovan@profusion.mobi> [2011-12-18 21:47:35 -0200]:

> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-12-08 14:53:03 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/hci_event.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> Found the new ones! This one is applied, and the others need rebase against
> bluetooth-next. Thanks.

net/bluetooth/hci_event.c: In function ‘hci_num_comp_pkts_evt’:
net/bluetooth/hci_event.c:2263:29: error: ‘HCI_FLOW_CTL_MODE_PACKET_BASED’
undeclared (first use in this function)

I remove this patch, please fix this.

	Gustavo
