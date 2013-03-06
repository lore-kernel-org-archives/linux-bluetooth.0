Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
References: <1362495595-17492-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 6 Mar 2013 12:04:18 +0200
Message-ID: <CABBYNZ+gmZ79A0Kij4pnHB9ZandaMNAN+bVgGcQ7L7kuxxAVQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fix state callbacks register/unregister in audio code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Mar 5, 2013 at 4:59 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> V2 fixes issues pointed by Luiz:
>  - callback registartion functions now takes device as first argument
>  - fixed typo in commit message
>  - fixed bogus return instead of continue in source_set_state
>
> Szymon Janc (6):
>   avdtp: Register state callback for specified audio device
>   avdtp: Remove user data from avdtp_session_state_cb
>   avctp: Allow to register state callback for specified audio device
>   avctp: Remove user data from avctp_session_state_cb
>   sink: Register state callback for specified audio device
>   source: Register state callback for specified audio device
>
>  profiles/audio/avctp.c     | 12 ++++++++----
>  profiles/audio/avctp.h     |  5 ++---
>  profiles/audio/avdtp.c     | 13 +++++++++----
>  profiles/audio/avdtp.h     |  6 +++---
>  profiles/audio/avrcp.c     |  4 ++--
>  profiles/audio/control.c   | 10 +++++-----
>  profiles/audio/device.c    | 33 ++++++++++++++++-----------------
>  profiles/audio/sink.c      | 26 ++++++++++++++------------
>  profiles/audio/sink.h      |  3 ++-
>  profiles/audio/source.c    | 27 +++++++++++++++------------
>  profiles/audio/source.h    |  3 ++-
>  profiles/audio/transport.c | 10 ++--------
>  12 files changed, 80 insertions(+), 72 deletions(-)
>
> --
> 1.8.1.5

Applied, thanks.


-- 
Luiz Augusto von Dentz
