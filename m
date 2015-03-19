Return-Path: <cyrus@holtmann.org>
Message-ID: <1426760605.3386.38.camel@linux.intel.com>
Subject: Re: [PATCH] doc: Add initial 6LoWPAN API definition
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Mar 2015 12:23:25 +0200
In-Reply-To: <1426756230-422-1-git-send-email-johan.hedberg@gmail.com>
References: <1426756230-422-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

looks good, except for couple of comments below

On to, 2015-03-19 at 11:10 +0200, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> ---
> +Connect Command
> +===============
> +
> +	Command Code:		0x0004
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Network_Interface (16 Octets)
> +
> +	This command is used to connect to a remote 6LoWPAN server.

We should probably say "... remote 6LoWPAN node" here instead.

> +
> +	The returned Network_Interface parameter is a nul-terminated
> +	string containing the created network interface name.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +
> +
> +Disconnect Command
> +==================
> +
> +	Command Code:		0x0005
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to disconnect from a remote 6LoWPAN server.

Ditto

> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Not Connected
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +
> +
> +Start Server Command

The specification talks about "Router" so should we use same terminology
here instead of "Server"?

> +====================
> +
> +	Command Code:		0x0005
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:
> +
> +	This command is used to start a 6LoWPAN server for a specified
> +	controller.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Invalid Index
> +
> +
> +Stop Server Command

Ditto.

> +===================
> +
> +	Command Code:		0x0006
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:
> +
> +	This command is used to stop a 6LoWPAN server for a specified
> +	controller.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Rejected
> +				Invalid Index
> +


Cheers,
Jukka


