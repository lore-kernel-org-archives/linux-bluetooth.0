Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 6 Dec 2017 15:07:26 -0800
From: Kyle McMartin <kyle@infradead.org>
To: linux-firmware@kernel.org
Cc: Josh Boyer <jwboyer@kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        Thomas Backlund <tmb@mageia.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        "matt.chen@intel.com" <matt.chen@intel.com>
Subject: Re: [PATCH 1/4] linux-firmware: Add firmware file for Intel
 Bluetooth 9560
Message-ID: <20171206230726.GD1875@bombadil.infradead.org>
References: <20171130101838.69b51124@tedd-ubuntu-vm>
 <CA+5PVA5ViRVRG53TSvUDOKcTx8pFV2FcmNaVcuEebB22xqE9eg@mail.gmail.com>
 <CA+5PVA4B3p4JVwbGktzZtj9u1D337LdiQz1WavJO-U9NiGa4fg@mail.gmail.com>
 <20171206223353.GC1875@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171206223353.GC1875@bombadil.infradead.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 06, 2017 at 02:33:53PM -0800, Kyle McMartin wrote:
> On Tue, Dec 05, 2017 at 05:25:58PM -0500, Josh Boyer wrote:
> > Kyle, Ben, do you have any ideas on this?
> > 
> 
> As I mentioned on IRC, this has happened before. (I'm inclined to blame
> Intel's mail servers. ;-)
> 
> The problem is with the GIT binary patch headers, which look for the
> format to be preserved, but some newlines are in the wrong place in
> Tedd's email.
> 
> I'll revert and fix these up, and then work on the back log.
> 
> Thanks for your help and voluteering, Josh!
> 

OK, Tedd, I've applied 1-4. Can you verify that I didn't corrupt any of
them when fixing up the binary diffs?

regards, Kyle
