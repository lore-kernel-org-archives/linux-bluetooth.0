Return-Path: <cyrus@holtmann.org>
Message-ID: <1326054253.6454.135.camel@aeonflux>
Subject: Re: Connectable PANU state for PTS certifications?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 08 Jan 2012 12:24:13 -0800
In-Reply-To: <A7CD2DBA66569F478A0C1ECFC39E1C521064C56B@DLEE74.ent.ti.com>
References: <A7CD2DBA66569F478A0C1ECFC39E1C521064C56B@DLEE74.ent.ti.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

> I am trying to pass PTS tests for PANU.
> Number of them try to initialize connection to PANU ( IUT ) and 
> fail because of " bluetoothd[298]: Server unavailable: (0x1115)".
> Spec. says that support for connectable mode in PANU is optional, 
> and the code ( server.c:: server_register() ) seems to register 
> only NAP server.
> 
> The question is - is it possible to enable the connectable PANU
> mode ( maybe via configuration or light modifications to the code )?

look at doc/network-api.txt. So in theory you can do something like
NetworkServer.Register("panu", "br0").

However I have the slight suspicion that only "nap" is really fully
implemented and tested.

Regards

Marcel


