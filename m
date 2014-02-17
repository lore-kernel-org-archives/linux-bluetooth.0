Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 17 Feb 2014 14:02:04 +0200
Message-ID: <CABBYNZJwKnmVuD0WNqBO4tVhdHs6Z-Qf9ErLnUpmpiss7bwN-A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fixes for memory leaks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sat, Feb 8, 2014 at 12:28 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> Hi all,
>
> This patch set fixes some memory leaks reported by clang static analyzer.
> There is no relation between patches of this set so they can be applied
> independently.
>
> BR,
>
> Andre
>
>
> Andre Guedes (5):
>   hcitool: Fix memory leak in cmd_info
>   hcidump: Fix memory leak
>   cltest: Fix memory leak
>   amptest: Fix memory leak
>   rctest: Fix memory leak
>
>  tools/amptest.c | 12 ++++++++----
>  tools/cltest.c  |  5 +++--
>  tools/hcidump.c |  9 +++++++--
>  tools/hcitool.c |  3 +++
>  tools/rctest.c  |  5 ++++-
>  5 files changed, 25 insertions(+), 9 deletions(-)
>
> --
> 1.8.5.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
