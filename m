Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 Dec 2011 21:33:18 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	ulrik.lauren@stericsson.com, henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Fix race condition between RFCOMM and L2CAP
Message-ID: <20111218233318.GF2621@joana>
References: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1320844340-1966-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320844340-1966-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2011-11-09 14:12:20 +0100]:

> Sometimes when RFCOMM creates underlying L2CAP socket it happens that
> rfcomm_security_cfm is called before DLC is linked to session thus
> reference count for session struct is 0. As a result rfcomm_session_put
> will close session and connection will not be completed.
> 
> __rfcomm_dlc_open will now hold reference to rfcomm_session until DLC
> is linked to session to prevent the above from happening.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/rfcomm/core.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Can you check if this issue still happens after the workqueue patches. Those
kinds of issue in RFCOMM should be fixed by now.

	Gustavo
