Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Apr 2012 00:26:56 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 5/8] Bluetooth: Move recently-added ERTM header unpacking
 functions
Message-ID: <20120427032656.GD16993@joana>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
 <1335396979-11692-6-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335396979-11692-6-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-25 16:36:16 -0700]:

> Moving these functions simplifies future patches by eliminating
> forward declarations, makes future patches easier to review, and
> better preserves 'git blame' information.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |  120 ++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 60 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
