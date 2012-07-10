Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:28:09 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: Refactor PIN code rejection to use
 user_pairing_resp()
Message-ID: <20120710182809.GA13847@joana>
References: <1341830512-10865-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341830512-10865-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

* Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-07-09 16:11:51 +0530]:

> Reuse user_pairing_resp() to send PIN code negative reply
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/mgmt.c |   35 ++++++++++++-----------------------
>  1 files changed, 12 insertions(+), 23 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
