Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 23:02:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add public/random LE address information
 to mgmt messages
Message-ID: <20111116210236.GA879@x220.Elisa>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
 <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
 <20111116171629.GA16865@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116171629.GA16865@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Nov 16, 2011, Gustavo Padovan wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> > 
> > It's necessary to know the distinction between public and random LE
> > addresses so the mgmt interface also needs to distinguish between them.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |   14 ++++++++------
> >  include/net/bluetooth/mgmt.h     |    4 ++--
> >  net/bluetooth/hci_event.c        |   21 ++++++++++++---------
> >  net/bluetooth/mgmt.c             |   35 ++++++++++++++++++++++-------------
> >  4 files changed, 44 insertions(+), 30 deletions(-)
> 
> This patch doesn't apply anymore, please rebase.

It doesn't apply because it's already in your tree :)
commit 48264f06943e2db2c971b752949606f070d9d292

Johan
