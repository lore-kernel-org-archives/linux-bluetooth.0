Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/3] Bluetooth: Implement Read RSSI command
From: Marcel Holtmann <marcel@holtmann.org>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 13 Jul 2011 20:12:45 +0200
In-Reply-To: <4e1da4a5.04bfec0a.4243.00d9@mx.google.com>
References: <y> <4e1da4a5.04bfec0a.4243.00d9@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310580766.21109.96.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreson,

> This patch implements helper functions to make Read RSSI command
> interceptable by MGMT Interface. It adds a new wrapper in HCI layer and
> add a hook to call mgmt_read_rssi_complete when MGMT Interface has been
> loaded.
> 
> Read RSSI command is defined on Part E, section 7.5.4 of Bluetooth 4.0
> Spec.

I think that I mentioned this before. This is not something I like to
see at all. 1:1 copies of HCI commands is pointless.

If you need RSSI results, then something like proper interval and
thresholds should be supported. Also with future Bluetooth SIG work on
having controller driven notifications in this area.

Regards

Marcel


