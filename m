Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 May 2013 15:51:49 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Fix not sending link key negative reply
Message-ID: <20130507125147.GB5800@aemeltch-MOBL1>
References: <20130507060630.GA3766@x220.ger.corp.intel.com>
 <1367923915-6421-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20130507111436.GA11154@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130507111436.GA11154@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, May 07, 2013 at 02:14:36PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Tue, May 07, 2013, Andrei Emeltchenko wrote:
> > If Link Keys are not loaded during initialization with
> > MGMT_OP_LOAD_LINK_KEYS command then pairing always fails
> > since HCI_LINK_KEYS is not set. Check instead for HCI_MGMT
> > flag.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> > *v2 modified patch following Johan's comments
> 
> The existing behavior is intentional with the implicit assumption that a
> mgmt_load_link_keys will always be received, if only to set the debug
> keys flag in case of no link keys. 

There is a valid case that there is no bonded devices and we leave default
debug flags. In that case pairing always fails.

For example I need to execute "dummy link keys loading" just to be able to pair.

Best regards 
Andrei Emeltchenko 

