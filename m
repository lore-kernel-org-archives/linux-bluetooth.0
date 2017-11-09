Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510235357.2624.9.camel@hadess.net>
Subject: Re: Can't connect a Xbox one controller
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Anthony Bourguignon <contact@toniob.net>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 09 Nov 2017 14:49:17 +0100
In-Reply-To: <87inuqw9gs.fsf@intel.com>
References: <1471515072.4976.10.camel@toniob.net> <8760qwy6vv.fsf@intel.com>
         <1471642506.3626.5.camel@toniob.net> <87zio8wcya.fsf@intel.com>
         <1471697662.3650.1.camel@toniob.net> <87inuqw9gs.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2016-08-24 at 11:02 -0300, Vinicius Costa Gomes wrote:
> Hi,
> 
> Anthony Bourguignon <contact@toniob.net> writes:
> > > 
> > > No. It could be a bug in the xbox controller. But I need to take
> > > a
> > > closer look at the specification to be really sure.
> > 
> > Can I be of any help ?
> 
> Attached is a patch that disables negotiating Flow Control and
> Retransmission parameters for the SDP channel only. This is a shot in
> the dark, as I could find nothing in the specification that advises
> against the current BlueZ behaviour.
> 
> Could you give it a try? (but I don't have high hopes for it)
> 
> This is looking more like a bug in the controller.

Hi,

It's getting hit during pairing, but this isn't enough to get it
working.

I also combined it with vudentz' patch in the "Continuing the Xbox One
Bluetooth controller debugging" thread (called "Bluetooth: L2CAP:
Ignore Unknown option error for basic mode") and that wasn't enough to
get it working either.

I think that the fix would be to not try and upgrade the connection to
ERTM at all on this device, but I don't know how I could pass this
information down the stack to the l2cap code. Any ideas?

Cheers
