Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFBE7B4.5010709@gmx.de>
Date: Thu, 12 Nov 2009 11:47:16 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: Iain Hibbert <plunky@rya-online.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de> <1257861916.10888.1372.camel@localhost.localdomain> <4AF97659.2050807@gmx.de> <4AFBD3B6.6020706@gmx.de> <1258020990.988942.3883.nullmailer@galant.ukfsn.org>
In-Reply-To: <1258020990.988942.3883.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

thanks for you reply!

I think you missunderstood a bit.

First, yes it is a handsfree kit.

But: We don't want to provide our own proprietary SDP Stuff. This makes
no sense cause we want to be compatible to other BT-devices supporting
interesting BT-profiles like HFP etc. And also I was talking about the
SDP-Server side means i want to sent responses.

What we want to do is robustness testing, means our test SDP Server
listens for a SDP request (which can come from headunit but also from
any other sdp capable mobile phone or whatsoever to request the services
provided by the communication partner). We have some predefined correct
answers for some of the SDP requests, but before sending the one fitting
for the received request we fuzz the answer, means we make it invalid
regarding length etc. pp.

Then we send this answer to the bt device under test and look if it
becomes instable cause e.g. of missing checks in SDP implementation.

There are thousands of tools like scapy doing such things for tcp/ip
stack. We are doing similar tests for Bluetooth communication ( L2CAP,
Obex and finally  SDP, too). Here a correct and primarily robust
implementation needs to be ensured through testing. The best way to do
so is to confront the DuT with such invalid packets.

I hope this help to understand a bit better.
