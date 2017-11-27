Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 27 Nov 2017 10:53:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Hobot <michal.hobot@silvair.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh/onoff-model: Fix msec to sec conversion
Message-ID: <20171127085325.GA21890@x1c.lan>
References: <2C0A6DE1-E4B3-4728-B485-0A19BF3419CA@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C0A6DE1-E4B3-4728-B485-0A19BF3419CA@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal

On Sat, Nov 25, 2017, Michal Hobot wrote:
> There is an error in meshctl while displaying transition time. 1000 ms
> is being presented as 16 sec, 40 ms. The reason is incorrect
> conversion of milliseconds to seconds.  The fix is pretty trivial.
> 
> --- ../../bluez/mesh/onoff-model.c	2017-11-21 18:04:57.000000000 +0100
> +++ onoff-model.c	2017-11-21 17:25:14.000000000 +0100
> @@ -77,8 +77,8 @@ static void print_remaining_time(uint8_t
>  	switch (step) {
>  	case 0:
>  		msecs = 100 * count;
> -		secs = msecs / 60;
> -		msecs -= (secs * 60);
> +		secs = msecs / 1000;
> +		msecs -= (secs * 1000);
>  		break;
>  	case 1:
>  		secs = 1 * count;

Thanks, the patch has been applied. I had to apply manually however and
fix up the commit message to make sure it adheres to a max 72 line
length. In the future, could you either try send patches using git
send-email, or at least format them with the help of git format-patch,
since what you sent now was unrecognizable to "git am" which is used for
applying patches. Thanks.

Johan
