Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Dec 2011 11:34:14 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 2/6] Bluetooth: Split ctrl init to BREDR and AMP parts
Message-ID: <20111205093413.GB23614@aemeltch-MOBL1>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322139125-22377-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111202115025.GD2570@joana>
 <20111202115633.GC12339@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111202115633.GC12339@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Dec 02, 2011 at 01:56:39PM +0200, Emeltchenko Andrei wrote:
> Hi Gustavo,
> 
> On Fri, Dec 02, 2011 at 08:50:25PM +0900, Gustavo Padovan wrote:
> > Hi Andrei,
> > 
> > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-24 14:52:01 +0200]:
> > 
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > Current controller initialization is moved tp bredr_init and new
> > > function added amp_init to handle later AMP init sequence. Current
> > > AMP init sequence include Reset and Read Local Version.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/hci_core.c  |   64 ++++++++++++++++++++++++++++++++------------
> > >  net/bluetooth/hci_event.c |    3 ++
> > >  2 files changed, 49 insertions(+), 18 deletions(-)
> > 
> > For some reason this patch doesn't apply, please rebase.
> 
> Have you tried the more recent version:
> PATCHv2 2/8] Bluetooth: Split ctrl init to BREDR and AMP parts

One thought might be that the patch "Remove old code" which is 1/8 shall
be applied first. It is better to apply patches in order they are made.

Best regards 
Andrei Emeltchenko 

