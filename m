Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Johan Hedberg <johan.hedberg@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach: Add support for Intel Bluetooth device
Date: Tue, 15 May 2012 10:26:40 -0700
Message-ID: <1507913.3W6pHHIlAc@tedd-ubuntu>
In-Reply-To: <20120515074634.GA19482@x220>
References: <32612923.A9jgX3dogm@tedd-ubuntu> <1337044988.5970.244.camel@aeonflux> <20120515074634.GA19482@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Johan.

I just sent a patch via "git send-email". I hope this will work at this time.

Thanks.

Tedd

On Tuesday, May 15, 2012 10:46:34 AM Johan Hedberg wrote:
> Hi Marcel,
> 
> On Mon, May 14, 2012, Marcel Holtmann wrote:
> > > This patch enables the Intel Bluetooth device (UART sku) over the H4 protocol.
> > > It is responsible for bring up the device into known state by configuring
> > > the baudrate and applying the patches, if required.
> > > 
> > > ---
> > >  Makefile.tools          |    3 +-
> > >  tools/hciattach.8       |    3 +
> > >  tools/hciattach.c       |   13 ++
> > >  tools/hciattach.h       |    1 +
> > >  tools/hciattach_intel.c |  596 
> > > +++++++++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 615 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/hciattach_intel.c
> > 
> > looks good to me.
> > 
> > Johan, feel free to apply this patch.
> 
> Looks ok to me too, except that it doesn't apply:
> 
> Applying: hciattach: Add support for Intel Bluetooth device
> fatal: corrupt patch at line 16
> Patch failed at 0001 hciattach: Add support for Intel Bluetooth device
> 
> As you can see even from the diffstat Tedd's email client is splitting
> long lines. Please try to use git send-email to resend or fix your mail
> client not to mangle the patch.
> 
> Johan
-- 
Regards
Tedd Ho-Jeong An
Intel Corporation
