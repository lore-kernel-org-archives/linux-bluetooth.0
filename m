Return-Path: <topsyturvy@nemo.student.utwente.nl>
Date: Thu, 24 Jun 2004 14:26:46 +0200 (CEST)
From: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT_ADDR Address Resolution
In-Reply-To: <1088078815.4296.55.camel@pegasus>
Message-ID: <Pine.BSO.4.58.0406241408110.8407@nemo.student.utwente.nl>
References: <200406241009.i5OA9wFo030305@news01.csr.com>
 <Pine.BSO.4.58.0406241335110.23949@nemo.student.utwente.nl>
 <1088078815.4296.55.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

The ARP will take place using BNEP frames right? i.e. an ARP packet 
encapsulated in a BNEP frame with a destination address corrosponding to 
a broadcast MAC address.

Assuming one PANU wishes to send IP traffic to another PANU. When this 
BNEP frame encapsulating the ARP request arrives at the GN, is it
broadcast on all bridge ports?

Also does the bridge implimentation result in one broadcast per "port" 
i.e. instead of one baseband layer broadcast (i.e. LT_ADDR = 000), we will have 
as many broadcasts as the number of connected PANUs (i.e. one per 
port)?

I hope I'm not sounding too confused.

Thanks for your explaination.

Regards,
Assed


On Thu, 24 Jun 2004, Marcel Holtmann wrote:

> Hi Assed,
> 
> > Does anyone know how IP addresses in the Bluez PAN get resolved to 
> > BT_ADDRs that will be used by BNEP? Is there an ARP broadcast (i.e. query 
> > like slave -> master -> broadcast to all slaves) or some sort of proxy ARP
> > mechanism at master (e.g. query from slave->master and then a reply 
> > master->slave).
> 
> BNEP is only an ethernet emulation over Bluetooth L2CAP. So you must use
> ARP and IP for the IP addresses.
> 
> Regards
> 
> Marcel
> 
> 
> 
