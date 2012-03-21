Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Mar 2012 09:45:17 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: reverse SDP issue
Message-ID: <20120321124517.GB8888@x220>
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
 <20120319230436.GA27304@x220>
 <20120320173546.GA6307@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120320173546.GA6307@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Mar 20, 2012, Vinicius Costa Gomes wrote:
> > As for the partial service removal changes to the device driver API, it
> > looks pretty messy to me. Is there any reason why we couldn't just
> > restrict calling remove() for when removing the entire device object
> > (and never call it when doing subsequent service discoveries)?
> 
> I agree that the logic is quite messy. Just some comments:
> 
> That assumes that the service list that a device implements is very much
> static, which only breaks for development (in which the services of an 
> device are always changing) and you will need to remove that device and 
> create it again.

We would still be able to handle added UUIDs just fine. The only issue
is with removed services in which case you'd just wouldn't be able to
connect to the remote device through the corresponding D-Bus interface
(something which can already now happen and which I think is ok).

Johan
