Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1388413892-10018-1-git-send-email-sebastianx.chlad@intel.com>
References: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
	<1388413892-10018-1-git-send-email-sebastianx.chlad@intel.com>
Date: Tue, 31 Dec 2013 13:55:15 +0200
Message-ID: <CABBYNZLQ9BJDCj9myR4Ba2Qx92bOc-=2VtSi3Pv4v=7kpXMYUQ@mail.gmail.com>
Subject: Re: [PATCH] tools/bluetooth-player: Formatting commands
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Mon, Dec 30, 2013 at 4:31 PM, Sebastian Chlad
<sebastianchlad@gmail.com> wrote:
> Formatting commands passed to bluetooth player.
> Whitespace character trimmed.
> ---
>  tools/bluetooth-player.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index 622d391..2afdd17 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -1080,6 +1080,7 @@ static void rl_handler(char *input)
>         if (!strlen(input))
>                 goto done;
>
> +       g_strstrip(input);
>         add_history(input);
>
>         argv = g_strsplit(input, " ", -1);
> --
> 1.7.9.5

Pushed, I went ahead and pushed a similar fix to obexctl and it seems
bluetoothctl could use the same logic but it doesn't use g_strsplit
and it does in fact check trailing whitespaces:

if (arg) {
    int len = strlen(arg);
    if (len > 0 && arg[len - 1] == ' ')
        arg[len - 1] = '\0';
}

We might be better off with g_strstrip + g_strsplit since we depend on
glib anyway.


-- 
Luiz Augusto von Dentz
