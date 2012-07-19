Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 10:56:40 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Fix managing AMP device
Message-ID: <20120719075639.GD26057@aemeltch-MOBL1>
References: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1340971622-16318-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120719073945.GA7612@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120719073945.GA7612@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jul 19, 2012 at 10:39:45AM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, Jun 29, 2012, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > AMP device shall not be managed by user space for now.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |    2 +-
> >  net/bluetooth/hci_core.c         |    6 ++++--
> >  net/bluetooth/mgmt.c             |   20 ++++++++++++++++++--
> >  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> 
> Though you could have made a bit more descriptive commit message.

I will write more and this patch together with other patches.

Best regards 
Andrei Emeltchenko 

