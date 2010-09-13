Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Sep 2010 19:47:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <20100913164718.GA9448@jh-x301>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
 <20100913105932.GA3566@jh-x301>
 <4C8E0BA3.1010308@Atheros.com>
 <20100913132014.GA5539@jh-x301>
 <4C8E40B5.8080701@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C8E40B5.8080701@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 13, 2010, Suraj Sumangala wrote:
> The "array{uint8}" is just the ATR response from the card reader. it
> is not a complete Bluetoth SAP response packet. We need to
> encapsulate ATR packet to form a Bluetooth SAP response packet. The
> packet will be roughly.
> 
> |Response code|Param1|Param data ( ResultCode )|param2|param data (ATR)|
> 
> The ResultCode will have to be mapped as 1 byte result code in the
> SAP response packet sent to the client.

Why would you want to expose these extra SAP profile details to the
Agent? The bluetoothd side should take care of all details like this
whenever possible. The only relevant data that needs to be transmitted
from the Agent to bluetoothd in this case is the ATR and bluetoothd can
then proceed with creating a proper SAP response packet based on that.

> How do we map the D-Bus error return to the ResultCode?

You'd need to define some sort of mapping table yourself. The list of
possible result codes is quite short (8 in SAP 1.1) so this shouldn't be
too hard. E.g. "Error, card not accessible" (0x02) could map to the
D-Bus error org.bluez.SapError.CardNotAccessible.

Johan
