Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] mgmt-api: Add support to get connection characteristics
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399420690-21653-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 6 May 2014 18:59:07 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	andrzej.kaczmarek@tieto.com
Message-Id: <BC6B9000-DD5A-4BA4-91B3-F68776872D78@holtmann.org>
References: <1399420690-21653-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch introduces Get Connection Characteristics command.
> ---
> doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cd5cd24..5d31a90 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1679,6 +1679,42 @@ Load Identity Resolving Keys Command
> 				Invalid Index
> 
> 
> +Get Connection Characteristics Command
> +======================================

we might need to discuss if we better call it “Get Connection Information”. I wait for other people to comment here.

> +
> +	Command Code:		0x0031
> +	Controller Index:       <controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Requested_Characteristics (4 Octet)

Maybe just calling this Data_Types is better. Not that it matters much, but the field name Requested_Characteristics sound a bit too much.

> +

Remove this extra empty line.

> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				RSSI (1 Octet)

Add the Flags (4 Octets) value here. We want to be flexible and being able to indicate certain flags might come in handy at some point.

> +				EIR_Data_Length (2 Octets)
> +				EIR_Data (0-65535 Octets)
> +
> +	This command is used to get connection characteristics information.
> +
> +	Requested_Characteristics parameter is a bitmask with currently the
> +	following available bits:
> +
> +		0	RSSI
> +		1	TX Power

Start with 0 = TX Power here. There is pretty much no point for RSSI since that will always be returned.

Also we need to note that all other bits are reserved and shall be set to zero. Unknown bits will be ignored by the kernel on reception.

> +	All the requested characteristics other than RSSI are returned in
> +	EIR_Data.
> +
> +	This command generates a Command Complete event on success and
> +	on failure.
> +
> +	Possible errors:	Busy
> +				Not Connected
> +				Not Powered
> +				Invalid Parameters
> +				Invalid Index

How can this return Busy? As I said before, we need to just have an internal configured via debugfs in which this command will return the cached values. So even if you call this twice in a row or at the same time, we should just return quickly.

Regards

Marcel

