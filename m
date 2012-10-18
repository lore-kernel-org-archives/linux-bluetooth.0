Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 13:44:46 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 0/8] Handling physical and logical link
Message-ID: <20121018104444.GH13545@aemeltch-MOBL1>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350493622.26318.114.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350493622.26318.114.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Wed, Oct 17, 2012 at 10:07:02AM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Set of patches adding handling for physical and logical link
> > complete events.

Those patches depends on 1st patch from Mat last series.

> > Andrei Emeltchenko (8):
> >   Bluetooth: AMP: Process Physical Link Complete evt
> >   Bluetooth: AMP: Process Logical Link complete evt
> >   Bluetooth: Add logical link create function
> >   Bluetooth: AMP: Process Disc Logical Link
> >   Bluetooth: AMP: Process Disc Physical Link complete evt
> >   Bluetooth: AMP: Remove hci_conn receiving error command status
> >   Bluetooth: Disconnect logical link when deleteing chan
> >   Bluetooth: Add put(hcon) when deleting hchan
> 
> I looked over the patches and the look fine to me.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Marcel, I will keep you ack even with some rather cosmetic change.

Best regards 
Andrei Emeltchenko 
