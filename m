Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 15:00:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Use correct flags for checking HCI_SSP_ENABLED bit
Message-ID: <20120328120039.GA8590@x220>
References: <1332934749-12765-1-git-send-email-hemant.gupta@stericsson.com>
 <1332935216.1870.165.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332935216.1870.165.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 28, 2012, Marcel Holtmann wrote:
> Hi Hemant,
> 
> > This patch uses the correct flags for checking the HCI_SSP_ENABLED bit.
> > Without this authentication request was not being initiated.
> > 
> > Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> > ---
> >  include/net/bluetooth/hci_core.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Applied to both bluetooth and bluetooth-next. Thanks.

Johan
