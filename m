Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 04:51:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix socket not getting freed if l2cap channel
 create fails
Message-ID: <20120725075148.GT20029@joana>
References: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

* Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-07-19 12:54:04 +0530]:

> If l2cap_chan_create() fails then it will return from l2cap_sock_kill
> since zapped flag of sk is reset.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
