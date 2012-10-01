Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:16:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Frederic Danis <frederic.danis@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Convert storage to use per-remote device directories
Message-ID: <20121001081621.GA20326@x220>
References: <50642389.40107@intel.com>
 <1348842803.13371.25.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348842803.13371.25.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 28, 2012, Marcel Holtmann wrote:
> > Here is my proposal for new storage directory structure using ini-file 
> > format.
> > 
> > Each adapter directory (/var/lib/bluetooth/<adapter address>/) will 
> > contain a config file for the local adapter and one directory per remote 
> > device.
> > The adapter config file just need to be converted to ini-file format 
> > with only 1 group called [adapter].
> > 
> > Each of remote device directories' name will be based on remote device 
> > address and address type (address#type).
> > This directory will contain a config file with remote device infos and a 
> > linkkey file.
> > Remote device config file will include a [device] group with general 
> > device infos (name, alias, profiles or services list, ...), and groups 
> > named by profile uuid (or service uuid) with related infos.
> > 
> > So the directory structure should be:
> >     /var/lib/bluetooth/<adapter address>/
> >         ./config
> >         ./<remote device address#type>/
> >             ./config
> >             ./linkkey
> >         ./<remote device address#type>/
> >             ./config
> >             ./linkkey
> >         ...
> 
> why do we care about the address type here? Can we actually have a
> different link key for BR/EDR and for LE? Right now it is really only
> one choice on how to use that remote device. If it is dual-mode, then we
> use BR/EDR and if it is single-mode we use LE.

I think the idea here was to avoid potential (though unlikely)
collisions of a static random address of device A and a public address
of device B. However, thinking about it, is such a collision actually
possible considering that the two most significant bits of a static
random address must be 1. I'd imagine that the Core spec. writers would
have tried to make sure that this will not clash with any OUI's.

In any case we do at least need to have the address type info somewhere
in the device-specific directory so bluetoothd knows how to connect to
the device.

Johan
