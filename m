Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Apr 2009 08:54:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Fix null dereference in gdbus/watch.c
Message-ID: <20090401055453.GB17550@jh-x301>
References: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br> <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 31, 2009, Gustavo F. Padovan wrote:
> If name or data->name is null we have a null dereference. Not name and
> data->name.
> ---
>  gdbus/watch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gdbus/watch.c b/gdbus/watch.c
> index 38bf3d7..607803c 100644
> --- a/gdbus/watch.c
> +++ b/gdbus/watch.c
> @@ -62,7 +62,7 @@ static struct name_data *name_data_find(DBusConnection *connection,
>  			current != NULL; current = current->next) {
>  		struct name_data *data = current->data;
>  
> -		if (name == NULL && data->name == NULL) {
> +		if (name == NULL || data->name == NULL) {
>  			if (connection == data->connection)
>  				return data;
>  		} else {

Pushed upstream. Marcel, you'll probably want to merge the patch with the other
gdbus-using projects too.

Johan
