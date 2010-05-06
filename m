Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273119951.22838.298.camel@localhost.localdomain>
References: <h2q995d6c6b1005051457y48748e8am16cb509bd7b6d969@mail.gmail.com>
	 <20100505223214.GA3699@jh-x301>
	 <1273119951.22838.298.camel@localhost.localdomain>
Date: Thu, 6 May 2010 11:13:02 -0700
Message-ID: <v2g995d6c6b1005061113w80fb99fag5af6d8e25cf99229@mail.gmail.com>
Subject: Re: choosing SCO parameters at run time
From: takeiteasy <pdatta17@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, May 5, 2010 at 9:25 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> > I have a question related to SCO packet path configuration for
>> > Bluetooth HSP/HFP profiles. As I understand,
>> > we need to use SCO routing option in etc/bluetooth/audio.conf to
>> > select the voice path to be over HCI or PCM.
>> > It seems the option is configured at the init time.Can I select PCM or
>> > HCI routing at runtime?
>>
>> That variable isn't intended to trigger a SCO routing change but to
>> simply tell BlueZ & Pulse Audio (or whatever audio subsystem you use)
>> what the hardware platforms configuration is. I.e. the actual routing of
>> your bluetooth controller needs to be configured separately (and afaik
>> there's no standard HCI command through which it could be done which
>> further promotes the idea that BlueZ shouldn't have any code for it).
>
> in theory this is possible and I know of a few chips that can change the
> routing before establishing the SCO link. However this is all highly
> vendor specific and needs extensive kernel and driver support.
>
> So while possible, I haven't seen it in practice at all. Especially with
> modern chips supports more than one SCO over PCM.
>
> Regards
>
> Marcel
>
>
>

Hi,

We know we can change the routing in hardware (over pcm/hci) but still
we want to know
if we can get a provision/interface in the stack to change this
particular variable dynamically.
If we need to do it ourselves, is it appropriate to put the dbus based
call in headset.c (or)
do we need to take care in other places?

regards
