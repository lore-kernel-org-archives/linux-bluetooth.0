Return-Path: <m_laverd@alcor.concordia.ca>
Message-ID: <1077309735.4036712706cd0@alcor.concordia.ca>
Date: Fri, 20 Feb 2004 15:42:15 -0500
From: =?iso-8859-1?b?TWFyYy1BbmRy6SA=?= =?iso-8859-1?b?TGF2ZXJkaehyZQ==?= <m_laverd@alcor.concordia.ca>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a service happens on two systems trying to talk to each other
References: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>  <1077022337.2841.15.camel@pegasus>  <1077033023.4032383f0b3d3@alcor.concordia.ca> <1077034212.2665.19.camel@pegasus>
In-Reply-To: <1077034212.2665.19.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

I read the parts allowing me to have some kind of understanding of what's going
on :) Sorry for the delay, I had a hard deadline for a report.

Here's the situation in more Bluetooth-compliant terms:
Configuration:
Belkin FT0003 USB dongles
RedHat 9 with kernel 2.4.28, from RedHat
Running with latest released versions of BlueZ
Running Impronto 1.18
Running Java SDK 1.4.2.3


Bluetooth activity (all happening in Java):

Implicit: Inquiry Scan [device is set as GIAC]
Thread 1: Inquiry [aka Device Discovery] [runs perpetually, with some sleeping
between each iteration]
Thread 2: Page Scan [opening a service and waiting for clients with
acceptAndOpen()]
Thread 3: SDP Paging + Connection [Service Discovery] [does so when new devices
are found, could happen anytime. Sleeps most of the time]
Thread 4: Paging + Connection [L2CAP Connection as a slave] [happens at user's
input]

Computer A and Computer B are running this configuration
Planned Test:
Start program on both computers
Wait for both Computer A and Computer B to discover each other via Inquiry
User prompts Computer A to send a message to Computer B [creating a L2CAP
connection]
Computer B reads the message and closes the connection
Both shut down their services and exit cleanly

What happens:
Inconsistent behaviour. Service discovery can happen promptly on Computer A and
never finish on Computer B. Sometimes, service discovery completes around 20
seconds for both systems.
The L2CAP connection may not establish itself. Behaviour varies at every test's
run, but generally the results look like a deadlock has occured somewhere.
Very low Bluetooth performance compared to the speed of other configurations.

I hope this makes more sense. I have to read more about the Bluetooth spec, see
what I'm doing wrong Bluetooth-wise. Any sections particularly?

I'm also considering adjusting the settings of hciconfig as well as upgrading
to
kernel 2.6 (I was told that it generally had a huge improvement I/O-wise)

-- 
Marc-André Laverdière  (†)
Étudiant coop. en génie logiciel - Software Engineering Co-Op Student
Université Concordia - Concordia University
/"\
\ /    ASCII Ribbon Campaign
 X      against HTML e-mail 
/ \


Selon Marcel Holtmann <marcel@holtmann.org>:

> Hi Marc-Andre,
> 
> > Only the 1.2 spec is available for people not from member companies. I
> hope
> > this
> > version is OK.
> 
> this version is almost fine.
> 
> > I'll get the non-Java terminology right and I'll write an understandable
> report
> > then. This is frustrating.
> 
> I don't think so.
> 
> 	inquiry scan	-> device is visible
> 	page scan	-> device is connectable
> 
> 	inquiry		-> search for other devices
> 	page		-> connect to another device
> 
> 	SDP connection	-> service discovery (includes page)
> 
> Regards
> 
> Marcel
> 
> 
