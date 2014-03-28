Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Mar 2014 18:15:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] doc: Connection Parameters Command
Message-ID: <20140328161549.GA16919@t440s.P-661HNU-F1>
References: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Mar 24, 2014, Andre Guedes wrote:
> This patch introduces commands to add and remove connection parameters.
> ---
>  doc/mgmt-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)

All in all this looks pretty good to me. Just one thing I'd fix:

> +Add Connection Parameters Command
> +====================================
> +
> +	Command Code:		0x0032
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Auto_Connect_Option (1 Octet)
> +				Min_Connection_Interval (2 Octets)
> +				Max_Connection_Interval (2 Octes)
> +	Return Parameters:
> +

This should have the Address and Address_Type also in the return
parameters for consistency and ability to distinguish the completion of
two simultaneous commands for the different devices.

Johan
