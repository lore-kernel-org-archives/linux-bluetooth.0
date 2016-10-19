Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 19 Oct 2016 20:15:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, puthik@chromium.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] doc/device-api: Add AdvertisingFlags
Message-ID: <20161019171558.GA16713@x1c.P-661HNU-F1>
References: <1476817861-24158-1-git-send-email-puthik@chromium.org>
 <1476817861-24158-3-git-send-email-puthik@chromium.org>
 <CABBYNZ+_E_T-iDXQMDteZQKg+qmkZhyiPRZnX-j-UgzvUvk0ow@mail.gmail.com>
 <CAAEJBh+vOrDA_bbj7e8zhyZS+0pWBnN7wOa0Huv3PGkDWUwvSA@mail.gmail.com>
 <CABBYNZJMncaA0pgOx5DvGS5=Mfy=Q0bp=CfPDKtg2Bif7rB-gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJMncaA0pgOx5DvGS5=Mfy=Q0bp=CfPDKtg2Bif7rB-gQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 19, 2016, Luiz Augusto von Dentz wrote:
> > Hmm I wonder.. why not just expose full AD + SCAN_RSP this way?
> > Are we going to add prop for every data type?
> 
> Then there is no reason to parse the AD, and even broken/unknown AD
> should be send which sounds like a very dangerous think to do so Id
> leave this for application that can deal with the management socket
> but not over D-Bus.

I'm not so sure about this (having a "raw" AD/EIR API). We don't
necessarily need to expose the raw data as such, but it could be a
dictionary where the key is the data type and the value a byte array.
That'd at least prevent common pitfalls with broken parsing.

We could also consider making this a subscription based thing so that
it's not a broadcast signal but either a unicast signal or a method call
to whomever has requested to receive the information. Side note: I think
the approach the bus1 folks would like to take is to get rid of
broadcast signals completely and rely on a service-based subscription
mechanism.

Johan
