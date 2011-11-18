Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 20:50:45 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
Message-ID: <20111118235045.GB17225@samus.indt.org>
References: <4EC6A13B.5030805@codeaurora.org>
 <1321643339.15441.622.camel@aeonflux>
 <4EC6B8F0.2040904@codeaurora.org>
 <20111118201213.GA22216@x220.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111118201213.GA22216@x220.ger.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 22:12 Fri 18 Nov, Johan Hedberg wrote:
> Hi Brian,
> 
> On Fri, Nov 18, 2011, Brian Gix wrote:
> > I would support migrating ATT to the kernel.
> 
> Same here.
> 
> > In fact another issue I have dealt with is ensuring during Pairing,
> > that we are able to at least respond with minimal Error responses if
> > someone tries to read our name, and there is no GATT client socket to
> > user space to respond.
> 
> This issue was already encountered during the last UPF and INdT has a
> fix for it. For whatever reason that fix doesn't seem to have showed up
> here on the mailing list for upstreaming. 

For that to work, and have a matching userspace and kernel, it needs proper 
support for pairing, i.e. "re-using" a LE link that was used for SMP for 
GATT requests. Those patches are being tested right now, they should
appear on the list soon.

> In general the capability of
> doing ATT signaling should be available as soon as we have a connection
> handle, and it should be independent of any ongoing SMP procedure. Only
> if the characteristic accessed requires higher security than is
> currently provided by the LE link should the ATT procedures fail with an
> error. In the use case you describe, since the Name characteristic
> doesn't have any special security requirements a request for it should
> be always responded to with a positive reply regardless of the current
> level of security or if there's an ongoing SMP operation.
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
