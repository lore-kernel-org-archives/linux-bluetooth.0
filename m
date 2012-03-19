Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Mar 2012 20:04:36 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: reverse SDP issue
Message-ID: <20120319230436.GA27304@x220>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Mon, Mar 19, 2012, Mike wrote:
> I notice a change in commit d2920be715974795b51f9cc3279947104da3647b
> [1] that changes the "reverse" variable for an SDP query:
> 
>  -       device_browse_sdp(device, NULL, NULL, NULL, TRUE);
> +       if (device_is_bredr(device))
> +               device_browse_sdp(device, NULL, NULL, NULL, FALSE);
> +       else
> +               device_browse_primary(device, NULL, NULL, FALSE);
> 
> You can see the original had reverse as TRUE, but the patch may have
> inadvertently changed it to FALSE..kernel.org/majordomo-info.html

That looks like a definitive bug. Good that you caught it. Vinicius
(author of the commit) care to comment?

As for the partial service removal changes to the device driver API, it
looks pretty messy to me. Is there any reason why we couldn't just
restrict calling remove() for when removing the entire device object
(and never call it when doing subsequent service discoveries)?

Johan
