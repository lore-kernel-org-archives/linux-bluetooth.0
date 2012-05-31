Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 11:32:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Remove compatibility check for DBUS_TYPE_UNIX_FD
Message-ID: <20120531083219.GA17071@x220>
References: <1338412579-22890-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338412579-22890-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, May 30, 2012, Anderson Lizardo wrote:
> Since commit c89b589a586e97ad875fbdd1d41f03979157ebb0, D-Bus >= 1.4.0 is
> required. This version already contains Unix FD passing support,
> therefore code that checks for DBUS_TYPE_UNIX_FD definition is
> unnecessary.
> ---
>  audio/gateway.c      |    7 -------
>  audio/gstavdtpsink.c |    4 ----
>  audio/manager.c      |    4 ----
>  audio/media.c        |    7 -------
>  audio/transport.c    |    4 ----
>  doc/hfp-api.txt      |    4 +---
>  health/hdp.c         |    4 ----
>  serial/port.c        |    7 -------
>  8 files changed, 1 insertion(+), 40 deletions(-)

Applied. Thanks.

Johan
