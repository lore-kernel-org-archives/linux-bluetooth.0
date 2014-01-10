Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 10 Jan 2014 17:49:18 +0200
Message-ID: <CABBYNZJR9+mtp20dyZifcieRmPA8RiZVA7XBSZmbk2NO1APT8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Next skeleton patches for audio plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Jan 10, 2014 at 3:24 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> v1:
> Those patches adds function to handle send/receive msg on audio IPC.
> Also adds some small changes.
>
> Not that since we do not yet support AUDIO_OP_OPEN, audio socket will be
> reseted just after connect.
>
> v2:
> Fixes suggester by Luiz
> Some additional fixes
>
> Lukasz Rymanowski (7):
>   android/audio: Prefix error log with "audio"
>   android: Fix error check from pthread_create
>   android/audio: Refactor create_audio_ipc
>   android/audio: Trivial function move
>   android/audio: Add skeleton for ipc_open_cmd function
>   android/audio: Add audio_ipc_cmd
>   android/audio: Add audio_ipc_cleanup function
>
>  android/Makefile.am |   1 +
>  android/hal-audio.c | 304 ++++++++++++++++++++++++++++++++++++++++++----------
>  android/hal-ipc.c   |   6 +-
>  3 files changed, 250 insertions(+), 61 deletions(-)
>
> --
> 1.8.4

Ive applied some of these set, any of those that involved the command
I left out for now since they are not complete and they would
otherwise just cause failures now that haltest does load
audio.a2dp.default.so.


-- 
Luiz Augusto von Dentz
