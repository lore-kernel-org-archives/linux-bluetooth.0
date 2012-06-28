Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 16:48:06 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: btmrvl: Do not send vendor events to
 bluetooth stack
Message-ID: <20120628134803.GC14705@aemeltch-MOBL1>
References: <477F20668A386D41ADCC57781B1F7043083A8A6E5F@SC-VEXCH1.marvell.com>
 <1339740654-5930-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120619032630.GE1679@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120619032630.GE1679@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jun 19, 2012 at 12:26:30AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-15 09:10:54 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Vendor-specific events shall be processed in driver and not sent
> > to bluetooth stack where they screw up HCI command countings.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > Tested-by: Bing Zhao <bzhao@marvell.com>
> > ---
> >  drivers/bluetooth/btmrvl_drv.h  |    2 +-
> >  drivers/bluetooth/btmrvl_main.c |   18 +++++++++++++++---
> >  drivers/bluetooth/btmrvl_sdio.c |    9 ++++++---
> >  3 files changed, 22 insertions(+), 7 deletions(-)
> 
> Patch has been applied to the bluetooth tree. Thanks.

Which version have you applied? Old one?

Best regards 
Andrei Emeltchenko 
