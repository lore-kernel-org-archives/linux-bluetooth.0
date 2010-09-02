Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 16:51:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, arunkr.singh@stericsson.com
Subject: Re: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <20100902135108.GA30759@jh-x301>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1282911133.835.30.camel@localhost.localdomain>
 <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
 <20100827124524.GA9484@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114480979219655@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480979219655@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Sep 02, 2010, Waldemar.Rymarkiewicz@tieto.com wrote:
> I've completed more tests on the patches and didn't faced any problems
> do far.  Legacy paring, ssp, sec mode 3, refresh existing keys and
> security upgrading have finished with success. I did the tests for
> bluez as initiator and again when bluez was an acceptor. All tests
> were done against different controllers CSR (1.1, 2.0, 2.1), Broadcom
> (2.0, 2.1), ST-Ericsson (2.1). I also tried different combinations of
> the controllers in the same use case.
> 
> So, I'm pretty sure that it will not introduce any regression. 

Ok, that's good to hear.

> Aditionally, we plan to bring this to the UPF and it would be
> appreciated if  also other would have that possibility for regression
> testing.

I'll be at the UPF too, so this might be possible.

> If it comes to interaction with the agent I would do this in a
> seperate patch which will contain a new property when 16 digit pin
> code is required.

That's fine.

> I attached slightly updated patches.

Thanks. However, the kernel patch and new ioctl will need comments at
least from Marcel. Once we add an ioctl we're stuck with it for quite
some time and have to maintain it, no matter what kind of newer/better
kernel-userspace interfaces we come up with. So the choice of accepting
a new ioctl isn't so easy.

One thing that you'd definitely need to fix in your patches is to keep
at least the same level of support that the current BlueZ has with
kernels that don't have the new ioctl. Right now your patch would make
legacy pairing fail in such cases which is not acceptable. Only with a
major version change (5.x) would it be possible to consider requiring a
newer kernel version in order to have essential functionality in place.

With all this in mind I'd still prefer it if we postpone the feature
addition until the point where we have a more flexible kernel-userspace
API in place and most of the security logic and information on the
kernel side.

Johan
