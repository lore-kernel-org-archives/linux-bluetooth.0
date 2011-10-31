Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:22:54 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, ulrik.lauren@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2] Bluetooth: Use miliseconds for L2CAP channel timeouts
Message-ID: <20111031192254.GC10164@joana>
References: <1319095026-12517-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319095026-12517-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2011-10-20 09:17:06 +0200]:

> Timers set by __set_chan_timer() should use miliseconds instead of
> jiffies. Commit 942ecc9c4643db5ce071562e0a23f99464d6b461 updated
> l2cap_set_timer() so it expects timeout to be specified in msecs
> instead of jiffies. This makes timeouts unreliable when CONFIG_HZ
> is not set to 1000.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  include/net/bluetooth/l2cap.h |    7 +++++--
>  net/bluetooth/l2cap_core.c    |   16 ++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
