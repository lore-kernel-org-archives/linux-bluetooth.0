Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:16:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix invalid free when stopping adapter
Message-ID: <20110927091655.GP3952@dell>
References: <1316527880-8081-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316527880-8081-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 20, 2011, Claudio Takahasi wrote:
> This patch fix an "invalid free" error when the adapter is powered off
> with an active discovery session. Error happens because session_remove
> function removes the elements from the list also. Partial valgrind log:
> Address 0x6012a00 is 0 bytes inside a block of size 16 free'd
>   at 0x4C27DCC: free (vg_replace_malloc.c:366)
>   by 0x4E927AC: g_slist_remove (in
>   by 0x19F788: session_remove (adapter.c:689)
>   by 0x19F82A: session_free (adapter.c:708)
>   by 0x4E92CD6: g_slist_foreach (in
>   by 0x4E92CFA: g_slist_free_full (in
>   by 0x1A3ADD: btd_adapter_stop (adapter.c:2491)
> ---
>  src/adapter.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
