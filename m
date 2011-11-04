Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Nov 2011 09:47:55 +0200
From: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 00/20] RFC A2MP implementation
Message-ID: <20111104074747.GA1313@aemeltch-MOBL1>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <000f01cc9a87$94d0dc00$be729400$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000f01cc9a87$94d0dc00$be729400$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Nov 03, 2011 at 05:20:38PM -0700, Peter Krystad wrote:
> 
> Hi Andrei,
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > RFC meant to indicate our current development status.
> > 
> > Code based on Code Aurora (git://codeaurora.org/kernel/msm.git) and
> Atheros
> > (search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux
> BT3)
> > implementations (mostly Code Aurora). Main difference to the original code
> is
> > - code rebase against recent bluetooth-next
> > - rewritten way to send A2MP msgs
> > - handling fixed channel modifications
> > - I was trying to separate AMP vs A2MP name usage. AMP is used for
> > "Alternate MAC PHY" controller, A2MP for "AMP Manager Protocol".
> > - fixes related to PTS beta A2MP tests
> 
> I think your approach looks fine so far. Do you plan to continue on with
> adding detail to the patches in this series or will just do cleanup on them
> and then prepare another set?

I was thinking about rebasing first against recent bluetooth-next (since
my code was based upon a bit different approach (like fixed channel
features list patch).

Then I am planning to add some details to A2MP message
processing. Those I could test and verify with PTS "beta A2MP" tests.

After that I was thinking about adding physlink structure (at least
heplers) and then make interface to create fake/virtual AMP so that I
could use it for A2MP Discover, etc. (maybe we could use real wifi cheap
for e.g. AMPAssoc data).

What are your plans?

Best regards 
Andrei Emeltchenko 

