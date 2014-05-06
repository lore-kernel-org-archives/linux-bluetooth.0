Return-Path: <cyrus@holtmann.org>
Message-ID: <1399383225.2316.11.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH 2/3] Bluetooth: 6LoWPAN: Allow user to set the device
 role via sysfs
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 06 May 2014 16:33:45 +0300
In-Reply-To: <6BAA298A-CBCB-4729-BD82-9B0E3AB476E9@holtmann.org>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1399282285-32743-3-git-send-email-jukka.rissanen@linux.intel.com>
	 <6BAA298A-CBCB-4729-BD82-9B0E3AB476E9@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-05-05 at 19:13 -0700, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > This is temporary patch that will eventually disappear when
> > the 6LoWPAN device services can be discovered automatically.
> > 
> > Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> > ---
> > include/net/bluetooth/hci.h      |  1 +
> > include/net/bluetooth/hci_core.h |  1 +
> > net/bluetooth/hci_core.c         | 53 ++++++++++++++++++++++++++++++++++++++++
> > net/bluetooth/hci_event.c        |  3 +++
> > 4 files changed, 58 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 4261a67..3060254 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -140,6 +140,7 @@ enum {
> > 	HCI_FAST_CONNECTABLE,
> > 	HCI_BREDR_ENABLED,
> > 	HCI_6LOWPAN_ENABLED,
> > +	HCI_6LOWPAN_ROLE_NODE,
> > 	HCI_LE_SCAN_INTERRUPTED,
> > };
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index d73f418..3cf9c45 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -510,6 +510,7 @@ enum {
> > 	HCI_CONN_POWER_SAVE,
> > 	HCI_CONN_REMOTE_OOB,
> > 	HCI_CONN_6LOWPAN,
> > +	HCI_CONN_6LOWPAN_ROLE_NODE,
> > };
> 
> I really want this confined to bluetooth_6lowpan.ko module. So the all the HCI flags need to go away. Especially with this being on connection oriented channels now, there is really no point in having this in the HCI layer. This becomes an high layer L2CAP protocol problem.

Ok, I was hoping we first get the stuff in, and then next patches would
create a separate 6lowpan module. But I can prepare a separate module
creation into this patchset also.


Cheers,
Jukka


