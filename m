Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 17:09:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	charubala@charubala.com
Subject: Re: [PATCH] hidd shows different names for same device when
 connected from GUI and CLI.
Message-ID: <20101019140916.GA14730@jh-x301>
References: <1287496282-16170-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287496282-16170-1-git-send-email-mbalamurugan@atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 19, 2010, Balamurugan Mahalingam wrote:
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
>  compat/sdp.c |   33 +++++++++++++++++----------------
>  1 files changed, 17 insertions(+), 16 deletions(-)

Same issues as with the previous commit message. Lines should be max 74
characters long and please redo the summary line to be of the format
"Fix ..." and shorter than it is now.

Btw, why are you using hidd and not the bluetoothd input plugin? hidd is
legacy stuff which will disappear from BlueZ in the future.

Johan
