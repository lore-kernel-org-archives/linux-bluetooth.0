Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Oct 2012 17:00:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Pass confirm name as bool value
Message-ID: <20121010150006.GA18304@x220.c.hospitality.swisscom.com>
References: <1349875198-28913-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349875198-28913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 10, 2012, Szymon Janc wrote:
> confirm_name is a boolean value and can be pass as such instead of
> uint8_t.
> 
> ---
>  src/adapter.c |    2 +-
>  src/adapter.h |    3 ++-
>  src/event.c   |    2 +-
>  src/event.h   |    2 +-
>  src/mgmt.c    |    2 +-
>  5 files changed, 6 insertions(+), 5 deletions(-)

Both patches have been applied. Thanks.

Johan
