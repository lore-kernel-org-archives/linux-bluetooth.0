Return-Path: <EXT-Somil.Asthana@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
Date: Mon, 7 Jun 2004 16:27:42 -0400
Message-ID: <E320A8529CF07E4C967ECC2F380B0CF90140382B@bsebe001.americas.nokia.com>
From: <EXT-Somil.Asthana@nokia.com>
To: <marcel@holtmann.org>
Cc: <d.mackie@ru.ac.za>, <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel=20
  Looks like I am in minority here :(. Actually you are very correct =
there aren't any phone with PAN or UPnP (its in one of our TODO list). =
Further, Symbian 8.0 release will have a PAN stack anyway (it will be =
interesting to interface with Bluez PAN  stack, as there are some =
issues). So for the time being you can look for solutions like =
Distributed SDP database, tunneling for the RFCOMM channels. They look =
every exciting but requires lot of debugging/testing  based on my =
experience on developing/debugging l2cap broadcast utility (using Bluez =
util code) and I didn't do anything novel there. As far as I see =
maintaining /updating Distributed SDP database is no different from =
cache coherence problem (but I am nt expert so I shouldn't really say =
that but I thought about it :)).

regards
Somil

 =20

-----Original Message-----
From: ext Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Monday, June 07, 2004 4:11 AM
To: Asthana Somil (EXT-Nokia-NRC/Boston)
Cc: d.mackie@ru.ac.za; BlueZ Mailing List
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth
Devices/Address?


Hi Somil,

>   This is getting interesting looks like I am completing my Masters =
thesis & you are mentoring (or vice versa).=20
>  You don't need a scatterent to connect two piconet. Two piconets =
(basically piconet devices) can be connected via an ethernet wire or =
WLAN AP. I have done that its not magic. After connecting we can create =
an IP infrastructure make every device IP addressable (that is where I =
said there can be some IP addressing problem and I am trying to solve & =
publish it anyway its no concern here). Now the question comes sending =
SDP records - to know what kind of service each piconet device provides =
etc ?? If we have an IP infrastructure then why nt use UPnP protocol we =
don't need BTH SDP protocol (I guess UPnP protocol provides more =
flexibility than SDP (I am nt an expert in UPnP)). But if you still want =
BTH SDP then send SDP records in IP packets (not good). (Make IP =
connections between devices to transfer data etc no need to make RFCOMM =
connections run thousands of legacy IP applications without modifying a =
single line of code, I am nt able to understand why people are pushing =
for RFCOMM etc but nt what we are discussing here).=20

actually I don't think the point here is building the scatternet or
using IP to extend it. We already know that if we use PAN this is
working perfect and with Linux bridging, VLAN and NAT it is possible to
create this in an easy way. I've done this before without Bluetooth so
am not really interested in this way, because it is the same and nothing
really new.

However David mentioned he wants to talk to a phone and right now I
haven't seen any phone with PAN or UPnP. To support legacy devices you
need a distributed SDP database (you must keep it up-to-date) and use
somekind of tunneling for the RFCOMM channels. The RFCOMM tunnel is very
easy to achieve. It is a simple mapping from a TCP stream to a RFCOMM
stream. You can also map it to different channel numbers on each side.
The real problem here is the SDP database. Think about it.

Regards

Marcel
