Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51E00910.5050401@linux.intel.com>
Date: Fri, 12 Jul 2013 09:35:52 -0700
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <72A3F18A-C232-4F37-AC79-1F51FF980E74@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com> <2F173411-4542-47EE-8DF5-65D21856ADAF@holtmann.org> <51E00910.5050401@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> we should check for eSCO and transparent SCO support. We do need both. And we also need to figure out on how to handle the incoming situation correctly,
>> 
>> Is the error ECONNABORTED a correct one.
> 
> My understanding of Vinicius comment is that some adapters may not
> support esco but still have transparent data support thanks to Setup
> Sync Conn. Transparent data on these adapters can be supported for
> cheap since the connection establishment would be the same.
> 
> If we choose to go for eSCO AND transparent SCO support, then these
> adapters get unused features.
> 
> One possibility is to check for Setup Synchronous Connection command bit
> instead of Esco feature bit. But that makes a ugly bunch of tests :
> if cvsd is requested
>   check esco feature bit.
> if transparent data is requested
>   check setup sync conn command bit and transparent data feature bit.
> 
> The only problem so far is that I have yet to see these adapters :)

doing transparent SCO on an adapter without eSCO support is useless. I would not bother supporting this at all. Especially for HFP 1.6 with mSBC we have the fact it mandates eSCO.

> About the error ECONNABORTED, it is what the patch does : abort a connection. It is not used for other purposes. If you really want to
> change, I'm ok with EOPNOTSUPP, otherwise please suggest.

I am not sure which error to use. This is more like an open discussion on getting some valid consensus here. Since as a matter of fact once connect() or accept() + read() fails, we need to re-negotiate the codec via HFP. So that must be possible from the API. Hence we need a clear error code.

Regards

Marcel

