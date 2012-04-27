Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Apr 2012 00:22:16 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 3/8] Bluetooth: Remove duplicate structure members from
 bt_skb_cb
Message-ID: <20120427021952.GB16993@joana>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
 <1335396979-11692-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335396979-11692-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-25 16:36:14 -0700]:

> These values are now in the nested l2cap_ctrl struct.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |    3 ---
>  net/bluetooth/l2cap_core.c        |   34 +++++++++++++++++-----------------
>  2 files changed, 17 insertions(+), 20 deletions(-)

Patch has been applied to bluetooth-next. thanks.

	Gustavo
