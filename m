Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:05:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Create btd_error_invalid_args()
Message-ID: <20101207210511.GB25558@jh-x301>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Dec 06, 2010, Gustavo F. Padovan wrote:
> DBus error handling in BlueZ is a mess. This is the first patch to unify
> all DBus error handling like in ConnMan and oFono. This unifies all
> .InvalidArguments errors.
> ---
>  attrib/client.c          |   20 ++++++-----------
>  audio/gateway.c          |    8 +-----
>  audio/headset.c          |   18 +++++----------
>  audio/media.c            |    9 ++-----
>  audio/telephony-dummy.c  |   25 ++++++++------------
>  audio/telephony-maemo5.c |   11 ++------
>  audio/telephony-maemo6.c |   11 ++------
>  audio/transport.c        |   14 +++--------
>  health/hdp.c             |   54 ++++++++++++----------------------------------
>  network/server.c         |    7 ------
>  plugins/service.c        |    8 +------
>  serial/port.c            |    8 ------
>  serial/proxy.c           |   19 +++++-----------
>  src/adapter.c            |   52 +++++++++++++++++++------------------------
>  src/device.c             |   22 ++++++------------
>  src/error.c              |    7 ++++++
>  src/error.h              |    2 +
>  src/manager.c            |    7 ------
>  18 files changed, 99 insertions(+), 203 deletions(-)

This as well as the second patch (ERROR_NOT_SUPPORTED) have been pushed
upstream.

Johan
