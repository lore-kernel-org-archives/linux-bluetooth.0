Return-Path: <fd@cisco.com>
Subject: Re: [Bluez-users] Oops in hci_usb
From: Frederic Detienne <fd@cisco.com>
Reply-To: fd@cisco.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084195273.4017.34.camel@pegasus>
References: <20040501173626.GA3866@kos.to>
	 <1083785352.4420.33.camel@pegasus> <20040506184816.GA7468@kos.to>
	 <200405062128.42044.cijoml@volny.cz>  <1083877415.4420.75.camel@pegasus>
	 <1083936143.8935.5.camel@metal.cisco.com>
	 <1084195273.4017.34.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084197848.9634.9.camel@metal.cisco.com>
Mime-Version: 1.0
Date: Mon, 10 May 2004 16:04:08 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

it seems to work fine (no more oops)... thanks!

	fred

On Mon, 2004-05-10 at 15:21, Marcel Holtmann wrote:
> Hi Frederic
> 
> > I have those Oopses too with the Acer BT dongle (bt-600). Disabling SCO
> > solves the problem.
> 
> try the attached patch if it solves the problem.
> 
> Regards
> 
> Marcel
> 
