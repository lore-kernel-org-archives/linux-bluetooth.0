Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 07:38:58 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Kernal/User space change for LE Random Addresses
Message-ID: <20110209153858.GA27340@jh-x301>
References: <4D51D8AE.9020005@codeaurora.org>
 <AANLkTimiJ2sP8yrpnk3=Hjo6XrVoEuRbmYE2H=UsKAA7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimiJ2sP8yrpnk3=Hjo6XrVoEuRbmYE2H=UsKAA7@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Feb 09, 2011, Claudio Takahasi wrote:
> An address/advertising cache will be added in the kernel, if the given
> address is found in the cache the two most significant bits will be
> checked to infer the address type,

For the public vs random address detection you need to use the address
type info in the advertising report. Only when you've determined that
the address is random will the two bits make sense. So far the only use
I can think of for these bits is to determine whether it's useful to try
to perform a lookup in our IRK list (e.g. for a non-resolvable private
key that wouldn't make sense). Are there any other uses?

> otherwise the fallback will be BR/EDR. For BR/EDR L2CAP SOCK_SEQPACKET
> sockets PSM is always provided, we can also use this information to
> distinguish BR/EDR from LE address if an advertising has not been
> detected previously.

I think we could still keep the current CID based decision on the kernel
side. If the CID implies LE but we don't have a match for the address in
the cache we just return an error to user space.

Johan
