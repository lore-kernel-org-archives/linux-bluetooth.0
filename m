Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 18:27:13 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] Bluetooth: ERTM timeouts need to be converted to
 jiffies
Message-ID: <20110630212713.GG25602@joana>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
 <1309383324-12002-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309383324-12002-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-29 14:35:21 -0700]:

> ERTM timeouts are defined in milliseconds, but need to be converted
> to jiffies when passed to mod_timer().
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>

Good catch. I lacked some test on this I guess. Applied, thanks.

	Gustavo
