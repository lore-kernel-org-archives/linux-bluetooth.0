Return-Path: <juliencampana@yahoo.fr>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Julien Campana <juliencampana@yahoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ-devel List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085487245.9779.89.camel@pegasus>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085489942.900.89.camel@fischer>
Mime-Version: 1.0
Date: Tue, 25 May 2004 14:59:02 +0200
List-ID: <bluez-devel.lists.sourceforge.net>

Am Di, den 25.05.2004 schrieb Marcel Holtmann um 14:14:
> Hi Julien,
> 
> > We have developped a JSR-82 implementation for Linux, which is based on
> > BlueZ and which is compatible with most USB-Dongle's.
> > 
> > We've used parts of JavaBluetooth.org's works and parts of JBluez's
> > stuff.
> > The native C-Code of the project is entirely based on the BlueZ project
> > and I would like to thanks Marcel Holtmann for his answers to my
> > questions, which were all helpfull.
> 
> you are welcome.
> 
> > We've decided to make the Linux version OpenSource. 
> > 
> > The JSR-82 specification is not yet fully implemented but the major part
> > of the work (let say 95%) is done.
> 
> I would never use Java for Bluetooth programming, but it seems that some
> companies wants this, especially mobile phone manufacturers. So I think
> we should build up a clean implementation of the JSR-82 standard that
> uses BlueZ as underlying Bluetooth stack.

This is exactly what I did, or at least I have implemented a big part of
the JSR-82 Standard with BlueZ as underlying Bluetooth stack. (I suppose
but do not really know if the implementation is clean:)). If you want
this implementation to be part of the BlueZ project, I (and especially
my boss:) agree.

>  Clean means for me that we
> should concentrate on BlueZ and try to interface BlueZ<->JSR-82 as best
> as possible. 

To better understand the way I have interfaced BlueZ <->JSR-82 and if
you have enough time for this, I invite you to have a quick look at the
file sources/c/BlueZ.cpp contained in the tgz archive downloadable at
http://www.avetana-gmbh.de/avetana-gmbh/jsr82.xml

This c file mostly re-write some BlueZ method and has surely to be
cleaned and documented. 
This will be the next step of my work. This version is still a
beta-version but is stable and robust enough to be used in a project.
especially if the project uses RFCOMM connections. (there is still some
work to do with L2CAP).

> Give me some comments if there is really interest in doing
> this.

I will continue to work on this project until I reach a clean and really
stable implementation. If you have any comment about the implementation
do not hesitate to mail me. 

Regards,

Julien

> Regards
> 
> Marcel
> 
