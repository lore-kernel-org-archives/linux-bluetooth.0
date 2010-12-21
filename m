Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 0/1] Implement Compound (Multi-step) GATT Procedure
 Support
From: Brian Gix <bgix@codeaurora.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: vinicius.gomes@openbossa.org, linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTin8BHWOhpnv36ncteMNRfXwU81r17owAAaixiD-@mail.gmail.com>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
	 <1292952355.14993.9.camel@sealablnx02.qualcomm.com>
	 <AANLkTin8BHWOhpnv36ncteMNRfXwU81r17owAAaixiD-@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 21 Dec 2010 11:50:59 -0800
Message-ID: <1292961059.14993.47.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Caudio,

On Tue, 2010-12-21 at 16:25 -0300, Claudio Takahasi wrote:
> Hi Brian,
> 
> On Tue, Dec 21, 2010 at 2:25 PM, Brian Gix <bgix@codeaurora.org> wrote:
> > Hi Claudio & Vinicius,
> >
> >
> > On Fri, 2010-12-17 at 14:48 -0800, Brian Gix wrote:
> >> The following two proposed patches implement a method for correctly
> >> staging GATT procedures that require multiple ATT req/resp exchanges.
> >
> > If you guys get a chance, could you consider this proposed change
> > to gattrib.[ch] and the subsequent change to gatt.c? It differs from my
> > initial proposed patch which subverted the gattrib queuing mechanism. It
> > now lets each ATT command run to completion. It also fixes the memory
> > leak potential that Vinicius spotted.  I think it is important that you
> > give it at least a cursory look, because you guys know more about bluez
> > GATT than anyone else here at this point.  Otherwise, I will resubmit
> > this version as a patch request. -- thx
> >
> 
> ok. We can review your patches.
> Could you please send patches to change gatttool to support this new feature?
> How are you testing it? Do you have a modified BlueZ attribute server
> or another GATT server?

There are no changes required to gatttool. The implemented high level
function is still to read an attribute, and the function works the same
if the remote attribute is shorter than 22 octets, and will be "long"
only if the first response indicates a remote attribute of 22 octets or
longer. (accounting for the one octet for the response hdr)

I am testing this against against the internal Qualcomm GATT server,
which has been tested at the past two UPFs. This is also the same stack
which I hope to use to pre-vet the SM changes you are leading, prior to
the UPF in Las Vegas.

As my next task, I could implement the capability to support long reads
in the BlueZ GATT server. (likely followed by long writes in both the
GATT client and server of BlueZ)

> 
> Claudio

Thanks,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

