Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Feb 2011 10:30:21 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash on badly formated AT+VTS command
Message-ID: <20110207183021.GA19505@jh-x301>
References: <1297098456-30695-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297098456-30695-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Feb 07, 2011, Dmitriy Paliy wrote:
> This fixes bluetoothd crash when AT+VTS command is badly formatted,
> e.g. as AT+VTS\xfe\xfe[...]=1
> ---
>  audio/headset.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/headset.c b/audio/headset.c
> index 0270e2c..da499d8 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -1015,12 +1015,18 @@ int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
>  
>  static int dtmf_tone(struct audio_device *device, const char *buf)
>  {
> +	char *pch;
> +
>  	if (strlen(buf) < 8) {
>  		error("Too short string for DTMF tone");
>  		return -EINVAL;
>  	}
>  
> -	telephony_transmit_dtmf_req(device, buf[7]);
> +	pch = strchr(&buf[6],'=');
> +	if (pch)
> +		telephony_transmit_dtmf_req(device, *(++pch));
> +	else
> +		return -EINVAL;
>  
>  	return 0;
>  }

Nack. You need to think about this a bit more. Firstly, you should just
reject a command which isn't properly formatted. What you're now doing
is adding code to handle this particular incorrectly formated command
while leaving the code still open for exploitation with differently
incorrectly formated commands.

The cause of the crash would seem to be that if the value of the tone
character is greater than 127 it creates a string in
telephony_transmit_dtmf_req (telephony-maemo6.c) which isn't valid
UTF-8. DBUS_TYPE_STRING parameters need to be valid UTF-8 and if they
aren't D-Bus will just disconnect you (which in turn will cause
bluetoothd to exit). So it seems bluetoothd shouldn't crash in this
scenario but just exit.

So, the appropriate fix would be to add checks that reject (return ERROR
response) if the character immediately after AT+VGS isn't '=' or if the
character after '=' isn't less than 128 in value (if it's greater than
127 it would result in an invalid UTF-8 string in telephony-maemo6.c).

Johan
