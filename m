Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
Date: Mon, 13 Apr 2015 16:38:57 +0300
Message-ID: <CABBYNZLwepfONDEtS_E9oODRRwzEfcB5hHcwFcBGhd1X9wyPPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Apr 10, 2015 at 10:06 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Adds a method to add the TX Power attribute to the advertisements that are sent
> through the D-Bus interface, and supports more than one advertisement based on
> the maximum number reported by the kernel.

That doesn't say why we should expose the IncludeTXPower, I thought we
would let bluetoothd figure if that should be included or not, we may
not have enough space or don't have this information from the
controller.

> Michael Janssen (4):
>   doc: Add IncludeTXPower to LE Advertising API
>   core/advertising: Parse IncludeTXPower
>   core/advertising: Support more than one advertisement.
>   test: add IncludeTXPower to example-advertisement
>
>  doc/advertising-api.txt    |  5 +++
>  src/advertising.c          | 86 +++++++++++++++++++++++++++++++++++++++++-----
>  test/example-advertisement |  4 +++
>  3 files changed, 87 insertions(+), 8 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
