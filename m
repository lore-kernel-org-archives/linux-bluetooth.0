Return-Path: <cyrus@holtmann.org>
Message-ID: <1347624979.8292.1.camel@maxim-laptop>
Subject: Re: [RFC v4 0/9] Optional acquire in Media API and related
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Fri, 14 Sep 2012 15:16:19 +0300
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-09-14 at 14:03 +0200, Mikel Astiz wrote: 
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Similar patchset as v3 with the integration of Luiz's feedback, including the following changes:
> - Patches 7 and 8 swapped
> - State "acquired" renamed to "active" (both in D-Bus and in the code)
> - TRANSPORT_STATE_POST_ACQUIRE (which was transitional) dropped
> 
> From original patch:
> 
> This patch reopens the discussion started by the thread "when is acquire
> ok to call". The race condition seems to be real (even thought difficult
> to reproduce), and I couldn't think of any approach to solve this
> without altering the Media API.
Will this fix the issue with 2 a2dp headsets unable currently to connect
at same time? Any idea if this is API limitation, PA bug or something
else?

Best regards,
Maxim Levitsky

