Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 1 Aug 2018 23:33:24 +0200
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BlueZ] connection failure or profile unavailability when
 connecting two devices with overlapping profiles
Message-ID: <20180801213324.GF10915@sakura.greysector.net>
References: <20180801140618.GD10915@sakura.greysector.net>
 <CABBYNZ+LF6v6zkHypAtKBqyat1YA=BvyuKaJ2252ysZfVBk1BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+LF6v6zkHypAtKBqyat1YA=BvyuKaJ2252ysZfVBk1BA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, Luiz.
Thank you for the quick reply.

On Wednesday, 01 August 2018 at 17:08, Luiz Augusto von Dentz wrote:
> Hi Dominik,
> 
> On Wed, Aug 1, 2018 at 5:06 PM, Dominik 'Rathann' Mierzejewski
> <dominik@greysector.net> wrote:
> > Dear list,
> > I reported this originally in Fedora 27
> > (https://bugzilla.redhat.com/show_bug.cgi?id=1541575), but maybe someone
> > here has a better idea, since it's still reproducible on Fedora 28 with
> > newer versions of bluez and pulseaudio.
> >
> > Description of problem:
> > I'm unable to connect the Creative MUVO 2c speaker if a Jabra Evolve 65
> > headset is connected already. If I connect the speaker first, then I'm
> > able to connect the Jabra headset, but only HFP profile works (A2DP sink
> > is not selectable). There are no issues adding an Android phone to the
> > mix in any order, seemingly because it only has non-overlapping profiles
> > A2DP source and HFP audio gateway).
> 
> PA only register one A2DP sink and one A2DP source, so you can only
> connect to one headset at time.

Well, that sucks. I'd like to use the speaker for music and the headset
for audio conferencing. It doesn't seem like an unusual setup to me and
having to connect/disconnect devices manually when someone calls me
feels like a lot of unnecessary hassle. But maybe I'm mistaken.

> We could in theory not publish the
> in_use flag of endpoints, but afaik we tried that some years ago and
> that caused some problems, so perhaps adding more endpoints to PA
> would work.

Could you find some reference or at least suggest some keywords I could
search on? I'm not that familiar with either Bluetooth or Pulseaudio.

Shall I file a bug against pulseaudio at the new gitlab issue tracker
(https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/)?

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPMFusion   http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
