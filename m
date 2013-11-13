Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 19:50:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Shutdown if IPC command for unregistered
 service is received
Message-ID: <20131113175006.GA24681@x220.p-661hnu-f1>
References: <1384354033-21724-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384354033-21724-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 13, 2013, Szymon Janc wrote:
> Sending commands to not registered services is violation of IPC spec
> and should result in daemon shutdown.
> ---
>  android/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Both patches have been applied (with some minor tweaks). Thanks.

Johan
