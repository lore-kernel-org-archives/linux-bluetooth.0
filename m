Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 17:50:38 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Subject: Re: [RFC 3/6] Bluetooth: Factor out common L2CAP connection code
Message-ID: <20121012095038.GB10739@joana>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349966905-32336-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349966905-32336-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-11 17:48:22 +0300]:

> From: Mat Martineau <mathewm@codeaurora.org>
> 
> L2CAP connect requests and create channel requests share a significant
> amount of code.  This change moves common code to a new function.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
