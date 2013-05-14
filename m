Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 May 2013 20:15:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] doc: Add reauthentication commands and event to
 Management API
Message-ID: <20130514231538.GA395@samus.indt.org>
References: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com>
 <1368566595-8836-2-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368566595-8836-2-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 23:23 Tue 14 May, Szymon Janc wrote:
> Those will be used to allow/disallow of performing remote device
> reauthentication.

I guess you could expand this explaining why you need this in the MGMT API,
i.e. why this can't be implemented on userspace only.

> ---
>  doc/mgmt-api.txt |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1e450e4..96603cd 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1223,6 +1223,82 @@ Set Device ID Command
>  	Possible errors:	Invalid Parameters
>  				Invalid Index
>  
> +Set Reauthentication Policy Command
> +===================================
> +
> +	Command Code:		0x0029
> +	Controller Index:	<non-controller>
> +	Command Parameters:	Policy (1 Octet)
> +	Return Parameters:
> +
> +	This command is used to change kernel policy regarding remote device
> +	reauthentication. When remote device reports no link key presence while
> +	kernel holds link key for this device action taken by kernel depends on
> +	selected policy.
> +
> +	The Policy parameter selects desired policy:
> +
> +		0x00	Disallow
> +		0x01	Ask for consent
> +		0x02	Reauthenticate without asking for consent
> +
> +	By default 'Disconnect' policy is used. Selecting 'Ask for consent'

Minor nitpick, here "Disconnect" should read "Disallow".

> +	policy will result in emmiting 'Reauthentication Consent Event' if
> +	circumstance described above occurs.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +
> +Reauthentication Consent Reply Command
> +======================================
> +
> +	Command Code:		0x002A
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to respond to a Reauthentication Consent event.
> +	This will result in current link key being removed by kernel and new
> +	authentication process will start.
> +
> +	This command can only be used when the controller is powered.
> +
> +	This command generates a Command Complete event on success
> +	or failure.
> +
> +	Possible errors:	Not Connected
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +				Failed
> +
> +Reauthentication Consent Negative Reply Command
> +===============================================
> +
> +	Command Code:		0x002B
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to return a negative response to a Reauthentication
> +	Consent event.
> +
> +	This command can only be used when the controller is powered.
> +
> +	This command generates a Command Complete event on success
> +	or failure.
> +
> +	Possible errors:	Not Connected
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +				Failed
>  
>  Command Complete Event
>  ======================
> @@ -1621,3 +1697,32 @@ Event Parameters	Address (6 Octets)
>  	The Passkey parameter indicates the passkey to be shown to the
>  	user whereas the Entered parameter indicates how many characters
>  	the user has entered on the remote side.
> +
> +Reauthentication Consent Event
> +==============================
> +
> +Event Code		0x0018
> +Controller Index	<controller id>
> +Event Parameters	Address (6 Octets)
> +			Address_Type (1 Octet)
> +
> +	This event is used to request a consent for reauthentication. It is
> +	emmited when remote device reports no link key presence while kernel
> +	holds link key and reuthentication policy for this device is set to
> +	'Ask for consent'.
> +
> +	User space should respond to this command either using the
> +	Reauthentication Consent Reply or the Reauthentication Consent Negative
> +	Reply command.
> +
> +Reauthentication Policy Changed Event
> +=====================================
> +
> +Event Code		0x0019
> +Controller Index	<non-controller>
> +Event Parameters	Policy (1 Octet)
> +
> +	This event indicates that reauthentication policy has been changed
> +	using Set Reauthentication Policy command. The event will only be sent
> +	to Management sockets other than the one through which the command was
> +	sent.

I still can't see the reason for this. Is it because this policy is global
(not per-controller)?


> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
