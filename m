Return-Path: <cyrus@holtmann.org>
Message-ID: <1349382629.27233.43.camel@aeonflux>
Subject: Re: [PATCH 4/4] audio: Add check for non-a2dp codec
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: chanyeol.park@samsung.com, linux-bluetooth@vger.kernel.org
Date: Thu, 04 Oct 2012 22:30:29 +0200
In-Reply-To: <CABBYNZ+qKN_q9-t1a_i3FayCUxZ2a8M9x6USKVn-Ssy7eBNYzg@mail.gmail.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
	 <CABBYNZKHzKv+GQhynnGN04O17kwjDobwL-+CeVB9hJqrVEF05A@mail.gmail.com>
	 <1349374107.27233.36.camel@aeonflux>
	 <CABBYNZ+qKN_q9-t1a_i3FayCUxZ2a8M9x6USKVn-Ssy7eBNYzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> > This patch adds checks(vendor ID, vendor specific codec ID) to make sure of
> >> > non-a2dp codec selection.
> >> > ---
> >> >  audio/a2dp-codecs.h |    6 +++++
> >> >  audio/a2dp.c        |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >> >  2 files changed, 73 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/audio/a2dp-codecs.h b/audio/a2dp-codecs.h
> >> > index 51c796a..e3d2cba 100644
> >> > --- a/audio/a2dp-codecs.h
> >> > +++ b/audio/a2dp-codecs.h
> >> > @@ -26,6 +26,7 @@
> >> >  #define A2DP_CODEC_MPEG12              0x01
> >> >  #define A2DP_CODEC_MPEG24              0x02
> >> >  #define A2DP_CODEC_ATRAC               0x03
> >> > +#define A2DP_CODEC_NON_A2DP            0xFF
> >>
> >> I prefer A2DP_CODEC_VENDOR
> >
> > what is the specification calling these? And yes, I would prefer VENDOR
> > as well.
> 
> Apparently it comes from the assigned numbers
> http://www.bluetooth.org/Technical/AssignedNumbers/audio-video.htm:
> 
> 1	1	1	1	1	1	1	1	non-A2DP	n/a	A2DP
> 
> But the spec refer to it as 4.7 Vendor Specific A2DP Codec, IMO the
> term non-A2DP can be confused with not defined in A2DP spec when in
> fact it is defined:
> 
> "4.2.3 Vendor Specific A2DP Codecs
> The device may support other codecs as Vendor Specific A2DP codecs. A
> user of a Vendor Specific A2DP codec (hereafter the Vendor) will need
> to define parameters and other information necessary for use of the
> codec in A2DP."
> 
> There is no such a thing as non-A2DP in the spec, so again to avoid
> confusion I would stick to the terminology vendor or vendor specific.

lets use "vendor" for these. Otherwise the function and variable naming
gets too complicated.

Regards

Marcel


