Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349963810.27233.178.camel@aeonflux>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
	<1349891245.27233.153.camel@aeonflux>
	<E3660838E8D64186924BA81A32F30682@sisodomain.com>
	<1349963810.27233.178.camel@aeonflux>
Date: Thu, 11 Oct 2012 16:29:26 +0200
Message-ID: <CABBYNZ+rGP0cirHDexU49+SJnSn2hRd+GVH0sVOFU53DfNnq0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Syam Sidhardhan <s.syam@samsung.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 11, 2012 at 3:56 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Syam,
>
>> >> Problem: If we bind a particular PSM with source address as BDADDR_ANY,
>> >> then we are able to bind the same PSM with adapter address(or any other
>> >> address), which is incorrect.
>> >
>> > why is this incorrect? Explain that to me.
>> >
>>
>> Here there is a correction required in the commit message.
>>
>> As per my understanding the a particular PSM can be binded only once
>> for a single adapter address. Kindly correct me if I'm wrong here.
>
> a PSM can be bound once per adapter address. And of course once per
> BDADDR_ANY.
>
> So you can bind PSM 23 to BDADDR_ANY and 11:22:33:44:55:66. An incoming
> connection to 11:22:33:44:55:66 will arrive to that specific socket, but
> an incoming to all others will be handled by the BDADDR_ANY.
>
> The BDADDR_ANY is special. Consider it a wildcard bound with lower
> priority. If overwritten with a specific address bound, that will be
> considered first of course.
>
> If we are not doing it that way, than that is a bug.
>
> Outgoing connections should behave the same btw. If a specific address
> is bound, than that will be used. If not available, then you can not
> connect. If BDADDR_ANY is used, then the next available adapter will be
> used.

The real problem is by giving psm 0 the kernel should return the first
available psm in the non-reserved space, but since we reuse the same
code to do the matching it end up given both obexd and hdp the same
psm, IMO in this case we should consider using Syam code and not
__l2cap_global_chan_by_addr as the userspace is probably asking for a
psm not in use which should  exclude those in use by BDADDR_ANY.

-- 
Luiz Augusto von Dentz
