Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327164299.1955.53.camel@aeonflux>
References: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
	<1327164299.1955.53.camel@aeonflux>
Date: Sat, 21 Jan 2012 19:30:29 +0200
Message-ID: <CAE1zotJs0gJOQUX_w+A31gw6zedBGnLscyWRKya8KdNKTM4+4A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: silence lockdep warning
From: "Purdila, Octavian" <octavian.purdila@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jan 21, 2012 at 6:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Octavian,

Hi Marcel,

>> Change-Id: I0e5e395e579c20d29d1fb3aef862c011a9031225
>
> No Change-Id please. This is not some Gerrit review thing.
>

Sorry about that, it slipped :) I will resend the patch with the
change id removed.

>> +void bt_sock_reclassify_lock(struct sock *sk, int proto)
>>  {
>> -     struct sock *sk = sock->sk;
>> -
>>       if (!sk)
>>               return;
>
> Why are we keeping the !sk check here if we already hand in the sk. It
> is most likely checked by the caller already.
>

In rfcomm_sock_create (called from bt_sock_create) sock->sk can be set
to NULL so I think we should keep the check.

Thanks!
Tavi
