Return-Path: <cyrus@holtmann.org>
From: "Thomas Hill" <Thomas.K.Hill@T-Online.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: b3count is full
Date: Mon, 2 Mar 2009 20:10:19 +0100
Message-ID: <FF6657472ED74B4890BEC9ED8EDA3C4D@ThinkpadZ61m>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

while the AVM Blue!FRITZ ISDN access point in combination with the AVM
Blue!FRITZ USB dongle and the AVM software package is working well in the
Microsoft Windows world, I can NOT get the same hardware to work
satisfactory under Debian Linux.

I have tried in combination with Debian EtchnHalf and recently also under
Debian Lenny. 

As PBX system I do use Asterisk with chan_capi to connect to ISDN and Ekiga
as softphone.

Bluetooth connectivity: The access point is found, pairing works, capiinit
start also successfully loads AVMs capi driver

Asterisk integration: chan_capi is loaded, I can receive and place calls,
BUT THE AUDIO QUALITY IS VERY BAD (which makes the set-up useless).

Looking at the capi debug messages, the log is flooded with messages
'b3count is full, dropping packet' during a call/conversation.

AVM does not provide support and just comments "the implementation of the
Blue!FRITZ driver under Linux is an external open source project for which
we do not provide support. The scenario should work fine under Windows".

Asterisk specialists state that this message originates from the card/driver
and would be thrown when the data packages asterisks sends to the
card/driver are not confirmed back (per CONF). Unfortunately, they are not
familiar with Blue!FRITZ and can therefore not further comment on how this
problem might be solved.

Can someone here advise what to do / try??

I would really like to stay with the bluetooth solution as my machine has no
more PCI slot for a build-in card available.

Debian: 5.0 Lenny stable, with normal binaries installed via Synaptic
Package Manager:

Bluetooth            3.36-3
Bluez-audio          3.36-3
Bluez-Gnome          0.27-1
Bluez-utils          3.36-3
libbluetooth2        3.36-1

Asterisk:                 1.4.21.2
Asterisk-chan-capi        1.1.1-1

Ekiga               2.0.12


Thanks
Thomas

