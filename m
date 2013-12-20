Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 09:44:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 6/6] emulator: Remove not necessary
 bthost_set_server_psm
Message-ID: <20131220074428.GC18981@x220.p-661hnu-f1>
References: <1387463345-26406-1-git-send-email-marcin.kraglak@tieto.com>
 <1387463345-26406-6-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387463345-26406-6-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Dec 19, 2013, Marcin Kraglak wrote:
> Remove not necessary function and replace all uses with new one,
> bthost_add_l2cap_server().
> ---
>  android/android-tester.c | 2 +-
>  emulator/bthost.c        | 5 -----
>  emulator/bthost.h        | 2 --
>  tools/l2cap-tester.c     | 3 ++-
>  4 files changed, 3 insertions(+), 9 deletions(-)

Correction to my previous "all patches applied email": this patch hasn't
been applied. Please split it into three separate ones. Two patches to
convert the last users in l2cap-tester and android-tester and a third
patch to remove the old function.

Johan
