Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 14:35:46 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: reverse SDP issue
Message-ID: <20120320173546.GA6307@samus>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
 <20120319230436.GA27304@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120319230436.GA27304@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 20:04 Mon 19 Mar, Johan Hedberg wrote:
> Hi Mike,
> 
> On Mon, Mar 19, 2012, Mike wrote:
> > I notice a change in commit d2920be715974795b51f9cc3279947104da3647b
> > [1] that changes the "reverse" variable for an SDP query:
> > 
> >  -       device_browse_sdp(device, NULL, NULL, NULL, TRUE);
> > +       if (device_is_bredr(device))
> > +               device_browse_sdp(device, NULL, NULL, NULL, FALSE);
> > +       else
> > +               device_browse_primary(device, NULL, NULL, FALSE);
> > 
> > You can see the original had reverse as TRUE, but the patch may have
> > inadvertently changed it to FALSE..kernel.org/majordomo-info.html
> 
> That looks like a definitive bug. Good that you caught it. Vinicius
> (author of the commit) care to comment?

It was changed to false by mistake, a patch to fix it should be arriving
on the mailing list in a few moments.

The comment on src/device.c around line 1683 gives some hints on what
my mistake may have caused: it could be that the device while connected
"hides" some items from its service record. So with reverse set to
false, some records that are present are being removed by mistake.

> 
> As for the partial service removal changes to the device driver API, it
> looks pretty messy to me. Is there any reason why we couldn't just
> restrict calling remove() for when removing the entire device object
> (and never call it when doing subsequent service discoveries)?

I agree that the logic is quite messy. Just some comments:

That assumes that the service list that a device implements is very much
static, which only breaks for development (in which the services of an 
device are always changing) and you will need to remove that device and 
create it again.

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
