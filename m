Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 12:07:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Implementation of name-resolve procedures in mgmtops
Message-ID: <20111101100707.GA4434@fusion.localdomain>
References: <AC090B9732AB2B4DB7FF476E907FE660013BAEC43B@dnce02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE660013BAEC43B@dnce02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Mon, Oct 31, 2011, Ilia, Kolominsky wrote:
> Could you please outline the intended mechanics for the new
> Name-resolve procedures in mgmtops?
> - What is the purpose of Confirm Name command?
> ( I see that you`d added it but not implemented )
> - What are the main differences in the mechanics between
> the hciops and mgmtops?
> - Are there any changes in user behavior?

We already discussed this on IRC, but I'll recap here so that it gets
stored in the mailing list archives. This way people can also correct me
if I remember something wrong about what we agreed in Prague.

Regarding mgmtops vs hciops, the idea (as long as we hold on to hciops)
is that hciops roughly emulates what the kernel will do when accessed
through the mgmt interface. That also means that the adapter_ops API
should be modeled more or less according to the mgmt interface (e.g. the
resolve_name callback needs to go and a confirm_name callback needs to
be added).

During a device discovery session the kernel will set the (new) Confirm
Name field in mgmt_ev_device_found to 1 whenever the kernel doesn't know
if know the name for that device or not. Upon receiving such an event
user-space (bluetoothd) will check its storage and respond with the
(new) Confirm Name command. The field in mgmt_ev_device found would be
set to 1 e.g. for any non-EIR inquiry result for a device we haven't
received a confirm_name command for previously (during the same
discovery session) and for any EIR result which doesn't contain a full
name.

Each "unknown name" device that user-space tells the kernel about gets
added to a list and once the currently ongoing inquiry finishes the
kernel proceeds with trying to resolve the name for each device in the
list, one at a time. For efficiency, this list should be sorted by
strongest RSSI first so that devices which are with a higher likelihood
closer to us get their names resolved first. The kernel will also wait a
few seconds (2 sounds like an ok value?) if user space hasn't yet
responded with a name confirmation for a device when inquiry finishes.
Once the list of names to be resolved is empty the device discovery is
deemed complete.

Johan
