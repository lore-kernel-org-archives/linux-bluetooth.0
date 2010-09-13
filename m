Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8E426B.2090308@Atheros.com>
Date: Mon, 13 Sep 2010 20:55:31 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com> <99B09243E1A5DA4898CDD8B700111448097968E653@EXMB04.eu.tieto.com> <4C8E1942.40805@Atheros.com> <99B09243E1A5DA4898CDD8B700111448097968E69F@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097968E69F@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On 9/13/2010 6:17 PM, Waldemar.Rymarkiewicz@tieto.com wrote:
>   Hi Suraj,
>
>> The agent will be in a better position to take this decision
>> as it will be interfacing between actual card reader and SAP server.
>>
>> For example, if the agent is connected to an external card
>> reader and it has lost connection with the reader. It can ask
>> for an Immediate disconnection.
>
> What will happen when dbus connection will be lost?  SAP server will start immediate disconnection. Right?
Yes,
>
>> If disconnection was triggered by a user action, it can decide
>> to call this API with Graceful as the parameter.
>
> What exactly do you mean "triggerd by a user" ? Does agent interact with the user somehow?  In which way, any API for that?
Here we only specifies the interface required by the Agent using SAP 
server. The agent implementation will depend on the actual system which 
uses SAP server.

For example, if we have use ofono. The agent will be implemented as part 
of ofono's implementation. This will be similar to the way Handsfree 
Gateway is implemented.

>
>> One candidate would be when the MessageSize is changed.
>> Another one will be with the "SimStatus" property. It makes
>> sense to raise his signal after the server sends the STATUS
>> IND response successfully.
>>
>> But, it is a fact that most of the Properties are set by the
>> Agent itself. So agent will know that they have changed.
>
> Exactly.
>
> Thanks,
> /Waldek

Regards
Suraj

