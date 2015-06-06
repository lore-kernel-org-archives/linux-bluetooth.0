Return-Path: <cyrus@holtmann.org>
Message-ID: <1433604913.4256.4.camel@gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference
From: chanyeol <chanyeol.park@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: jaganath.k@samsung.com, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>
Date: Sun, 07 Jun 2015 00:35:13 +0900
In-Reply-To: <8D659FE1-24A7-43CF-9A85-F4C2C2A32DB9@holtmann.org>
References: <1937969015.163941431584025200.JavaMail.weblogic@ep2mlwas03a>
	 <8D659FE1-24A7-43CF-9A85-F4C2C2A32DB9@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, 2015-05-14 at 08:34 +0200, Marcel Holtmann wrote:
> Hi Jaganath,
> 
> > > > addr can be NULL and it should not be dereferenced before NULL 
> > > > checking.
> > > > 
> > > > Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> > > > ---
> > > 
> > > if we start changing things here, then we better change the code 
> > > into something that all the other socket handling code is doing 
> > > anyway>y. So do the min comparison and copy the data into a local 
> > > copy of the sockaddr_rc.
> > > 
> > > And on a side note, I wonder if addr can actually be NULL. It 
> > > might be interesting to check the generic socket code if this 
> > > really can happe>n if you provide no address structure to the 
> > > bind() system call or if this gets filtered out by the core 
> > > socket code.
> > 
> > I checked generic socket code and it looks like addr will never be 
> > NULL when user space calls bind.
> > But this can be called from kernel_bind() also which I think will 
> > never be called for RFCOMM.
> > So this patch is not required? 
> 
> that is what I thought. However converting it to the same handling 
> using min and copying into local storage might be a good idea.
Could you tell us why this is good idea? I failed to find it in git
history/mailing list.

In addition to RFCOMM connect that you mentioned, I found out SCO
connect/bind still use the old style in Bluetooth unlikely HCI,L2CAP.

Regards
Chanyeol

>  The more pieces in HCI, L2CAP, SCO and RFCOMM sockets that are 
> similar, the better.
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux
> -bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
