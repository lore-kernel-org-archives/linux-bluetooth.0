Return-Path: <aklish1@urbana.css.mot.com>
Date: Thu, 23 Oct 2003 17:08:21 -0500 (CDT)
From: Aaron Klish <aklish1@urbana.css.mot.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: setsockopt for RFCOMM
In-Reply-To: <1066889032.18996.28.camel@pegasus>
Message-ID: <Pine.GSO.4.20.0310231659530.15561-100000@wombat.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,
  I didn't explain myself well.  The subject of my mail was also incorrect.  
Suggesting exposing credit and RFCOMM frame size to user space has nothing to do
with the Rfcomm TTY data loss I have observed.  Therefore, I'm changing the subject of 
this thread to "setsockopt for RFCOMM".

The MTU I was referring to in my email was not the L2CAP MTU that Rfcomm initializes for PSM 3.

I was referring to the "Maximum Frame Size" defined in GSM 7.10 specification in
section 5.1.8.1.1.

This is the part of the PN negotiation in core.c:

        pn->mtu = htobs(d->mtu);

in function rfcomm_send_pn.

This Maximum Frame Size is separate than the L2CAP MTU negotiated.   The Maximum Frame
Size cannot exceed the L2CAP MTU negotiated, but it can certainly be less.

The reason we are interested in changing these values (credit and Max Frame Size)
is not for performance but to limit memory.

When RFCOMM sends a PN, it is advertising an abstract "buffer size" which equals
the number of credits * the Maximum Frame Size.

Currently, this abstract "buffer" is defined at compile time.  To customize it
for a given product, requires modifying the kernel or modules.  Furthermore,
this "buffer" is currently the same size for all services.  

It would be nice to be able to configure this without having to recompile
and to customize it on a per service basis.

Aaron 

------------
Aaron Klish
Bluetooth Software Engineer
Motorola PCS
PH# (217) 384-8598
FX# (217) 384-8550

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary

On 23 Oct 2003, Marcel Holtmann wrote:


> Hi Aaron,
> 
> >   Are there any plans in the future to allow control of RFCOMM MTU and credits from user space?
> > I'm using 2.4.20 (mh9 patch) and these parameters are currently assigned default values in the kernel.
> > L2CAP already has an option to control MTU through setsockopt.  It seems like adding control
> > for parameters for RFCOMM would be a good feature - perhaps also through setsockopt?   Any thoughts
> > on this?  Thanks.
> 
> the Linux implementation of RFCOMM is a stream and so it don't have a
> MTU. You have the in and out MTU of the underlaying L2CAP PSM 3 and we
> try to set them to 1024 by default. We have talked about this some time
> ago (look at the archive) and there is no proof that having a different
> L2CAP MTU improves the performance of RFCOMM.
> 
> The credits are not for the user space, because they are only used for
> the flow control. These kind of stuff must be handled by the RFCOMM
> layer and nobody should have to worry about it. If there is a problem
> with it, we have to fix it in the RFCOMM layer itself.
> 
> Regards
> 
> Marcel
> 
> 
