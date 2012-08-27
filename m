Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346068966-8077-1-git-send-email-chanyeol.park@samsung.com>
References: <1346059192-6114-1-git-send-email-chanyeol.park@samsung.com>
	<1346068966-8077-1-git-send-email-chanyeol.park@samsung.com>
Date: Mon, 27 Aug 2012 15:59:17 +0300
Message-ID: <CABBYNZLhwTvc5Yordd9VawrF-BCbrQ76PFZuvk9o-bMkC7J_+g@mail.gmail.com>
Subject: Re: [PATCH v3] storage: Fix Discoverable mode not updated on storage.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Mon, Aug 27, 2012 at 3:02 PM,  <chanyeol.park@samsung.com> wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
>
> This patch fixes the problem that storage's Discoverable value is
> not updated like hciconfig when BlueZ receives the MGMT adapter mode
> changed event after DiscoverableTimeout has been expired.
>
> This problem occurs because no longer bluetoothd does not take on
> requesting part to disable discoverable when the timer expires.
> ---
>  src/adapter.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 69ec821..7d06633 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2249,6 +2249,11 @@ static void set_mode_complete(struct btd_adapter *adapter)
>                 adapter->mode_sessions = NULL;
>         }
>
> +       modestr = mode2str(adapter->mode);
> +       write_device_mode(&adapter->bdaddr, modestr);
> +
> +       DBG("%s", modestr);
> +
>         if (adapter->pending_mode == NULL)
>                 return;
>
> @@ -2273,16 +2278,6 @@ static void set_mode_complete(struct btd_adapter *adapter)
>                 g_dbus_send_message(connection, reply);
>         }
>
> -       modestr = mode2str(adapter->mode);
> -
> -       DBG("%s", modestr);
> -
> -       /* restore if the mode doesn't matches the pending */
> -       if (err != 0) {
> -               write_device_mode(&adapter->bdaddr, modestr);
> -               error("unable to set mode: %s", mode2str(pending->mode));
> -       }
> -
>         session_unref(pending);
>  }
>
> --
> 1.7.9.5

Ive changed a little bit the commit message to be more clear about
what we are fixing, but it is now pushed upstream.


-- 
Luiz Augusto von Dentz
