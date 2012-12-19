Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 19 Dec 2012 14:16:59 +0200
Message-ID: <CABBYNZ+okMZM4vVUaG3snyfPMi2Fjzh0i7+BfDJx3MNW77xA2Q@mail.gmail.com>
Subject: Re: [PATCH 00/16] audio: Use device/adapter reference instead of bdaddr_t
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 12, 2012 at 12:27 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This remove use of bdaddr_t in favour of using references to struct btd_adapter
> and struct btd_device.
>
> note:
> This patch triggers a bug introduced when a2dp was splitted into two
> btd_profile resulting in a2dp_unregister() is never called (so adapter
> ref is not dropped properly). This is not fixed in this patch set.
>
> Szymon Janc (16):
>   a2dp: Remove bogus '\' at the end of line
>   a2dp: Remove useless return
>   a2dp: Remove not used macros definitions
>   a2dp: Convert sink/source register to accept btd_adapter
>   a2dp: Convert a2dp_unregister to accept btd_adapter
>   media: Convert register/unregister to accept btd_adapter
>   a2dp: Convert a2dp_add_sep to accept struct btd_adapter
>   avdtp: Use refs to adapter and device instead of bdaddr_t
>   a2dp: Use btd_adapter ref in a2dp_server instead of bdaddr_t
>   avrcp: Convert to accept btd_adapter instead of bdaddr_t
>   avctp: Convert register/unregister to accept btd_adapter
>   avdtp: Replace avdtp_get_peers with adapter and device getters
>   audio: Use manager_get_device to get device object
>   audio: Make manager_get_device accept btd_device
>   audio: Simplify manager_find_device
>   avctp: Remove double looking for audio device
>
>  profiles/audio/a2dp.c    |  75 +++++++++++---------------
>  profiles/audio/a2dp.h    |   8 +--
>  profiles/audio/avctp.c   |  96 +++++++++++++++-------------------
>  profiles/audio/avctp.h   |   4 +-
>  profiles/audio/avdtp.c   | 119 ++++++++++++++++++------------------------
>  profiles/audio/avdtp.h   |  10 ++--
>  profiles/audio/avrcp.c   |  37 ++++++-------
>  profiles/audio/avrcp.h   |   6 +--
>  profiles/audio/manager.c | 133 +++++++++--------------------------------------
>  profiles/audio/manager.h |  17 +-----
>  profiles/audio/media.c   |  35 ++++++-------
>  profiles/audio/media.h   |   4 +-
>  profiles/audio/sink.c    |   5 +-
>  profiles/audio/source.c  |   5 +-
>  14 files changed, 206 insertions(+), 348 deletions(-)
>
> --
> 1.8.0

All patches are now upstream, thanks.


--
Luiz Augusto von Dentz
