Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Mar 2013 17:55:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Subject: Re: [PATCH] core: Double free on adapter_stop
Message-ID: <20130330155523.GA27129@x220.P-661HNU-F1>
References: <1364591903-29947-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364591903-29947-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, Mar 29, 2013, Alex Deymo wrote:
> The discovery_list list has the list of current discovery clients and is
> removed on adapter_stop (for example due a "power off" command). The
> g_slist_free_full will call discovery_free on every element of the list
> and remove the nodes of the list, but discovery_destroy (called by
> discovery_free) will not only free the element, but also remove it from
> the list. This causes the list node to be freed twice, once by
> g_slist_free_full and once by g_slist_remove.
> 
> This fix calls successively discovery_free and lets it remove the list one
> by one.
> ---
>  src/adapter.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index e553626..ac322de 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4272,8 +4272,11 @@ static void adapter_stop(struct btd_adapter *adapter)
>  	cancel_passive_scanning(adapter);
>  
>  	if (adapter->discovery_list) {
> -		g_slist_free_full(adapter->discovery_list, discovery_free);
> -		adapter->discovery_list = NULL;
> +		while (adapter->discovery_list) {
> +			struct discovery_client *client =
> +						adapter->discovery_list->data;
> +			discovery_free(client);
> +		}
>  
>  		adapter->discovering = false;
>  	}

Good catch, but you could go even further and remove the discovery_free
function too since its only purpose was to match the expected type for
g_slist_free_full (which you no-longer use). Please add a code comment
though clarifying that g_dbus_remove_watch takes care of the freeing and
list element removal.

Also, I'd go ahead and remove one level of nesting here since the
if-statement before the while loop is a bit redundant (the setting of
discovering to false can be unconditional afterwards).

Johan
