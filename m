Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
References: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 5 Mar 2013 15:58:58 +0200
Message-ID: <CABBYNZLtvTojVt29mTKC8j4jCa4DcBXCFOdBsf=e5LH16dkqGA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix state callbacks register/unregister in audio code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Mar 5, 2013 at 1:06 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This attempts to fix some missing state cb unregister in audio code.
>
> Instead of registering general callback and filter stuff in cb itself
> allow to specify for which audio device callback should be called.
> This allows to cleanly register/unregister for state callbacks on per
> device basis without increasing number of runtime calback calls.
>
> Szymon Janc (6):
>   avdtp: Register state callback for specified audio device
>   avdtp: Remove user data from avdtp_session_state_cb
>   avctp: Allow to register state callback for specified audio device
>   avctp: Remove user data from avdtp_session_state_cb
>   sink: Register state callback for specified audio device
>   source: Register state callback for specified audio device
>
>  profiles/audio/avctp.c     | 12 ++++++++----
>  profiles/audio/avctp.h     |  5 ++---
>  profiles/audio/avdtp.c     | 13 +++++++++----
>  profiles/audio/avdtp.h     |  6 +++---
>  profiles/audio/avrcp.c     |  2 +-
>  profiles/audio/control.c   | 10 +++++-----
>  profiles/audio/device.c    | 33 ++++++++++++++++-----------------
>  profiles/audio/sink.c      | 26 ++++++++++++++------------
>  profiles/audio/sink.h      |  3 ++-
>  profiles/audio/source.c    | 27 +++++++++++++++------------
>  profiles/audio/source.h    |  3 ++-
>  profiles/audio/transport.c | 10 ++--------
>  12 files changed, 79 insertions(+), 71 deletions(-)
>
> --
> 1.8.1.5

I think the callback registration should take the device first
followed by the callback not the other way around, there seems to be a
typo in avctp: Remove user data from avdtp_session_state_cb (I guess
should be avctp_session_state_cb).


--
Luiz Augusto von Dentz
