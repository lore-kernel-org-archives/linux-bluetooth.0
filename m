Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: L2CAP socket to HCI handle, opposite possible?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANLOmB5fo8JvrtXGdp+3eqXcPiSauEyD8L6Gcer0cWD6+Qtp_A@mail.gmail.com>
Date: Tue, 17 Jun 2014 14:55:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FDFE96A3-5B0D-440D-B9BF-1905E4BC2034@holtmann.org>
References: <CANLOmB5UXAJRModTofiYy-gtj=DvDiq_PU_n6NswrbXw_9_94A@mail.gmail.com> <CD90C45F-0899-43A6-870C-DE24E43E5D04@holtmann.org> <CANLOmB5fo8JvrtXGdp+3eqXcPiSauEyD8L6Gcer0cWD6+Qtp_A@mail.gmail.com>
To: Seon-Wook Park <seon.wook@swook.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sean-Wook,

no top posting on this mailing list please.

> Thank you for your suggestions.
> 
> I notice in `doc/mgmt-api.txt` that there is no mention of updating
> connection parameters, which is what we're currently aiming to get by
> tweaking the library used. These parameters include:
> 
> - min. interval
> - max. interval
> - latency
> - supervisor timeout
> 
> Is it possible to set connection parameters on BLE connect using the
> mgmt API? It is possible with `hci_le_conn_create` but not with the
> opening of an L2CAP socket connection.

if you search the archive there is an API proposal for storing proposed connection parameters and being able to load them back on system start. So that once a peripheral has proposed different connection parameters, they will be horned automatically for the next connection creation.

Changing them on the central independent on what the peripheral wants from us is something that only Bluetooth 4.1 devices with link layer topology are suppose to do and for that a new L2CAP socket option would be needed.

Regards

Marcel

