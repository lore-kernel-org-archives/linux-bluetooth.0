Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334135558-21866-4-git-send-email-michal.labedzki@tieto.com>
References: <1334135558-21866-1-git-send-email-michal.labedzki@tieto.com>
	<1334135558-21866-4-git-send-email-michal.labedzki@tieto.com>
Date: Wed, 11 Apr 2012 14:10:59 +0300
Message-ID: <CABBYNZLqv7XVHBtsoXAu-SVfTRsoC4TrG8zv63RRARxWnrEiig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] AVRCP: Add support to changing active player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Apr 11, 2012 at 12:12 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:

>  static GDBusMethodTable media_methods[] = {
>        { "RegisterEndpoint",   "oa{sv}",       "",     register_endpoint },
>        { "UnregisterEndpoint", "o",            "",     unregister_endpoint },
>        { "RegisterPlayer",     "oa{sv}a{sv}","",       register_player },
>        { "UnregisterPlayer",   "o",            "",     unregister_player },
> +       { "SetActivePlayer",    "o",            "",     set_active_player },
>        { },
>  };
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index c53ab7b..c64d1f5 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -123,6 +123,11 @@ Methods            void RegisterEndpoint(object endpoint, dict properties)
>
>                        Unregister sender media player.
>
> +               void SetActivePlayer(object player)
> +
> +                       Set active media player. Only one active player may be used
> +                       by remote controller.
> +

The use case here seems to be incorrect or Im missing something, I
remember commenting that such method is not really desirable since the
controlling point, at least for the current role, is the remote device
so having the players or a external component to control that will
only complicate things. Also this creates a limitation since only one
player can be marked as active at time, IMO the Active property should
only tell if the player can be addressed by the remote device so the
application can keep itself registered but idle (player out of
focus/minimized).

>  MediaPlayer hierarchy
>  =====================
>
> @@ -188,6 +193,15 @@ Signals            PropertyChanged(string setting, variant value)
>
>                                        Track duration in milliseconds
>
> +               Activated()
> +
> +                       This signal indicates one player to be currently used.
> +
> +               Deactivated()
> +
> +                       This signal sends to all non-active players and indicates that
> +                       player lose focus.
> +

I would make it a boolean property called Active, 2 signal is a pretty
bad since you actually have to emit both everytime.


-- 
Luiz Augusto von Dentz
