Return-Path: <cyrus@holtmann.org>
Subject: Re: choosing SCO parameters at run time
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: takeiteasy <pdatta17@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100505223214.GA3699@jh-x301>
References: <h2q995d6c6b1005051457y48748e8am16cb509bd7b6d969@mail.gmail.com>
	 <20100505223214.GA3699@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 06:25:51 +0200
Message-ID: <1273119951.22838.298.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > I have a question related to SCO packet path configuration for
> > Bluetooth HSP/HFP profiles. As I understand,
> > we need to use SCO routing option in etc/bluetooth/audio.conf to
> > select the voice path to be over HCI or PCM.
> > It seems the option is configured at the init time.Can I select PCM or
> > HCI routing at runtime?
> 
> That variable isn't intended to trigger a SCO routing change but to
> simply tell BlueZ & Pulse Audio (or whatever audio subsystem you use)
> what the hardware platforms configuration is. I.e. the actual routing of
> your bluetooth controller needs to be configured separately (and afaik
> there's no standard HCI command through which it could be done which
> further promotes the idea that BlueZ shouldn't have any code for it).

in theory this is possible and I know of a few chips that can change the
routing before establishing the SCO link. However this is all highly
vendor specific and needs extensive kernel and driver support.

So while possible, I haven't seen it in practice at all. Especially with
modern chips supports more than one SCO over PCM.

Regards

Marcel


