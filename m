Return-Path: <DVornheder@t-online.de>
From: DVornheder@t-online.de (Dirk Vornheder)
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Problem with connection between two pc using bluetooth
Date: Fri, 13 Feb 2004 19:19:56 +0100
References: <1ArCh7-0SGjjc0@cmpmail09.bbul.t-online.de> <1076585404.2671.2.camel@pegasus>
In-Reply-To: <1076585404.2671.2.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402131919.56303.dvornheder@t-online.de>
List-ID: <bluez-users.lists.sourceforge.net>


> > I try to get a connection between two pc using bluetooth.
> >
> > My hardware: AVM Fritz AP-X ISDN and two AVM BlueFritz USB Sticks.
> >
> > At the first pc i start pand --search and get a connection to AP-X
> > without any problems.
> >
> > At the second pc i start pand --search but the connection fails:
> >
> > Feb 11 18:44:03 pclap hcid[1290]: link_key_request
> > (sba=00:04:0E:85:B2:C0, dba=0
> > 0:04:0E:85:35:15)
> >
> > Feb 11 18:44:03 pclap hcid[1290]: link_key_notify
> > (sba=00:04:0E:85:B2:C0)
> > Feb 11 18:44:03 pclap hcid[1290]: Replacing link key 00:04:0E:85:B2:C0
> > 00:04:0E:
> > 85:35:15
> >
> > Feb 11 18:44:03 pclap kernel: Bluetooth: Found 1 CAPI controller(s) on
> > device 00
> >
> > :04:0E:85:35:15
> >
> > Feb 11 18:44:03 pclap kernel: kcapi: Controller 1: 00:04:0E:85:35:15
> > attached
> > Feb 11 18:44:03 pclap kernel: kcapi: card 1 "00:04:0E:85:35:15" ready.
> >
> > Feb 11 18:44:03 pclap kernel: kcapi: notify up contr 1
> >
> > Feb 11 18:44:03 pclap kernel: Bluetooth: BNEP (Ethernet Emulation) ver
> > 1.0
> > Feb 11 18:44:03 pclap kernel: Bluetooth: BNEP filters: protocol
> > multicast
> > Feb 11 18:44:03 pclap pand[3561]: PAN daemon ver 1.1
> >
> > Feb 11 18:44:03 pclap pand[3561]: Inquiring
> >
> > Feb 11 18:44:03 pclap pand[3561]: Searching for NAP on 00:04:0E:85:2E:9A
> >
> > Feb 11 18:44:43 pclap pand[3561]: Failed to connect to the SDP server.
> > Connectio
> > n timed out(110)
> >
> > Feb 11 18:44:43 pclap pand[3561]: Searching for NAP on 00:04:0E:85:35:15
> >
> > Feb 11 18:45:23 pclap pand[3561]: Failed to connect to the SDP server.
> > Connectio
> > n timed out(110)
>
> make a dump with "hcidump -w <file>".
>

After using

pand --connect 00:04:0E:85:35:15

instead of 

pand --search

on both pc's everything works fine.

Dirk
