Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jun 2013 13:41:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/player: Fix crash when current item UID is
 set to 0
Message-ID: <20130626104156.GA28255@x220.ger.corp.intel.com>
References: <1372243017-1461-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372243017-1461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 26, 2013, Luiz Augusto von Dentz wrote:
> Apparently some stacks set the current UID to 0 when paused/stopped which
> causes the following:
> 
> bluetoothd[23185]: profiles/audio/player.c:media_player_set_playlist_item() 0
> bluetoothd[23185]: profiles/audio/player.c:media_folder_create_item() (null) type audio uid 0
> process 23185: arguments to dbus_message_iter_append_basic() were incorrect, assertion "_dbus_check_is_valid_path (*string_p)" failed in file dbus-message.c line 2531.
> This is normally a bug in some application using the D-Bus library.
>   D-Bus not built with -rdynamic so unable to print a backtrace
> 
> UID 0 is not a valid UID according to the spec so the code should not attempt
> to create any object to represent it.
> ---
>  profiles/audio/player.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
