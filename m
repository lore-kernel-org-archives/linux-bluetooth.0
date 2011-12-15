Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com>
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com>
	<1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 15 Dec 2011 12:00:11 +0200
Message-ID: <CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com>
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/12/14 Frédéric Danis <frederic.danis@linux.intel.com>:
> +TelephonyAgent hierarchy
> +========================
> +
> +Service                unique name
> +Interface      org.bluez.TelephonyAgent
> +Object path    freely definable
> +
> +Methods                void NewConnection(filedescriptor fd, dict properties)
> +
> +                       This method gets called whenever a new connection
> +                       has been established. This method assumes that DBus
> +                       daemon with file descriptor passing capability is
> +                       being used.
> +
> +                       The agent should only return successfully once the
> +                       establishment of the service level connection (SLC)
> +                       has been completed.  In the case of Handsfree this
> +                       means that BRSF exchange has been performed and
> +                       necessary initialization has been done.
> +
> +                       possible properties:
> +
> +                               strict Device:
> +
> +                                       BlueZ remote device object.
> +
> +                               string UUID:
> +
> +                                       Profile UUID of the connection.
> +
> +                               uint16 Version:
> +
> +                                       Remote profile version.
> +
> +                               uint16 Features:
> +
> +                                       Remote profile features.
> +
> +                               string MediaTransportPath:
> +
> +                                       Optional. MediaTransport object path.

I thought we had agreed in having the transport implemented directly
inside the agent, at least that was my proposal, otherwise it keeps
bluetoothd in the middle of the communication. It may not seem obvious
but we should target low latency as we are dealing with audio the
events need to be propagated fast.

So instead of MediaTransportPath, what I suggest is sending the
endpoint itself e.g. string,object Endpoint Connection id and object
path of the MediaEndpoint to be used. This means the agent e.g. oFono
will have to create an object which implements
org.bluez.MediaTransport and then call
org.bluez.MediaEndpoint.SetConfiguration in the received object.


-- 
Luiz Augusto von Dentz
