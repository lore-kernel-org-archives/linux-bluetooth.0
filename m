Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Aug 2012 14:34:56 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, jaganath.k@samsung.com
Subject: Re: [PATCH] Bluetooth: Use kref for l2cap channel reference counting
Message-ID: <20120821173456.GB17005@joana>
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-07-27 23:51:21 +0530]:

> This patch changes the struct l2cap_chan and associated code to use
> kref api for object refcounting and freeing.
> 
> Suggested-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +--
>  net/bluetooth/l2cap_core.c    |   15 ++++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Patch has been applied to linux-bluetooth. Thanks.

	Gustavo
