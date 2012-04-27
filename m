Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 23:19:07 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 1/8] Bluetooth: Improve ERTM sequence number offset
 calculation
Message-ID: <20120427021907.GA16993@joana>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
 <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-25 16:36:12 -0700]:

> Instead of using modular division, the offset can be calculated using
> only addition and subtraction.  The previous calculation did not work
> as intended and was more difficult to understand, involving unsigned
> integer underflow and a check for a negative value where one was not
> possible.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Patch has been applied to bluetooth-next. thanks.

	Gustavo
