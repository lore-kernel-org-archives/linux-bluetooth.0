Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH BlueZ v2 09/12] unit/gatt: Add clarifying note about dup tests.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420493574-37305-10-git-send-email-jamuraa@chromium.org>
Date: Mon, 5 Jan 2015 15:19:26 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BE2FF42E-20B1-48B4-A7AB-80C4BEA62931@holtmann.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org> <1420493574-37305-10-git-send-email-jamuraa@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> BV-05-C tests are identical to the BV-04-C tests, so add a note
> explaining as such.
> ---
> unit/test-gatt.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index b8815ee..de3fe8b 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -1680,6 +1680,11 @@ int main(int argc, char *argv[])
> 			raw_pdu(0x08, 0x29, 0x00, 0x29, 0x00, 0x03, 0x28),
> 			raw_pdu(0x01, 0x08, 0x29, 0x00, 0x0a));
> 
> +	/*
> +	 * Note: /TP/GAD/CL/BV-05-C and /TP/GAD/SV/BV-05-C are identical to
> +	 * /TP/GAD/CL/BV-04-C and /TP/GAD/SV/BV-04-C for BlueZ
> +	 */
> +

can we just add a copy of the test even while it is the same test. Makes it a lot easier to keep track of since you can list the test cases with -l option.

Regards

Marcel

