Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:00:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix incorrect use of atoi in maemo6
Message-ID: <20111028110019.GA15672@fusion.localdomain>
References: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Oct 27, 2011, Dmitriy Paliy wrote:
> Use of atoi is incorrect and unsafe in maemo6 telephony and replaced
> by g_ascii_digit_value.
> ---
>  audio/telephony-maemo6.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
> index 5df3235..a546f44 100644
> --- a/audio/telephony-maemo6.c
> +++ b/audio/telephony-maemo6.c
> @@ -823,7 +823,9 @@ static int tonegen_startevent(char tone)
>  		event_tone = DTMF_D;
>  		break;
>  	default:
> -		event_tone = atoi(&tone);
> +		event_tone = g_ascii_digit_value(tone);
> +		if (event_tone < 0)
> +			return -EINVAL;
>  	}
>  
>  	ret = send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,

Doesn't compile:

udio/telephony-maemo6.c: In function ‘tonegen_startevent’:
audio/telephony-maemo6.c:827:3: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]


Please fix and resend.

Johan
