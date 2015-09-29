Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150929064937.GA26120@t440s.lan>
References: <CABOZqnjSPbO-cNkSryq5GXBKTqtE-1TPMKMgTAwtd9YoO4i-4A@mail.gmail.com>
	<20150929064937.GA26120@t440s.lan>
Date: Tue, 29 Sep 2015 14:01:18 -0700
Message-ID: <CABOZqnjj4hpAVLYKgC6CxwrFUaz7ZNn5Yhvz7DCk3u30Cp3urg@mail.gmail.com>
Subject: Re: SDP query via D-Bus?
From: Mark Spruiell <mes@zeroc.com>
To: Mark Spruiell <mes@zeroc.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for the reply.

I understand how a server can use RegisterProfile to advertise its
UUID & RFCOMM channel with SDP (as demonstrated in test-profile).

It's still not clear to me how a client can use D-Bus to establish an
RFCOMM socket connection given a device address & UUID. Can you point
me in the right direction?

Regards,
Mark

On Mon, Sep 28, 2015 at 11:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mark,
>
> On Mon, Sep 28, 2015, Mark Spruiell wrote:
>> We currently use sdp_connect and sdp_service_search_attr_req to
>> determine the RFCOMM channel associated with a service on a remote
>> device.
>>
>> Does the D-Bus API provide an equivalent way to discover this information?
>
> Not directly, but there's a more convenient & higher level API available
> if you look at doc/profile-api.txt and test/test-profile. This will not
> only look up the RFCOMM channel for you, but also go ahead and connect
> to the service and then give you back the connected RFCOMM socket over
> D-Bus.
>
> Johan
