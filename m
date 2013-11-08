Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 13:05:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 2/5] android/hid: Fix set report data format in daemon
Message-ID: <20131108110528.GC28608@x220.p-661hnu-f1>
References: <1383906271-23554-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383906271-23554-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383906271-23554-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> Report data coming to HAL is in ascii format, HAL sends
> data in hex to daemon, so convert to binary.
> ---
>  android/hidhost.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index c7b4114..9b4bb15 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -98,6 +98,14 @@ struct hid_device {
>  	uint8_t		last_hid_msg;
>  };
>  
> +static void hex2bin(const uint8_t *ascii, int ascii_len, uint8_t *hex)
> +{
> +	int i;
> +
> +	for (i = 0; i < ascii_len / 2; i++)
> +		sscanf((char *) &ascii[i * 2], "%hhx", &hex[i]);
> +}

You're still calling the input parameter ascii and the output parameter
hex. Also, I'm still fine if you just drop this function altogether and
do the conversion inline in the two places that you need it.

>  	if (write(fd, req, req_size) < 0) {
> -		error("error while querying device protocol");
> +		error("error while sending report");

If you're fixing this error, how about fixing it to properly print the
exact error in the same go, i.e. using strerror?

Johan
