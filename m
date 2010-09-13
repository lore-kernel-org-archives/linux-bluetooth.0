Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8E1942.40805@Atheros.com>
Date: Mon, 13 Sep 2010 17:59:54 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <99B09243E1A5DA4898CDD8B700111448097968E653@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097968E653@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On 9/13/2010 5:41 PM, Waldemar.Rymarkiewicz@tieto.com wrote:
> Hi Suraj,
>
>> +		void Disconnect(string type)
>> +
>> +			This initiates a SAP disconnection from
>> SAP server.
>> +
>> +			The type parameter specifies the type
>> of disconnection.
>> +
>> +			"Graceful"  ->  lets the SAP client initiate a
>> +			garceful disconnection.
>> +
>> +			"Immediate" ->  disconnects the connection
>> +			immediately from the server.
>
> How agent will use this method? I mean when it is supposed to use gracefull and when immediate disconnection?

The agent will be in a better position to take this decision as it will 
be interfacing between actual card reader and SAP server.

For example, if the agent is connected to an external card reader and 
it has lost connection with the reader. It can ask for an Immediate 
disconnection.
If disconnection was triggered by a user action, it can decide to call 
this API with Graceful as the parameter.

>
>> +Signals		PropertyChanged(string name, variant value)
>> +
>> +			This signal indicates a changed value
>> of the given
>> +			property.
>
> Is the signal really needed?  Who is interested in keeping track on properties?

One candidate would be when the MessageSize is changed.
Another one will be with the "SimStatus" property. It makes sense to 
raise his signal after the server sends the STATUS IND response 
successfully.

But, it is a fact that most of the Properties are set by the Agent 
itself. So agent will know that they have changed.

>
> Thanks,
> /Waldek

Regards
Suraj

