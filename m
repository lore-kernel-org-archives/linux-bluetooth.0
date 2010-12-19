Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Dec 2010 10:48:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix memory leak in adapter_service_ins_rem()
Message-ID: <20101219084803.GA1935@jh-x301>
References: <1292723784-10338-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292723784-10338-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Dec 18, 2010, Anderson Lizardo wrote:
> ---
>  src/adapter.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Thanks for catching this, however I went ahead and pushed a slightly
different (and imho simpler) fix. manager_find_adapter needs to iterate
through adapters while comparing addresses anyway so we might as well do
the address comparison within the for-loop in adapter_service_ins_rem().
That way there's no need to create an artificial list for the specific
adapter case.

Johan
