Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC6BDC0.5030205@codeaurora.org>
Date: Fri, 18 Nov 2011 12:19:12 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC] LE: Low Latency GATT Write-Sign-Cmd
References: <4EC6A13B.5030805@codeaurora.org> <1321643339.15441.622.camel@aeonflux> <4EC6B8F0.2040904@codeaurora.org> <20111118201213.GA22216@x220.ger.corp.intel.com>
In-Reply-To: <20111118201213.GA22216@x220.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/18/2011 12:12 PM, Johan Hedberg wrote:
> Hi Brian,
>
> On Fri, Nov 18, 2011, Brian Gix wrote:
>> I would support migrating ATT to the kernel.
>
> Same here.
>
>> In fact another issue I have dealt with is ensuring during Pairing,
>> that we are able to at least respond with minimal Error responses if
>> someone tries to read our name, and there is no GATT client socket to
>> user space to respond.
>
> This issue was already encountered during the last UPF and INdT has a
> fix for it. For whatever reason that fix doesn't seem to have showed up
> here on the mailing list for upstreaming. In general the capability of
> doing ATT signaling should be available as soon as we have a connection
> handle, and it should be independent of any ongoing SMP procedure. Only
> if the characteristic accessed requires higher security than is
> currently provided by the LE link should the ATT procedures fail with an
> error. In the use case you describe, since the Name characteristic
> doesn't have any special security requirements a request for it should
> be always responded to with a positive reply regardless of the current
> level of security or if there's an ongoing SMP operation.


I have the solution to return an error that I could upstream if needed. 
  It worked sufficiently well to get past the UPF testing scenario's 
where it was an issue, but as you point out, it should never return an 
error in the first place.  However, as a stop-gap temporary solution, it 
works quite well.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
