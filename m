Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Aug 2010 09:17:29 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Solve compilation warning usin gcc 4.5.0
Message-ID: <20100811131729.GA13302@jh-x301>
References: <201008111455.41381.santoscadenas@gmail.com>
 <1281531992-10976-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281531992-10976-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 11, 2010, Jose Antonio Santos Cadenas wrote:
> ---
>  audio/control.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/control.c b/audio/control.c
> index c8aba53..24db448 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -437,7 +437,7 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
>  {
>  	GSList *l;
>  	struct audio_device *dev = control->dev;
> -	avdtp_session_state_t old_state = control->state;
> +	avctp_state_t old_state = control->state;
>  	gboolean value;
>  
>  	switch (new_state) {

Thanks. The patch is now upstream.

Johan
