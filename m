Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Date: Thu, 16 Apr 2015 18:05:43 +0300
Message-ID: <CABBYNZLrTeEPMzMq_5tfERZmGmCc_wnb-uQT0qYLAK-Hc1NXGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/6] Improvements to the LE Advertising API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Apr 15, 2015 at 1:06 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Adds a method to add the TX Power attribute to the advertisements that are sent
> through the D-Bus interface, and supports more than one advertisement based on
> the maximum number reported by the kernel.
>
> v1 -> v2:
>   * Rebase
>   * Bugfixes
>   * Improve error messages from MGMT api
>   * Fix possible issue with dbus_bool_t type
>   * Patch to fix object matching
>   * Fix instance ids
>
> Michael Janssen (6):
>   core/advertising: Fix dbus object matching
>   doc: Add IncludeTXPower to LE Advertising API
>   core/advertising: Parse IncludeTXPower
>   core/advertising: Support more than one advertisement.
>   test: add IncludeTXPower to example-advertisement
>   core/advertising: improve errors for add advertising
>
>  doc/advertising-api.txt    |   5 ++
>  src/advertising.c          | 150 ++++++++++++++++++++++++++++++++++++++-------
>  test/example-advertisement |   4 ++
>  3 files changed, 137 insertions(+), 22 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
