Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Thomas Zimmermann <tzimmermann@mozilla.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Documentation: HAL IPC uses 4 octects for socket channel
Date: Tue, 03 Feb 2015 12:35:30 +0100
Message-ID: <1883387.StZLWa3Uue@uw000953>
In-Reply-To: <54D08B3F.5080202@mozilla.com>
References: <54D08B3F.5080202@mozilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Tuesday 03 of February 2015 09:47:59 Thomas Zimmermann wrote:
> The documentations says that the HAL IPC uses 2 octets for socket
> channels, while |struct hal_cmd_socket_{listen,connect}| contain 4
> octets. This patch fixes the documentation accordingly.

I've applied the patch, thanks.

Some notes though:
- I've fixed commit message prefix (we try to keep those consistent for
  easier history view)
- I've removed SoB line - we don't use it in userspace code
- for any future submissions please send patch inline (ie with git send-email)
  instead of attaching it

-- 
Best regards, 
Szymon Janc
