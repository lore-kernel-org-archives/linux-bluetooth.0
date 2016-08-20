Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1471697662.3650.1.camel@toniob.net>
Subject: Re: Can't connect a Xbox one controller
From: Anthony Bourguignon <contact@toniob.net>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-bluetooth@vger.kernel.org
Date: Sat, 20 Aug 2016 14:54:22 +0200
In-Reply-To: <87zio8wcya.fsf@intel.com>
References: <1471515072.4976.10.camel@toniob.net> <8760qwy6vv.fsf@intel.com>
         <1471642506.3626.5.camel@toniob.net> <87zio8wcya.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le vendredi 19 août 2016 à 20:34 -0300, Vinicius Costa Gomes a écrit :
> Hi,
> 
> Anthony Bourguignon <contact@toniob.net> writes:
> 
> > 
> > Le vendredi 19 août 2016 à 15:02 -0300, Vinicius Costa Gomes a
> > écrit :
> > > 
> > > Hi Anthony,
> > > 
> > > Anthony Bourguignon <contact@toniob.net> writes:
> > > 
> > > > 
> > > > 
> > > > Hi,
> > > > 
> > > > I've recently bought a new xbox one controller as the 2016
> > > > version
> > > > has
> > > > bluetooth connectivity.
> > > > 
> > > > The controller is pairing and connecting well on a windows 10
> > > > computer
> > > > and an android 4.4 tablet. But I can"t make it connect under
> > > > linux
> > > > (Debian unstable, kernel 4.6 and 4.7-rc7, bluez 5.40 from
> > > > experimental). The pairing is ok but when I try to connect to
> > > > controller, it stays connected for less than one second, then
> > > > disconnects, then connects again and so one until the
> > > > controller
> > > > goes
> > > > to sleep, because of the lack of a remote connection.
> > > 
> > > Can you produce the logs with L2CAP ERTM/Streaming mode disabled,
> > > doing something like this before connecting this should work:
> > > 
> > > $ echo 1 > /sys/module/bluetooth/parameters/disable_ertm
> > 
> > The connection worked with ertm disabled, the controller is fully
> > usable.
> > 
> > Is that normal that we have to disable it ?
> 
> No. It could be a bug in the xbox controller. But I need to take a
> closer look at the specification to be really sure.

Can I be of any help ?

Thanks a lot again
