Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8E40B5.8080701@Atheros.com>
Date: Mon, 13 Sep 2010 20:48:13 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <20100913105932.GA3566@jh-x301> <4C8E0BA3.1010308@Atheros.com> <20100913132014.GA5539@jh-x301>
In-Reply-To: <20100913132014.GA5539@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 9/13/2010 6:50 PM, Johan Hedberg wrote:
> Hi,
>
>> Should we have the method like,
>> 	struct RequestATR(string command, variant param)
>
> ATR doesn't take any parameters so it'd be just RequestATR()
>
>> 	where, struct = { string, array{uint8} )
Yep,
>
> What do you need the string for? Wouldn't an array{uint8} suffice? A
> D-Bus error return could be used when the ResultCode in the response
> indicates failure.

The "array{uint8}" is just the ATR response from the card reader. it is 
not a complete Bluetoth SAP response packet. We need to encapsulate ATR 
packet to form a Bluetooth SAP response packet. The packet will be roughly.

|Response code|Param1|Param data ( ResultCode )|param2|param data (ATR)|

The ResultCode will have to be mapped as 1 byte result code in the SAP 
response packet sent to the client.

How do we map the D-Bus error return to the ResultCode?

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Suraj
