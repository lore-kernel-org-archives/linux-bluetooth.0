Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 18:21:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michael Schmitt <tcwardrobe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111118162111.GA4680@fusion.localdomain>
References: <4EC679A0.7050309@gmail.com>
 <20111118153652.GA3647@fusion.localdomain>
 <4EC67E88.6060202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC67E88.6060202@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Nov 18, 2011, Michael Schmitt wrote:
> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> > HCI Event: Command Complete (0x0e) plen 12
>     Read Local Version Information (0x04|0x0001) ncmd 1
>     status 0x00
>     HCI Version: 1.2 (0x2) HCI Revision: 0x2006
>     LMP Version: 1.2 (0x2) LMP Subversion: 0x1806
>     Manufacturer: AVM Berlin (31)

Ok, so this is a 1.2 adapter.

> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> > HCI Event: Command Status (0x0f) plen 4
>     Read Local Supported Commands (0x04|0x0002) status 0x01 ncmd 1
>     Error: Unknown HCI Command

This is the reason why you're getting a timeout. Since the adapter
claims to support Bluetooth version 1.2 it should also support this HCI
command, so from that perspective it's not conforming to the
specification. Right now the kernel (lib/bluetooth/hci_event.c) is
completely missing a command status handler for this command. If such a
handler was in place instead of a timeout you would be getting an
immediate error (the kernel maps this HCI status code to EBADRQC).

However, since this is also not acceptable behavior (as the adapter
still wouldn't work for you) I suspect the need for some
adapter-specific quirk is in place or then the kernel should just ignore
any errors for HCI_Read_Local_Supported_Commands.

Johan
