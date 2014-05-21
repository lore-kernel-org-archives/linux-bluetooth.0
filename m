Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 May 2014 10:16:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared: Fix queue_find to accept const ptr as match
 data
Message-ID: <20140521071632.GA22541@t440s.lan>
References: <1400081232-19459-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400081232-19459-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, May 14, 2014, Andrzej Kaczmarek wrote:
> This patch fixes queue_find definition to have const pointer as data to
> be matched against. Match function already does have const pointers as
> arguments. Also parameter name is updated to be 'match_data' since this
> actually is not user_data, just data to be matched against.
> ---
>  src/shared/queue.c | 4 ++--
>  src/shared/queue.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Both patches in this set have been applied. Thanks.

Johan
