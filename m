Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3] mgmt-api: Add support to get connection information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399553999-14566-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 8 May 2014 07:54:42 -0700
Cc: linux-bluetooth@vger.kernel.org, andrzej.kaczmarek@tieto.com
Message-Id: <1A84D9AC-18BD-4DAE-9456-202EC4BE2FB9@holtmann.org>
References: <1399553999-14566-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch introduces Get Connection Information command.
> ---
> 
> v2: Changed Command name and add Flags into the response
> v3: Added TXPowerMax into the response based on the comments we got.
> 
> doc/mgmt-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cd5cd24..8345048 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1679,6 +1679,45 @@ Load Identity Resolving Keys Command
> 				Invalid Index
> 
> 
> +Get Connection Information Command
> +==================================
> +
> +	Command Code:		0x0031
> +	Controller Index:       <controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Data_Type (4 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				RSSI (1 Octet)
> +				TXPowerMax (1 Octet)

this one looks weird now. In this case, we better just do RSSI, TX Max Power and TX Power at the same time. So this needs a bit of thinking.

Just start with the basic implementation and we sort out the details of the mgmt later. Right now I would have left the TX Max Power out of it completely.

Regards

Marcel

