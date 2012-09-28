Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 16:39:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Wireshark
Message-ID: <20120928133944.GC5075@x220>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Fri, Sep 28, 2012, Michal.Labedzki@tieto.com wrote:
> I am trying to add full Bluetooth support to a Wireshark. Wireshark can be
> used as replacement for "hcidump" or other GUI applications for displaying
> Bluetooth frames/packets.
> 
> Currently Wireshark support:
> 1. Sniffing via Bluetooth dongle
> 2. Protocols/Profiles:
>     HCI (without BLE)
>     L2CAP
>     SDP (little broken)
>     RFCOMM 1.1
>     OBEX (so all OBEX profiles can be treat as supported)
>     AMP
>     HID 1.0
>     SAP 1.1
>     BNEP 1.0
>     AVCTP 1.4
>     AVRCP 1.5
> 
> At this moment I am working on: (finishing)
> 1. ATT
> 2. HCRP
> 3. MCAP
> 4. AVDTP/A2DP/VDP

Have you looked into supporting the new HCI_CHANNEL_MONITOR available in
recent kernels? There's a very simple "btmon" command-line tool for it
in bluez.git (see e.g. monitor/control.c) but it can't do any kind of
high-level decoding (e.g. profiles). It'd be interesting to know if it
could be easily supported in wireshark since right now there doesn't
seem to be a viable way of porting decoders from hcidump to btmon due to
their very different ways of handling buffers etc.

One of the big benefits of the monitor channel compared traditional HCI
sockets is that you get dynamic notifications of added and removed
adapters including the very early HCI traffic that occurs. In the long
run I think the idea is to add also "replay" connection events for
existing ACL and L2CAP links so that you'd get the right protocol
decoded even if you start logging when the connection already exists.

Johan
