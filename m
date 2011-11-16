Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 23:05:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Create a unique mgmt error code hierarchy
Message-ID: <20111116210535.GA1043@x220.Elisa>
References: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
 <1321027800-353-1-git-send-email-johan.hedberg@gmail.com>
 <20111116181100.GF16865@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116181100.GF16865@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Nov 16, 2011, Gustavo Padovan wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> > 
> > The management protocol uses a single byte for error codes (aka command
> > status). In some places this value is directly copied from HCI and in
> > other a POSIX error number is used. This makes it impossible for
> > user-space to uniquily decipher the meaning of an error.
> > 
> > To solve this issue a new mgmt-specific set of error codes is added
> > along with a conversion table for HCI status values.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > v2: Use ARRAY_SIZE() instead of a custom NELEM()
> > 
> >  include/net/bluetooth/mgmt.h |   17 +++
> >  net/bluetooth/mgmt.c         |  315 ++++++++++++++++++++++++++++++------------
> >  2 files changed, 241 insertions(+), 91 deletions(-)
> 
> It doesn't apply anymore, please rebase.

This one's also already in your tree.
commit ca69b7957bf2e3bc0acc882b837a42617498ece1

Johan
