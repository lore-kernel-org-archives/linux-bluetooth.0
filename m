Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 04:43:24 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, s.syam@samsung.com
Subject: Re: [PATCH v1 2/2] Bluetooth: Free the l2cap channel list only when
 refcount is zero
Message-ID: <20120725074324.GS20029@joana>
References: <1342183675-27612-1-git-send-email-jaganath.k@samsung.com>
 <1342183675-27612-2-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342183675-27612-2-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

* Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-07-13 18:17:55 +0530]:

> Move the l2cap channel list chan->global_l under the refcnt
> protection and free it based on the refcnt.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 -
>  net/bluetooth/a2mp.c          |    2 +-
>  net/bluetooth/l2cap_core.c    |    8 +++++---
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
