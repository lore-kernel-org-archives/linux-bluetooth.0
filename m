Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 May 2010 01:44:07 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: takeiteasy <pdatta17@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: choosing SCO parameters at run time
Message-ID: <20100505223214.GA3699@jh-x301>
References: <h2q995d6c6b1005051457y48748e8am16cb509bd7b6d969@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <h2q995d6c6b1005051457y48748e8am16cb509bd7b6d969@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 05, 2010, takeiteasy wrote:
> I have a question related to SCO packet path configuration for
> Bluetooth HSP/HFP profiles. As I understand,
> we need to use SCO routing option in etc/bluetooth/audio.conf to
> select the voice path to be over HCI or PCM.
> It seems the option is configured at the init time.Can I select PCM or
> HCI routing at runtime?

That variable isn't intended to trigger a SCO routing change but to
simply tell BlueZ & Pulse Audio (or whatever audio subsystem you use)
what the hardware platforms configuration is. I.e. the actual routing of
your bluetooth controller needs to be configured separately (and afaik
there's no standard HCI command through which it could be done which
further promotes the idea that BlueZ shouldn't have any code for it).

Johan
