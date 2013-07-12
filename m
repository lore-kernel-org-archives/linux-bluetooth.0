Return-Path: <cyrus@holtmann.org>
Message-ID: <51E00910.5050401@linux.intel.com>
Date: Fri, 12 Jul 2013 15:48:00 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Vinicius Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older devices
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com> <2F173411-4542-47EE-8DF5-65D21856ADAF@holtmann.org>
In-Reply-To: <2F173411-4542-47EE-8DF5-65D21856ADAF@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, Vinicius,

Le 08/07/2013 21:25, Marcel Holtmann a écrit :
> Hi Fred,
>
> we should check for eSCO and transparent SCO support. We do need both. And we also need to figure out on how to handle the incoming situation correctly,
>
> Is the error ECONNABORTED a correct one.
>
> Regards
>
> Marcel
>

My understanding of Vinicius comment is that some adapters may not
support esco but still have transparent data support thanks to Setup
Sync Conn. Transparent data on these adapters can be supported for
cheap since the connection establishment would be the same.

If we choose to go for eSCO AND transparent SCO support, then these
adapters get unused features.

One possibility is to check for Setup Synchronous Connection command bit
instead of Esco feature bit. But that makes a ugly bunch of tests :
if cvsd is requested
    check esco feature bit.
if transparent data is requested
    check setup sync conn command bit and transparent data feature bit.

The only problem so far is that I have yet to see these adapters :)

About the error ECONNABORTED, it is what the patch does : abort a 
connection. It is not used for other purposes. If you really want to
change, I'm ok with EOPNOTSUPP, otherwise please suggest.

Regards,
Fred
