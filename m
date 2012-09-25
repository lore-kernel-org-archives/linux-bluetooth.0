Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Sep 2012 15:58:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Fix attempting to create a device on driver
 .remove
Message-ID: <20120925125806.GA22183@x220>
References: <1348570499-7442-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348570499-7442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Sep 25, 2012, Luiz Augusto von Dentz wrote:
> audio_remove calls get_audio_dev which may attempt to create the device
> if it doesn't exist.
> ---
>  audio/manager.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
