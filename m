Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Dec 2011 12:15:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Add KeyboardDisplay IO Capability.
Message-ID: <20111227101502.GE5584@x220.P-661HNU-F1>
References: <1324881311-26211-1-git-send-email-hemant.gupta@stericsson.com>
 <1324881311-26211-2-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324881311-26211-2-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Dec 26, 2011, Hemant Gupta wrote:
> This patch adds suppport for KeyboardDisplay IO capability in BlueZ.
> ---
>  src/adapter.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 2d9e368..3bdf525 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -74,6 +74,7 @@
>  #define IO_CAPABILITY_DISPLAYYESNO	0x01
>  #define IO_CAPABILITY_KEYBOARDONLY	0x02
>  #define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
> +#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
>  #define IO_CAPABILITY_INVALID		0xFF
>  
>  #define check_address(address) bachk(address)
> @@ -1634,6 +1635,8 @@ static uint8_t parse_io_capability(const char *capability)
>  		return IO_CAPABILITY_KEYBOARDONLY;
>  	if (g_str_equal(capability, "NoInputNoOutput"))
>  		return IO_CAPABILITY_NOINPUTNOOUTPUT;
> +	if (g_str_equal(capability, "KeyboardDisplay"))
> +		return IO_CAPABILITY_KEYBOARDDISPLAY;
>  	return IO_CAPABILITY_INVALID;
>  }

We will also need a patch to hciops to ensure that this is only used for
SMP whereas for SSP KEYBOARDDISPLAY needs to be mapped to DISPLAYYESNO.
Are you working on that? The same will also be needed for the mgmt code
in the kernel, but I can do that part unless someone beats me to it.

Johan
