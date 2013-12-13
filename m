Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 16:46:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] bnep: Refactored bnep connect and disconnect calls
Message-ID: <20131213144603.GC30037@x220.p-661hnu-f1>
References: <1386938150-5683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386938150-5683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Dec 13, 2013, Ravi kumar Veeramally wrote:
> Refactored bnep connect and disconnect calls to simply and
> keeping bnep related functionality behind curtains.
> Provided bnep_struct, bnep_new and bnep_free to intialize
> and free the bnep_stuct with basic parameters. bnep_connect
> calls takes care of bnep_setup until interface up then connect
> callback will be called, disconnect_cb is registered as watchdog
> and it will triggered by remote device on disconnect or any other
> I/O error. bnep_disconnect should be called only when iface is
> up/connected.
> ---
>  android/pan.c                 |  97 ++++++++++++-------------------
>  profiles/network/bnep.c       | 131 ++++++++++++++++++++++++++++++------------
>  profiles/network/bnep.h       |  14 +++--
>  profiles/network/connection.c |  50 ++++++++++------
>  4 files changed, 173 insertions(+), 119 deletions(-)

This is a bit too much stuff in a single patch which makes it hard to
follow exactly what the patch is doing. Could you please try to split
this up into multiple patches? Thanks.

Johan
