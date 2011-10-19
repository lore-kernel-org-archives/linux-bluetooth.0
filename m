Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318980279-2331-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318980279-2331-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 19 Oct 2011 12:31:58 +0300
Message-ID: <CABBYNZJVx_W02Sjf4J9dwj1DF9i5UHGzo=JapxXBE2uWM3gCBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix MediaPlayer documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 19, 2011 at 2:24 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  doc/media-api.txt |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b8dcdbd..e061f38 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -180,12 +180,6 @@ Signals            PropertyChanged(string setting, variant value)
>
>                                        Track duration in milliseconds
>
> -               StatusChanged(string status, uint32 position)
> -
> -                       Possible status: "playing", "stopped", "paused",
> -                                       "forward-seek", "reverse-seek" or
> -                                       "error"
> -

Nice catch.

>  Properties     string Equalizer [readwrite]
>
>                        Possible values: "off" or "on"
> @@ -203,13 +197,13 @@ Properties        string Equalizer [readwrite]
>
>                        Possible values: "off", "alltracks" or "group"
>
> -               string Status [readonly]
> +               string Status [readwrite]
>
>                        Possible status: "playing", "stopped", "paused",
>                                        "forward-seek", "reverse-seek" or
>                                        "error"
>
> -               uint32 Position [readonly]
> +               uint32 Position [readwrite]

Im not sure about making those properties readwrite, iirc there is no
way to set those values directly via AVRCP commands instead there is
the key presses to control the playback, so for now I would leave them
as readonly so the player don't have to handle this in
org.bluez.MediaPlayer.SetProperty.


-- 
Luiz Augusto von Dentz
