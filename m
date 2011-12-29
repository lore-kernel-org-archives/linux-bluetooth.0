Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325080093-20469-2-git-send-email-frederic.danis@linux.intel.com>
References: <1325080093-20469-1-git-send-email-frederic.danis@linux.intel.com>
	<1325080093-20469-2-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 29 Dec 2011 10:49:07 +0200
Message-ID: <CABBYNZJGakUpv=vbq47h7qxaCNV5p808Jq5YYj7TxwmbBH6oEA@mail.gmail.com>
Subject: Re: [RFC v6 1/8] audio: Move tel drivers to DBus interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/12/28 Frédéric Danis <frederic.danis@linux.intel.com>:
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

This should be an object not a string and IMO it should be called
Transport just to keep it sort.


-- 
Luiz Augusto von Dentz
