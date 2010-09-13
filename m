Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <suraj@atheros.com>, <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>
Date: Mon, 13 Sep 2010 15:11:49 +0300
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <99B09243E1A5DA4898CDD8B700111448097968E653@EXMB04.eu.tieto.com>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
In-Reply-To: <1284374584-12282-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj, 

>+		void Disconnect(string type)
>+
>+			This initiates a SAP disconnection from 
>SAP server.
>+
>+			The type parameter specifies the type 
>of disconnection.
>+
>+			"Graceful"  -> lets the SAP client initiate a
>+			garceful disconnection.
>+
>+			"Immediate" -> disconnects the connection
>+			immediately from the server.

How agent will use this method? I mean when it is supposed to use gracefull and when immediate disconnection?

>+Signals		PropertyChanged(string name, variant value)
>+
>+			This signal indicates a changed value 
>of the given
>+			property.

Is the signal really needed?  Who is interested in keeping track on properties?


Thanks,
/Waldek
