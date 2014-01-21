Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jan 2014 11:08:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] emulator: Fix unaligned memory access compilation
 errors
Message-ID: <20140121090825.GA11102@x220.p-661hnu-f1>
References: <1390268769-30209-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390268769-30209-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Jan 20, 2014, Anderson Lizardo wrote:
> The u128_xor() function does proper aligned access and accepts void *
> arguments, therefore the casts are unnecessary and trigger clang errors.
> ---
>  emulator/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
