Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] doc: Add EIR to device properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403897492-6233-1-git-send-email-scott@netsplit.com>
Date: Fri, 27 Jun 2014 21:55:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> This patch proposes an extension to the D-Bus Device API to allow
> an application access to the last EIR data received from a device
> in inquiry or advertising mode.
> 
> Rationale is that increasing numbers of LE profiles are using custom
> fields in the advertising and scan response reports to carry important
> information. e.g. the Anki Drive peripherals include necessary
> information in the advertiesment that is not replicated in the GATT
> Service they export.
> 
> It would be nice if it were possible to support these profiles at the
> application layer without extending BlueZ every time via a plugin.
> 
> Since EIR has a variable-length type field, more complex parsing
> would require applications registering the types with BlueZ in advance
> putting a higher complexity burden on the daemon, including resolving
> conflicts where types overlap. Exposing the raw EIR data to the
> application allows them to deal with all such problems in whatever
> manner they require.
> ---
> doc/device-api.txt | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 577ee60..9620ec0 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -193,3 +193,8 @@ Properties	string Address [readonly]
> 
> 			Received Signal Strength Indicator of the remote
> 			device (inquiry or advertising).
> +
> +		array{byte} EIR [readonly, optional]
> +
> +			Last received EIR data from the remote device
> +			during inquiry or advertising.

in general I have no objections in exposing the EIR and AD information. However I do not like to use EIR as property key. I know that on mgmt API we simply went with EIR_Data, but on the D-Bus API we most likely need to find a name that is a bit more generic and allows to represent EIR and AD information.

One important thing we have to consider are dual-mode devices that are found via LE and BR/EDR. With dual-mode topology from Bluetooth 4.1 this will become a real possibility and we want them to show under one object path. I think we need to brainstorm a little on how this can be done best.

Regards

Marcel

