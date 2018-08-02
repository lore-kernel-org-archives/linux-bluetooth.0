Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CACEz+owZW84BSguv+RfQgkBZhDd8x2huc4Drx2tYOLiPzB5iVg@mail.gmail.com>
In-Reply-To: <CACEz+owZW84BSguv+RfQgkBZhDd8x2huc4Drx2tYOLiPzB5iVg@mail.gmail.com>
From: George Karabin <gjkhwl@gmail.com>
Date: Wed, 1 Aug 2018 21:57:31 -0400
Message-ID: <CACEz+ozh_yeLXFxVwSz_qPc1AEkDZGsD__vuBTJ=UOBH60sGuw@mail.gmail.com>
Subject: Re: Calling DBUS ConnectProfile to a non-discoverable but pageable
 device with an invalid link key
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 1, 2018 at 3:01 PM George Karabin <gjkhwl@gmail.com> wrote:
>
> From an API point of view, it would seem natural to make the "Paired"
> property on a device object readwrite, so that you can remove its
> pairing without also removing the device object associated with the
> device. I'm sure there are other approaches that would make sense as
> well - I don't yet have a handle on the internal data structures and
> states that might be impacted by changing that assumption.

Now that I see the new experimental ConnectDevice API on the Adapter
interface, that looks like it could be a close fit for my needs.

If another item was added to its properties dictionary to specify whether or
not it should automatically connect supported profiles, that would let my
app be more selective about which profiles to connect - I could follow up
with a ConnectProfile call on the device.

Does anyone have any thoughts on that approach?
