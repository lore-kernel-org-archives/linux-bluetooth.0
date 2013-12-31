Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Dec 2013 11:35:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/hidhost: Move get_protocol parameter check
 to daemon
Message-ID: <20131231093502.GA12387@x220.p-661hnu-f1>
References: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388444180-13683-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 30, 2013, Szymon Janc wrote:
> HAL library is to be as simple as possible and parameters values should
> be verified by daemon for robustness anyway. Move this check to daemon.
> ---
>  android/hal-hidhost.c | 12 ++----------
>  android/hidhost.c     |  9 +++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)

All patches in this set have been applied. Thanks.

Johan
