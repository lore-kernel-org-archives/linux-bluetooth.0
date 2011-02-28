Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Feb 2011 14:32:09 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Fix possible NULL pointer dereference in
 cmd_complete
Message-ID: <20110228173209.GD2165@joana>
References: <1298898590-9052-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298898590-9052-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-02-28 14:09:50 +0100]:

> It is now possible to create command complete event without specific
> reply data by passing NULL as reply with len 0. Check pointer before
> calling memcpy to avoid undefined behaviour.
> ---
>  net/bluetooth/mgmt.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Patch is now applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
