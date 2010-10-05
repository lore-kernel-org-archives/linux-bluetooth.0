Return-Path: <cyrus@holtmann.org>
Subject: Re: Sim Access profile server implementation
From: Marcel Holtmann <marcel@holtmann.org>
To: suraj <suraj@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <1285657515.12097.7.camel@atheros013-desktop>
References: <1285657515.12097.7.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 10:02:10 +0200
Message-ID: <1286265730.17473.29.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Please find the Git tree for the Sim access profile server role
> implementation I have been working on at
> 
> git://gitorious.org/sap-server/sap-server.git
> 
> Not sure it could be directly used with Bluez. Nevertheless, it has the
> parser implementation of Bluetooth SAP packet. Someone could possibly
> reuse it in their implementation.

have you actually tested this with real SAP server capable hardware? I
am still not convinced at all to push APDU over D-Bus. First, there is
potential security issue here and second the latency that D-Bus
introduces seems not be acceptable. So what I am getting it, can this be
actually used in a product that seriously wants to support SAP server?

Regards

Marcel


