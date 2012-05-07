Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 10:57:39 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: mgmt: Fix device_connected sending order
Message-ID: <20120507175739.GA5708@x220.hpllc.com>
References: <1336127870-5930-1-git-send-email-johan.hedberg@gmail.com>
 <1336128329-6650-1-git-send-email-johan.hedberg@gmail.com>
 <1336320975.5970.85.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336320975.5970.85.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, May 06, 2012, Marcel Holtmann wrote:
> > The mgmt_ev_device_connected signal must be sent before any event
> > indications happen for sockets associated with the connection. Otherwise
> > e.g. device authorization for the sockets will fail with ENOTCONN as
> > user space things that there is no baseband link.
> > 
> > This patch fixes the issue by ensuring that the device_connected event
> > if sent (if it hasn't been so already) as soon as the first ACL data
> > packet arrives from the remote device.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > v2: Fixed missing hdev locking
> > 
> >  net/bluetooth/hci_core.c  |    8 ++++++++
> >  net/bluetooth/hci_event.c |    4 ++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Thanks. The patch is now in bluetooth.git.

Johan
