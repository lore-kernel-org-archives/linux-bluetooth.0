Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] make test/agent.c use new API
From: Marcel Holtmann <marcel@holtmann.org>
To: Filippo Giunchedi <filippo@esaurito.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090607081101.GA30589@esaurito.net>
References: <1244330332.23850.77.camel@localhost.localdomain>
	 <20090607081101.GA30589@esaurito.net>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 10:42:30 +0200
Message-Id: <1244364150.23850.80.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

> I've fixed the space vs tab usage, sorry.
> I'm not sure how to handle this case:
> 
> -	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Request"))
> +	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPinCode") ||
> +			dbus_message_is_method_call(msg, "org.bluez.Agent",
> +								"RequestPasskey"))
> 
> with proper indentation but not going over 80 columns, that's what I came up
> with, hope that's ok.

it is not, because you need to split them into two functions anyway. One
returns a string, the other a uint32. Please read agent-api.txt.

Regards

Marcel


