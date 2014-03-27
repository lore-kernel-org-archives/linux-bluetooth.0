Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Add initial handling of register_for_notification
Date: Thu, 27 Mar 2014 20:27:17 +0100
Message-ID: <1946037.K2TfiEKbtd@athlon>
In-Reply-To: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395844640-11602-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 26 March 2014 15:37:17 Marcin Kraglak wrote:
> This command will register for both notifications and indications for given
> characteristic and service. Notifications list will be stored in
> client struct.
> ---
>  android/gatt.c | 187
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> 185 insertions(+), 2 deletions(-)

I've already applied Jakub's patches so you need to rebase this.

-- 
Szymon K. Janc
szymon.janc@gmail.com
