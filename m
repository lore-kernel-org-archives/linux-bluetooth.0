Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Aug 2016 14:57:50 +0300
Message-ID: <CABBYNZJoRBSHwfVErif-KV4TB9dK+4vb3FM8YC84_CgeQ+rKdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/6] plugins/policy: Fixes
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 28, 2016 at 5:27 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These patches fixes several problems with policy that were causing it to
> behave weirdly. It also fixes a couple of connection policy bugs when
> reconnection is active and another policy attempts to request a connection
> which could interfere with the desired intervals.
>
> Luiz Augusto von Dentz (6):
>   lib/uuid: Fix using unitialized values
>   plugins/policy: Revert patch 96db78604252eeb17614b9982ced95fd66c6c6fc
>   plugins/policy: Set list separator
>   main.conf: Remove spaces in reconnect list parameters
>   plugins/policy: Disable other connect policies while reconnect is
>     active
>   audio/a2dp: Fix always setting -EAGAIN for all errors
>
>  lib/uuid.c            |  7 +++++--
>  plugins/policy.c      | 45 +++++++++++++++++++++++++--------------------
>  profiles/audio/a2dp.c | 10 +++++-----
>  src/main.conf         |  4 ++--
>  4 files changed, 37 insertions(+), 29 deletions(-)
>
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
