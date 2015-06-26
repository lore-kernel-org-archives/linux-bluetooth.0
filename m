Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1435320003-14720-1-git-send-email-luiz.dentz@gmail.com>
References: <1435320003-14720-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 26 Jun 2015 11:08:12 -0700
Message-ID: <CAPyD+=CichTsAGNKRO14L2pXhGxdVnk27+qZZc1B-tAr2M7c1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/advertising: Fix using wrong instance id
From: "Othman, Ossama" <ossama.othman@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 26, 2015 at 5:00 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The instance id shall be limited to the number of instance the kernel
> support, and since this will probably be quite small the ids should be
> reused once the client unregistered.
> ---
>  src/advertising.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> ...

This patch appears to address the problem I was seeing with the failed
advertisement registration.  With it in place I'm able to repeatedly
register/unregister my advertisement without problem.

Thanks!
-Ossama
