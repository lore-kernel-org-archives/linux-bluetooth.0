Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 16:49:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android: Add initial Android Bluetooth Audio
 protocol API doc
Message-ID: <20131213144922.GE30037@x220.p-661hnu-f1>
References: <1386938480-12049-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386938480-12049-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Dec 13, 2013, Luiz Augusto von Dentz wrote:
> This IPC is used to communicate Android BlueZ daemon and AudioFlinger
> plugin.
> ---
>  android/audio-ipc-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 android/audio-ipc-api.txt

This seems to be missing an addition to EXTRA_DIST. Once you've fixed
that feel free to push this yourself.

Also, I assume you've got missing bits, like those for suspending and
resuming streams planned for later patches?

Johan
