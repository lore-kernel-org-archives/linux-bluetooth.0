Return-Path: <cyrus@holtmann.org>
Message-ID: <4C8605A4.3020300@Atheros.com>
Date: Tue, 7 Sep 2010 14:58:04 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>,
	"joakim.xj.ceder@stericsson.com" <joakim.xj.ceder@stericsson.com>,
	"claudio.takahasi@gmail.com" <claudio.takahasi@gmail.com>,
	"Arkadiusz.Lichwa@tieto.com" <Arkadiusz.Lichwa@tieto.com>
Subject: Re: [RFC] Sim Access Profile API doc
References: <1283839375-20033-1-git-send-email-suraj@atheros.com> <99B09243E1A5DA4898CDD8B7001114480979581239@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480979581239@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On 9/7/2010 2:06 PM, Waldemar.Rymarkiewicz@tieto.com wrote:
> Hi Suraj,
>
>> From: Suraj Sumangala [mailto:suraj@atheros.com]
>> Sent: Tuesday, September 07, 2010 8:03 AM
>
>> +
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
>> +
>
> In my view, the disconnection should be initiates by the sap server, not by the agent. In a typical use case the agent will communicate sim state change (card removed or not accessible) to sap server. Based on that, the sap server should make a decision whether disconnect or not. What's more the disconnect procedure is defined in the SAP spec, and would be nice to keep all those procedures in the sap server, not in the agent which will be specific for a sim provider.  Therefore, I would remove this method call from the api.  I would add the Disconnect signal instead.
>
> Signal:
> Disconnect()
>        This signal will be send when SAP connectionis successfully removed.
>
> In case of graceful  disconnection sap server sends signal to the agent REQUEST(disconnect) and wait till  SIM free its stuff and send back RESPONSE(disconnect). In case  of immediate disconnection sap server will send Disconnect() signal to the agent.

Ok, In which all situations should the SAP server decide that the SAP 
connection has to be disconnected (you have mentioned Sim Status change 
as one candidate)?

Also, based on what should the server decide to initiate a "Graceful" or 
"Immediate" disconnection?

>
> Thanks,
> /Waldek

Regards
Suraj

