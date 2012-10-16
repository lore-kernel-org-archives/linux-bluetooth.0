Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Oct 2012 13:37:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] audio: Move btd_device unref after last use in
 device_free
Message-ID: <20121016103754.GA509@x220>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 16, 2012, Szymon Janc wrote:
> btd_device should not be used after local reference was dropped.
> 
> ---
>  audio/device.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All patches in this set have been applied. Thanks.

As a note for future commit messages please prefix lib/* changes with
"lib: ..". I fixed it manually this time.

Johan
