Return-Path: <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-users] Obex File Transfer
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: zs@comp.rgu.ac.uk, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074262260.2629.97.camel@pegasus>
References: <40065CC9.5090102@gmx.net>  <4006898B.9020506@csr.com>
	 <1074182424.15383.19.camel@zs>  <1074262260.2629.97.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074265534.1145.201.camel@localhost>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 16:05:34 +0100
List-ID: <bluez-users.lists.sourceforge.net>

Am Fr, den 16.01.2004 schrieb Marcel Holtmann um 15:11:
> Hi Zia,
> > I'm trying to run ObexFTP or Obex Push Deamon on my Zaurus running
> > Bluez, so that I can use it as a file server. I am looking for any
> > documentation about how can i set this up? I got the sdp service
> > registered and got it discovered by other devices but since no obex
> > server application is running, I couldn't get any far. 
> > Can anyone clarify me how does the service listed by SDP interacts with
> > the actual deamon process? Is it possible to run a service without being
> > advertised by SDP? I assume that sdp is just a simple registry of
> > services available. 
> I haven't found the time to write a Bluetooth FTP daemon and I don't
> know if you can run ObexFTP in server mode to achieve this job.

The gnome-obex-send and gnome-obex-server work perfectly well!
They belong IMHO to the gnome-bluetooth package...
I have successfully transferred arbitrary data objects to and from a
Siemens S55 mobile phone.

> Regards
> Marcel
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
