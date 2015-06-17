Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jun 2015 15:48:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Simon Wood <simon@mungewell.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] bccmd - add ability to read ADC
Message-ID: <20150617124842.GA17715@t440s.P-661HNU-F1>
References: <06F67222-BAF1-455D-A4B8-4560FE84EE69@holtmann.org>
 <1433786660-2169-1-git-send-email-simon@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433786660-2169-1-git-send-email-simon@mungewell.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Mon, Jun 08, 2015, Simon Wood wrote:
> Some BlueCore devices are equipped with an 'Analogue In' pin which is
> internally connected to a MUX and ADC. This patch adds the ability to
> control the MUX and read the ADC.
> 
> The ADC is also connected internal to a temp sensor, which can also be
> read via this method.
> 
> The (only) MUX values expected to be used are:
> 1  Internal 1V25 reference
> 16 BlueCore01b pin Test_A; BlueCore2-External pin AIO0
> 17 BlueCore01b pin Test_B; BlueCore2-External pin AIO1
> 36 Chip’s internal temperature (change) sensor. BlueCore2-ROM and later only.
> 
> The MUX can also select other (undocumented) test points.
> 
> Example usage
> --
> $ ./bccmd -t HCI -d hci1 adc 17
> ADC value from Mux 0x11 : 0x0054 (valid)
> $ ./bccmd -t HCI -d hci1 adc 1
> ADC value from Mux 0x01 : 0x00b2 (valid)
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

No Signed-off-by lines for user space patches please.

> +static int cmd_adc(int transport, int argc, char *argv[])
> +{
> +	uint8_t array[8];
> +	uint16_t mux, value;
> +	int err;
> +
> +	OPT_HELP(1, NULL);
> +
> +	if (!strncasecmp(argv[0], "0x", 2))
> +		mux = strtol(argv[0], NULL, 16);
> +	else
> +		mux = atoi(argv[0]);
> +
> +	// Request an ADC read from a particular mux'ed input

No C++ style comments please. Use /* ... */

> +	// sleep, then read result

Same here.

And the patch doesn't actually compile:

tools/bccmd.c:1068:2: error: implicit declaration of function ‘usleep’ [-Werror=implicit-function-declaration]
  usleep(50000);
  ^

Please add the necessary include for that (unistd.h, I believe).

Johan
