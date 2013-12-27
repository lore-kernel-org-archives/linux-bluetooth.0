Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Dec 2013 17:22:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] tools/bluetooth-player: Formatting commands
Message-ID: <20131227152219.GA28321@x220.p-661hnu-f1>
References: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Fri, Dec 27, 2013, Sebastian Chlad wrote:
> Formatting commands passed to bluetooth player.
> Whitespace character trimmed.
> ---
>  tools/bluetooth-player.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index 622d391..1dadc70 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -1065,9 +1065,10 @@ static char **cmd_completion(const char *text, int start, int end)
>  
>  static void rl_handler(char *input)
>  {
> +

This line addition is unnecessary.

>  	int argc;
>  	char **argv = NULL;
> -	int i;
> +	int i, len;
>  
>  	if (!input) {
>  		rl_insert_text("quit");
> @@ -1080,6 +1081,12 @@ static void rl_handler(char *input)
>  	if (!strlen(input))
>  		goto done;
>  
> +	if (input) {
> +		len = strlen(input);
> +		if (len > 0 && input[len - 1] == ' ')
> +			input[len - 1] = '\0';
> +	}

Since bluetooth-player uses GLib I suppose it'd make more sense to use
the provided g_strstrip convenience function (or g_strchomp if you
really only want to strip trailing whitespace).

Johan
