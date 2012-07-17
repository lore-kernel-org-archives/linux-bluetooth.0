Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 11:44:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] mgmt-api: Broadcaster/Observer management API
Message-ID: <20120717084417.GA1097@x220>
References: <1342038888-10102-1-git-send-email-anderson.lizardo@openbossa.org>
 <1342038888-10102-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342038888-10102-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jul 11, 2012, Anderson Lizardo wrote:
> +Set Controller Data Command
> +===========================
> +
> +	Command Code:		0x002B
> +	Controller Index:	<controller id>
> +	Command Parameters:	Flags (1 Octet)
> +				Data_Type (1 Octet)
> +				Data_Length (1 Octet)
> +				Data (0-255 Octets)
> +	Return Parameters:
> +

The return parameters should include the Flags and Data_Type so that
user space can distinguish which Set Controller Data command completed
or failed (in the case of multiple pending commands). Same goes for the
Remove Controller Data command.

> +	This command can be used to set AD for LE capable controllers or EIR
> +	for BR/EDR controllers. Multiple AD/EIR types can be configured by
> +	calling this command multiple times. If the data does not fit on a
> +	single AD/EIR on the controller, it will be rotated based on the "High
> +	priority" flag, so data with this flag set will stay longer over the
> +	air than those with this flag cleared.

I'm still struggling to see the usefulness or even the feasibility of a
meaningful rotation of data. Is there actually some place in the core
spec that implies or recommends that this be done? More importantly, is
there some place that states that the content of multiple different AD
packets from the same remote device should be considered in an
aggregated manner instead of considering each of them as a
unique/complete state of the remote device? If there's no such mention
there's nothing stopping devices from using the latter interpretation
and in such a case any kind of rotation could mess things up. Also the
fact that there exists short/incomplete variants of many AD types
(UUIDs, device name) seems to indicate that if any kind of compromising
mechanism should be used when trying to fit data, this is it.

Johan
