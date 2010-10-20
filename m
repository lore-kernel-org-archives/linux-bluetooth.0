Return-Path: <cyrus@holtmann.org>
Message-ID: <4CBEBA32.3040806@Atheros.com>
Date: Wed, 20 Oct 2010 15:15:22 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "charubala@charubala.com"
	<charubala@charubala.com>, Mahalingam Balamurugan
	<Mahalingam.Balamurugan@Atheros.com>
Subject: Re: [PATCH] Fix hidd showing different names for same device
References: <1287565973-5350-1-git-send-email-mbalamurugan@atheros.com>
In-Reply-To: <1287565973-5350-1-git-send-email-mbalamurugan@atheros.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

On 10/20/2010 2:42 PM, Balamurugan Mahalingam wrote:
> hidd shows different names for a same device when
> connected from GUI and CLI
>
> Blueman and other GUIs use the string from ServiceName attribute as
> device name in the SDP response, but hidd tool uses strings from
> Service Description and Provider Name atrribute.
>
> SDP response from Microsoft Bluetooth device has extended ASCII
> character 174(registered symbol) in its ServiceDescription attribute.
> Android platform expects the device name to have only printable
> characters and therefore GUI Crashes while connecting Microsoft
> Bluetooth Mouse using hidd
>
> Using the ServiceName attribute from the SDP response
> instead of ProviderName+ServiceDescription for device name in the
> hidd tool solves both the issues.
> ---

may be you can shorten the commit message. May be have something like this

This patch lets hidd use ServiceName attribute from the SDP response
instead of ProviderName+ServiceDescription for device name.
SDP response from Microsoft Bluetooth device has extended ASCII
character 174(registered symbol) in its ServiceDescription attribute.
This causes some Bluetooth application which expects only printable 
characters as device name to crash.

Regards
Suraj
