Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 7/7] Update Management API documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Date: Wed, 15 Jun 2011 15:10:52 -0700
In-Reply-To: <4df91d74.0b73650a.190f.17ad@mx.google.com>
References: <y> <1308171784-24442-1-git-send-email-y>
	 <4df91d74.0b73650a.190f.17ad@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308175855.2196.7.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Add Read RSSI and Read TX Power level commands in Management API
> documentation.
> ---
>  doc/mgmt-api.txt |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 353705e..b442cc5 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -319,6 +319,26 @@ Stop Discovery Command
>  	Command Parameters:
>  	Return Parameters:
>  
> +Read RSSI Command
> +=================
> +
> +	Command Code:		0x001D
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +	Return Parameters:	Status (1 Octet)
> +				Address (6 Octets)
> +				RSSI (1 Octet)
> +
> +Read TX Power Level Command
> +===========================
> +
> +	Command Code:		0x001E
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +	Return Parameters:	Address (6 Octets)
> +				Status (1 Octet)
> +				Level (1 Octet)
> +

so why are these two separate commands. Just reading them in one kernel
call might be a lot better. Including everything else you need to know
about the connection. Also TX power can be local and remote TX power if
I remember this correctly.

Regards

Marcel


