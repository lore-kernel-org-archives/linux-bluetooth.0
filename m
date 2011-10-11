Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 16:01:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/1] Fix OPP not sending TransferCompleted signal
Message-ID: <20111011130142.GA18124@fusion.localdomain>
References: <1317978670-24903-1-git-send-email-lkslawek@gmail.com>
 <1317978670-24903-2-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317978670-24903-2-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Oct 07, 2011, Slawomir Bochenski wrote:
> Commit 934b3b2f5f8432b67822be9f83a141fe3783cbd7 introduced a regression
> in OPP, by making it not send TransferCompleted signal. This happened
> because OPP was calling manager_emit_transfer_completed() on .reset(),
> and manager_emit_transfer_completed() in turn checks if the os->object
> is not NULL. This fixes this by moving clearing os->object after doing
> service driver .reset().
> ---
>  src/obex.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
