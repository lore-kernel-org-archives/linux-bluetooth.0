Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 10:11:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Defer write to storage
Message-ID: <20121113081139.GC2206@x220>
References: <1352735024-2733-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1352735024-2733-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Mon, Nov 12, 2012, Frédéric Danis wrote:
> Defere write to storage using g_idle_add() to avoid multiple
> open/write/close operations when device properties are changed
> in sequence.
> ---
>  src/device.c |   24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Applied after a couple of cosmetic fixes (we try to use > 0 for testing
for valid GSource IDs). Thanks.

Johan
