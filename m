Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 13:08:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
Message-ID: <20131220110823.GA28419@x220.p-661hnu-f1>
References: <1387537166-7703-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387537166-7703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Dec 20, 2013, Luiz Augusto von Dentz wrote:
> This use dup to create a new fd to be used by AVDTP session leaving the
> caller free to close the original fd. Note that even if the caller
> decides to keep the original fd it will still be notified when
> avdtp_shutdown is called since it uses shutdown.
> ---
>  android/a2dp.c  | 6 +++++-
>  android/avdtp.c | 9 ++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
