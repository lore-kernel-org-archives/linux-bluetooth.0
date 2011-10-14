Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 14:15:17 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 14/16] Bluetooth: EWS: define L2CAP header sizes
Message-ID: <20111014111516.GB32656@aemeltch-MOBL1>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318329476-30153-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111013195535.GD20892@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013195535.GD20892@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 13, 2011 at 04:55:35PM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-11 13:37:54 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Adds definitins for L2CAP header sizes to be uses when calculating
> > payload size instead of magic numbers.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> Applied, Thanks. Please fix patch 11 and rebase the others so I can apply
> everything.

Sorry for noticing it late, could you rearrange that patch so that it
comes before "Bluetooth: EWS: recalculate L2CAP header size" 
(PATCHv3 12/16)

Best regards 
Andrei Emeltchenko 
