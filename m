Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Aug 2011 11:07:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/12] Add messages to the mgmt interface to handle
 SMP key storage
Message-ID: <20110831080706.GA5861@dell.ger.corp.intel.com>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313799128-8842-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313799128-8842-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Aug 19, 2011, Vinicius Costa Gomes wrote:
> +Load SMP Keys Command
> +=====================
> +
> +	Command Code:		0x001F
> +	Controller Index:	<controller id>
> +	Command Parameters:	Debug Keys (1 Octet)
> +				Key Count (2 Octets)
> +				Key1 {
> +					Address (6 Octets)
> +					Type (1 Octet)
> +					PIN_Length (1 Octet)

Isn't the PIN Length completely irrelevant here since the "Passkey
Entry" pairing method of SSP always requires a 6-digit passkey?

> +					Value (16 Octets)
> +					[
> +						Encryption Size (1 Octet)
> +						Enc. Diversifier (2 Octets)
> +						Random Number (8 Octets)
> +					] || [
> +						Address Type (1 Octet)
> +					]

Having unions within mgmt messages starts to push their complexity over
the level that I feel comfortable with. Would it make sense to instead
have separate "Load LTKs" and "Load IRKs" commands (though you'd then
need to have two separate "New LTK" and "New IRK" events too).

Btw, what exactly do you need the Address Type for in the case of IRKs
and why don't you need it in the case of LTKs?

Johan
