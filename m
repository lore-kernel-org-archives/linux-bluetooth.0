Return-Path: <cyrus@holtmann.org>
Message-ID: <54D0B4C0.8090801@mozilla.com>
Date: Tue, 03 Feb 2015 12:45:04 +0100
From: Thomas Zimmermann <tzimmermann@mozilla.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Documentation: HAL IPC uses 4 octects for socket channel
References: <54D08B3F.5080202@mozilla.com> <1883387.StZLWa3Uue@uw000953>
In-Reply-To: <1883387.StZLWa3Uue@uw000953>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

Am 03.02.2015 um 12:35 schrieb Szymon Janc:
> Hi Thomas,
>
> On Tuesday 03 of February 2015 09:47:59 Thomas Zimmermann wrote:
>> The documentations says that the HAL IPC uses 2 octets for socket
>> channels, while |struct hal_cmd_socket_{listen,connect}| contain 4
>> octets. This patch fixes the documentation accordingly.
> I've applied the patch, thanks.
>
> Some notes though:
> - I've fixed commit message prefix (we try to keep those consistent for
>   easier history view)
> - I've removed SoB line - we don't use it in userspace code
> - for any future submissions please send patch inline (ie with git send-email)
>   instead of attaching it

Thanks a lot and sorry about the issues. It's my first patch here, I'll
try to do better.

Best regards
Thomas
