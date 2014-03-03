Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Mar 2014 16:52:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/rfcomm-tester: Add bind after connected test case
Message-ID: <20140303145223.GA15433@localhost.P-661HNU-F1>
References: <1392300683-13835-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392300683-13835-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Feb 13, 2014, Andrzej Kaczmarek wrote:
> This testcase will check if it's possible to bind socket on the same
> channel number as used by some other socket connected to remote device.
> ---
>  tools/rfcomm-tester.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

Sorry for not getting around to this one earlier.

> @@ -389,10 +397,24 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
>  		return false;
>  	}
>  
> -	if (err < 0)
> +	if (!client_data->bind_channel) {
> +		if (err < 0)
> +			tester_test_failed();
> +		else
> +			tester_test_passed();
> +		return false;
> +	}
> +
> +	master_addr = hciemu_get_master_bdaddr(data->hciemu);
> +	sk = create_rfcomm_sock((bdaddr_t *) master_addr,
> +						client_data->bind_channel);
> +	if (sk < 0) {
>  		tester_test_failed();
> -	else
> +	} else {
> +		close(sk);
>  		tester_test_passed();
> +	}
> +
>  
>  	return false;
>  }

Considering that rc_connect_cb is a generic function used by many test
cases I find it strange to add this much extra code for it for a single
special case which is only needed by a single test case. I'd rather have
this in a separate function.

Either reuse the existing test_connect() and add a way to specify (in
the test case declaration) a custom function to pass to g_io_add_watch()
or then create completely new test function from scratch. This will help
avoid confusion when someone tries to understand what all the other
tests which do not need this extra hack are trying to do.

Johan
