Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Feb 2013 15:55:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/9] player: Add media_player_create_item
Message-ID: <20130227135559.GA4052@x220.ger.corp.intel.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
 <1361970961-14300-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361970961-14300-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 27, 2013, Luiz Augusto von Dentz wrote:
> Items are not only folders so this split the item creation from
> media_player_create_folder.
> ---
>  profiles/audio/player.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index b222643..8401e19 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -1092,11 +1092,15 @@ static const GDBusPropertyTable media_item_properties[] = {
>  	{ }
>  };
>  
> -int media_player_create_folder(struct media_player *mp, const char *name)
> +static struct media_item *media_player_create_item(struct media_player *mp,
> +							const char *name,
> +							bool folder,
> +							bool playable)
>  {
>  	struct media_item *item;
>  
> -	DBG("%s", name);
> +	DBG("%s folder %s playable %s", name, folder ? "true" : "false",
> +						playable ? "true" : "false");
>  
>  	item = g_new0(struct media_item, 1);
>  	item->player = mp;

It seems you're missing the updated assignments to item->folder/playable
here.

Also, to make the code more readable I'd suggest creating an enum called
media_item_type which would have the possible values of folder and item.
I'm also not sure if you want to pass the playable value in this
create() API since that only exist for folder type.

I also took a look at the D-Bus API and you'll probably want to split
the type property into MediaType and FolderType for clarity, as well as
document that the Playable property is only available for folders but
not regular media items. The possible values for the Type property are
also incorrect since we use a foo-bar-baz convention for string enums
instead of CamelCase.

Johan
