Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201108201753.32608.dstockwell@frequency-one.com>
References: <201108201753.32608.dstockwell@frequency-one.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 22 Aug 2011 11:31:31 -0300
Message-ID: <CAMOw1v5fftYMkEeYGxCMXdkamo_ox5r-GAkp8iVKqAtj0ym7Hg@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
To: David Stockwell <dstockwell@frequency-one.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Aug 20, 2011 at 7:53 PM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> Metadata item #7 should return total playing time of the track (TrackDuration)
> in msec, not current position within the track.

Humn... seems like I misread the meaning of "playing time". And
apparently Luiz had the same interpretation of the spec as of mine,
while implementing the parser on hcidump. He named this field
AVRCP_MEDIA_ATTRIBUTE_PROGRESS. Looking at the spec again, it does
seems like we have to return the track duration, but I'm not sure.
Luiz, what do you think?


Lucas De Marchi
