Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 10 Dec 2012 14:50:05 +0200
Message-ID: <CABBYNZKhrYujwgvw46ggnuHSMiC-7xfnf+4Q+iD6BtP=2ZmWOQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Remove redundant struct audio_device members
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 5, 2012 at 12:10 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Both src and dst addresses can be obtained from struct btd_device
> reference and used when needed.
>
> Szymon Janc (9):
>   avdtp: Convert avdtp_get to accept audio_device
>   avdtp: Convert avdtp_is_connected to accept audio_device
>   avctp: Convert avctp_connect to accept audio_device
>   avctp: Convert avctp_get to accept audio_device
>   avctp: Don't use audio_device src and dst in avctp_control_confirm
>   avdtp: Don't use audio_device src and dst fields in avdtp_confirm_cb
>   audio: Don't use audio_device src and dst in manager_find_devices
>   avrcp: Don't use audio_device src field
>   audio: Remove src and dst from struct audio_device
>
>  profiles/audio/avctp.c     |   23 ++++++++++++++++++++---
>  profiles/audio/avctp.h     |    4 ++--
>  profiles/audio/avdtp.c     |   16 +++++++++++++---
>  profiles/audio/avdtp.h     |    4 ++--
>  profiles/audio/avrcp.c     |   16 +++++++++++-----
>  profiles/audio/control.c   |    4 ++--
>  profiles/audio/device.c    |   13 ++++---------
>  profiles/audio/device.h    |    7 +------
>  profiles/audio/manager.c   |   11 ++++++++---
>  profiles/audio/sink.c      |    2 +-
>  profiles/audio/source.c    |    2 +-
>  profiles/audio/transport.c |    3 +--
>  12 files changed, 66 insertions(+), 39 deletions(-)
>
> --
> 1.7.9.5

Pushed upstream, thanks.


--
Luiz Augusto von Dentz
