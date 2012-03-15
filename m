Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Mar 2012 10:16:25 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [Patch Bluez] HFP gateway: fix failure on very first GSM
 connection
Message-ID: <20120315101625.GB1343@x220.vexbr.com.br>
References: <1314266945-6149-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAB7rCTjkNfB58E1OrOpS4AKzEF=5HZqd3-6fj2SCzkx7vgKjXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB7rCTjkNfB58E1OrOpS4AKzEF=5HZqd3-6fj2SCzkx7vgKjXA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 13, 2012, Mike wrote:
> On Thu, Aug 25, 2011 at 5:09 AM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com> wrote:
> > This patch fix the very first incoming connection from a GSM device
> > (playing the gateway role), when 'device->gateway' is NULL (when we didn't
> > perform a SDP browse request yet)
> >
> > we add the service with 'btd_device_add_uuid(device->btd_dev, remote_uuid)'
> > but we provide HFP_HS_UUID as remote_uuid. Consequently, the HFP headset
> > service is activated instead the gateway service.
> >
> > Note: I failed to know which UUID is the good one to provide for
> > audio_device_request_authorization()
> 
> Any reason this patch was not picked up?

Human error (me forgetting about it). The patch has been applied now
(after fixing up the commit message), however it doesn't seem like too
many people have missed this since the patch has been lying around for
about half a year.

Johan
