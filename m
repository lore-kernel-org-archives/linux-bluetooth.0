Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Sep 2015 09:49:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mark Spruiell <mes@zeroc.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: SDP query via D-Bus?
Message-ID: <20150929064937.GA26120@t440s.lan>
References: <CABOZqnjSPbO-cNkSryq5GXBKTqtE-1TPMKMgTAwtd9YoO4i-4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABOZqnjSPbO-cNkSryq5GXBKTqtE-1TPMKMgTAwtd9YoO4i-4A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Mon, Sep 28, 2015, Mark Spruiell wrote:
> We currently use sdp_connect and sdp_service_search_attr_req to
> determine the RFCOMM channel associated with a service on a remote
> device.
> 
> Does the D-Bus API provide an equivalent way to discover this information?

Not directly, but there's a more convenient & higher level API available
if you look at doc/profile-api.txt and test/test-profile. This will not
only look up the RFCOMM channel for you, but also go ahead and connect
to the service and then give you back the connected RFCOMM socket over
D-Bus.

Johan
