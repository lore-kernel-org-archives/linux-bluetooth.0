Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 10:46:34 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciattach: Add support for Intel Bluetooth device
Message-ID: <20120515074634.GA19482@x220>
References: <32612923.A9jgX3dogm@tedd-ubuntu>
 <1337044988.5970.244.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337044988.5970.244.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, May 14, 2012, Marcel Holtmann wrote:
> > This patch enables the Intel Bluetooth device (UART sku) over the H4 protocol.
> > It is responsible for bring up the device into known state by configuring
> > the baudrate and applying the patches, if required.
> > 
> > ---
> >  Makefile.tools          |    3 +-
> >  tools/hciattach.8       |    3 +
> >  tools/hciattach.c       |   13 ++
> >  tools/hciattach.h       |    1 +
> >  tools/hciattach_intel.c |  596 
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 615 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/hciattach_intel.c
> 
> looks good to me.
> 
> Johan, feel free to apply this patch.

Looks ok to me too, except that it doesn't apply:

Applying: hciattach: Add support for Intel Bluetooth device
fatal: corrupt patch at line 16
Patch failed at 0001 hciattach: Add support for Intel Bluetooth device

As you can see even from the diffstat Tedd's email client is splitting
long lines. Please try to use git send-email to resend or fix your mail
client not to mangle the patch.

Johan
