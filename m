Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jan 2011 19:59:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
Message-ID: <20110125175922.GA16442@jh-x301>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
 <20101203220534.GA16709@eris>
 <1295895817.2656.26.camel@ubuntuLab1>
 <20110124213429.GA15121@piper>
 <AANLkTi=uByqBUVKD8UYwt5ZByvHwu6WpapG=BtUrFkzE@mail.gmail.com>
 <1295974727.2656.57.camel@ubuntuLab1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295974727.2656.57.camel@ubuntuLab1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Jan 25, 2011, Brian Gix wrote:
> >From Page 607:
> "If both devices have out of band authentication data, then the
> Authentication Requirements Flags shall be ignored when selecting the
> pairing method and the Out of Band pairing method shall be used. If both
> devices have not set the MITM option in the Authentication Requirements
> Flags, then the IO capabilities shall be ignored and the Just Works
> association model shall be used. Otherwise the IO capabilities of the
> devices shall be used to determine the pairing method as defined in
> Table 2.4."
> 
> In the test case I ran, only One device (i.e. NOT BOTH) had the MITM
> option set. So my reading is that the IO Capabilities should be ignored,
> and JUST_WORKS used.

It certainly is an unusual form of English. It's saying "If both devices
have <x>", i.e. the condition <x> needs to be fulfilled by both devices
for the statement to be true. In this case the condition is "not set the
MITM option", i.e. both devices need to fulfill the condition "not set
the MITM option". Doesn't that then mean that it's not enough for one
device to not set the MITM flag, but both devices need to have it unset
for just-works to take place?

Johan
