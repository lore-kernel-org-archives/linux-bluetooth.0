Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318250231-14001-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318250231-14001-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1318250231-14001-2-git-send-email-lucas.demarchi@profusion.mobi>
Date: Tue, 11 Oct 2011 12:46:53 +0300
Message-ID: <CABBYNZKcRX6Oq2HJZ_wBB3iJ0eB_f17+kwKQfBwPutuFwZV03w@mail.gmail.com>
Subject: Re: [PATCH 2/7] Fix typo on doc
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 10, 2011 at 3:37 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  doc/media-api.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index af4cfa0..7dc7661 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -133,7 +133,7 @@ Object path freely definable
>  Methods                void SetProperty(string property, variant value)
>
>                        Changes the value of the specified property. Only
> -                       properties that are listed a read-write can be changed.
> +                       properties that are listed as read-write can be changed.
>
>                        On success this will emit a PropertyChanged signal.
>
> --
> 1.7.7
>

Ack.

-- 
Luiz Augusto von Dentz
