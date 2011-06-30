Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 12:28:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Koustuv Ghosh <koustuvg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: SCORouting to PCM in Desktop
Message-ID: <20110630092824.GA26690@dell.ger.corp.intel.com>
References: <BANLkTi=ku2nnVc0DgduHtxZ6xQvzW-d+zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTi=ku2nnVc0DgduHtxZ6xQvzW-d+zA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Koustuv,

On Mon, Jun 27, 2011, Koustuv Ghosh wrote:
> I have query  for HFP in bluez.
> As we know in Desktop PC ,  SCORouting is default routed to HCI and I
> used to get sco data on HCI.
> But is there anyway to route it to my desktop PCM.
> 
> I can't use audio.conf file(available at  /etc/bluetooth) as in my PC
> dbus is having some problem.
> Apart from that is their any option so that it could be changed to PCM
>  either by doing any tweak to bluez user space or kernal space?

PCM routing requires a special hardware line to be connected to your
Bluetooth controller. Typically this is only found on embedded systems
and your desktop PC (most likely) doesn't have it. The audio.conf
setting is only there to document the underlying hardware state and
doesn't actually change anything as such. The only thing that the
setting impacts is the possibility to call Headset.Play() and once that
method is gone (it's already marked as deprecated) the setting will also
be removed from audio.conf.

Johan
