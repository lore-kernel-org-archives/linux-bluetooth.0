Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <suraj@Atheros.com>
CC: <Suraj.Sumangala@Atheros.com>, <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Date: Mon, 13 Sep 2010 15:47:41 +0300
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <99B09243E1A5DA4898CDD8B700111448097968E69F@EXMB04.eu.tieto.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
 <99B09243E1A5DA4898CDD8B700111448097968E653@EXMB04.eu.tieto.com>
 <4C8E1942.40805@Atheros.com>
In-Reply-To: <4C8E1942.40805@Atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hi Suraj,

>The agent will be in a better position to take this decision 
>as it will be interfacing between actual card reader and SAP server.
>
>For example, if the agent is connected to an external card 
>reader and it has lost connection with the reader. It can ask 
>for an Immediate disconnection.

What will happen when dbus connection will be lost?  SAP server will start immediate disconnection. Right?

>If disconnection was triggered by a user action, it can decide 
>to call this API with Graceful as the parameter.

What exactly do you mean "triggerd by a user" ? Does agent interact with the user somehow?  In which way, any API for that? 

>One candidate would be when the MessageSize is changed.
>Another one will be with the "SimStatus" property. It makes 
>sense to raise his signal after the server sends the STATUS 
>IND response successfully.
>
>But, it is a fact that most of the Properties are set by the 
>Agent itself. So agent will know that they have changed.

Exactly.

Thanks,
/Waldek