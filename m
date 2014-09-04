Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Sep 2014 14:09:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] emulator/btdev: Overwrite default feature mask when
 SPP is toggled
Message-ID: <20140904110959.GA3120@t440s.ger.corp.intel.com>
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1409734969-10716-5-git-send-email-jakub.tyszkowski@tieto.com>
 <20140903093938.GA23986@t440s.lan>
 <540718F0.3070506@tieto.com>
 <540844F1.1070801@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540844F1.1070801@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Sep 04, 2014, Tyszkowski Jakub wrote:
> >>This looks suspicious to me. The only thing that should matter is
> >>whether the host features bit is set on or not. That already looks
> >>correct to me in the btdev_get_host_features() function. I.e. isn't your
> >>problem with some piece of code higher up in the stack that's not
> >>keeping SSP properly disabled? (since what you're now doing is not just
> >>disabling SSP but making it look like SSP was never supported to begin
> >>with as soon as you disable it).
> >
> >I'm trying to mimic reconnecting legacy HID device (which was previously
> >paired with PIN) to check if security level will be raised when keyboard
> >subclass is being found in remotes SDP records. To get the SDP records
> >we need to trigger SDP search when remote connects the control channel.
> >But we block such incoming connection with 'security block'.
> >
> >If I get the emulator code right, host and remote uses the same array of
> >features which is reason for this patch. When emulated remote tries to
> >connect l2cap on PSM other than the SDP one, it's being rejected if it
> >reports SSP in features.
> 
> Maybe the correct way to fix this is to make remote_features_complete() also
> use btdev_get_host_features() instead of directly copying
> "btdev->conn->features"? With this we wouldn't need to overwrite the
> ->features.

The remote_features_complete() function returns page 0 which is the
controller features. Page 1 the host features and you need the extended
features command for that. The actual bug seems to have been that we
were returning the local instead of remote features when getting the
host features in remote_ext_features_complete(). I've pushed a fix for
it. Let me know if that was the actual problem you were having and
things now work fine for you.

Johan
