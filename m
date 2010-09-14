Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8F0179.8070008@Atheros.com>
Date: Tue, 14 Sep 2010 10:30:41 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <20100913105932.GA3566@jh-x301> <4C8E0BA3.1010308@Atheros.com> <20100913132014.GA5539@jh-x301> <4C8E40B5.8080701@Atheros.com> <20100913164718.GA9448@jh-x301>
In-Reply-To: <20100913164718.GA9448@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On 9/13/2010 10:17 PM, Johan Hedberg wrote:

> Why would you want to expose these extra SAP profile details to the
> Agent? The bluetoothd side should take care of all details like this
> whenever possible. The only relevant data that needs to be transmitted
> from the Agent to bluetoothd in this case is the ATR and bluetoothd can
> then proceed with creating a proper SAP response packet based on that.
>
>> How do we map the D-Bus error return to the ResultCode?
>
> You'd need to define some sort of mapping table yourself. The list of
> possible result codes is quite short (8 in SAP 1.1) so this shouldn't be
> too hard. E.g. "Error, card not accessible" (0x02) could map to the
> D-Bus error org.bluez.SapError.CardNotAccessible.

The idea was to return the ResultCode as a string from the agent and map 
it to the corresponding code in the server.

If we can define error codes for each result, that would be fine.
>
> Johan

Regards
Suraj

