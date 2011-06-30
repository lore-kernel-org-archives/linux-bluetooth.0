Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 18:42:02 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] Bluetooth: Remove L2CAP busy queue
Message-ID: <20110630214202.GJ25602@joana>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
 <1309383324-12002-7-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309383324-12002-7-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-29 14:35:24 -0700]:

> The ERTM receive buffer is now handled in a way that does not require
> the busy queue and the associated polling code.

This one is fine as a separate patch.

	Gustavo
