Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Andrei Emeltchenko'" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <005201cca4e0$e2467680$a6d36380$@org> <20111117094539.GC415@aemeltch-MOBL1>
In-Reply-To: <20111117094539.GC415@aemeltch-MOBL1>
Subject: RE: [PATCH v3 bluez 2/2] Add A2MP definitions
Date: Thu, 17 Nov 2011 11:05:51 -0800
Message-ID: <006301cca55b$ec7f6280$c57e2780$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei,

> > +
> > +/* AMP controller type */
> > +#define AMP_CTRL_BR_EDR		0x00
> > +#define AMP_CTRL_802_11		0x01
> 
> Do we need to define those values? Cannot you use already defined ones in
> hci.h?

You're right, I'll remove them.

> in include/net/bluetooth/hci.h and lib/hci.h
> /* HCI controller types */
> #define HCI_BREDR       0x00
> #define HCI_AMP         0x01
> 
> Maybe HCI_AMP is not the best way and at some point we might need to
> rename it according to BT Spec assigned numbers (like HCI_AMP_802_11)

Agreed it should be changed to reflect 802.11.

> Otherwise
> 
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Regards,

Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


