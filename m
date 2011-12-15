Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:37:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key
 Size via btio
Message-ID: <20111215113720.GB6824@x220>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Dec 13, 2011, Vinicius Costa Gomes wrote:
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -63,6 +63,7 @@ extern "C" {
>  #define BT_SECURITY	4
>  struct bt_security {
>  	uint8_t level;
> +	uint8_t key_size;
>  };
>  #define BT_SECURITY_SDP		0
>  #define BT_SECURITY_LOW		1

This libbluetooth change will need to be in a separate patch since it
needs to be backported to hcidump (which now days has a copy of the lib).

Johan
