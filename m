Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 15:17:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Beckingham <colbec@start.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Permission denied (13) on Samsung WEP475 headset?
Message-ID: <20110804121703.GA23534@dell>
References: <4E3A7E09.6040503@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E3A7E09.6040503@start.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Thu, Aug 04, 2011, Colin Beckingham wrote:
> I'd like to provide some feedback regarding a Samsung WEP475 headset
> which fails to connect to linux specifically.
> 
> The USB bluetooth adapter is a Model: Belkin BLUETOOTH USB +EDR
> ADAPTER v2.1 UHE which successfully interconnects with 2 Jabra and 1
> Plantronics headsets, plus a Nokia E71 phone. Samsung WEP475
> successfully connects to a Windows XP machine and to the Nokia E71.
> 
> Using Opensuse 11.4 with custom kernel 3.0 currently, (also fails
> with 2.6.38), bluez 4.96 and bluedevil manager.
> 
> Symptoms are that bluedevil sees the headset in pairing mode and
> correctly retrieves the name WEP475, connected button flashes green
> and then returns to grey (not connected). WEP475 led changes to
> connected status but bluedevil shows headset not connected and
> headset does not work.
> 
> With bluetoothd in debug mode, I get the following transactions in
> /var/log/messages:

There seems to be something strange going on with the secure simple
pairing logic. For some reason the initial link key isn't good enough
(auth request + link key negative reply after the initial key has been
generated) and then there's a user confirm negative reply for the second
attempt. It'd be good to get to the bottom of this and fix it properly,
but meanwhile you can probably work around this by disabling SSP on your
side (hciconfig hci0 sspmode 0) and retrying pairing.

Johan
