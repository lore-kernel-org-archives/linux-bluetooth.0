Return-Path: <cyrus@holtmann.org>
Message-ID: <1331512937.14217.74.camel@aeonflux>
Subject: Re: [PATCH] mgmt-api: add read Tx power level command
From: Marcel Holtmann <marcel@holtmann.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 11 Mar 2012 17:42:17 -0700
In-Reply-To: <1331503837-19015-1-git-send-email-arik@wizery.com>
References: <1331503837-19015-1-git-send-email-arik@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

> This command reads the Tx power level for a given connected device
> ---
>  doc/mgmt-api.txt |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 4ede43d..8dae2b4 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -815,6 +815,34 @@ Unblock Device Command
>  	or failure.
>  
> 
> +Read Tx Power Level Command
> +======================
> +
> +	Command Code:		0x0028

how is this suppose to work. This command and Set Device ID are suppose
to have the same command code?

> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Status (1 Octet)
> +				Level (1 Octet)
> +
> +	Possible values for the Address_Type parameter:
> +		0	BR/EDR
> +		1	LE Public
> +		2	LE Random
> +
> +	Possible values for the Type parameter:
> +		0	Current Transmit Power Level
> +		1	Maximum Transmit Power Level

Which ones do you care about? And why not just read both and return both
at the same time.

I think that I made this pretty clear multiple times already. The mgmt
API is not for stuffing random HCI commands into it. Please explain your
usage pattern of the results clearly.

Who is triggering this command and who is consuming the results?

Regards

Marcel


