Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314266945-6149-1-git-send-email-arnaud.mouiche@invoxia.com>
References: <1314266945-6149-1-git-send-email-arnaud.mouiche@invoxia.com>
Date: Tue, 13 Mar 2012 10:17:50 -0500
Message-ID: <CAB7rCTjkNfB58E1OrOpS4AKzEF=5HZqd3-6fj2SCzkx7vgKjXA@mail.gmail.com>
Subject: Re: [Patch Bluez] HFP gateway: fix failure on very first GSM connection
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 25, 2011 at 5:09 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> This patch fix the very first incoming connection from a GSM device
> (playing the gateway role), when 'device->gateway' is NULL (when we didn't
> perform a SDP browse request yet)
>
> we add the service with 'btd_device_add_uuid(device->btd_dev, remote_uuid)'
> but we provide HFP_HS_UUID as remote_uuid. Consequently, the HFP headset
> service is activated instead the gateway service.
>
> Note: I failed to know which UUID is the good one to provide for
> audio_device_request_authorization()

Any reason this patch was not picked up?

Mike
