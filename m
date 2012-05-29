Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 10:59:53 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] gattrib: Fix a request/response command deadlock
Message-ID: <20120529135952.GA13737@samus>
References: <20120529024058.GA2382@echo>
 <1338280763-3050-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338280763-3050-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On 11:39 Tue 29 May, Ido Yariv wrote:
> New requests and responses are never sent if a request was sent and the
> response for it hasn't been received yet. As a result, if both end
> points send requests at the same time, a deadlock could occur. This
> could happen, for instance, if the client sends a read request and the
> server sends an indication before responding to the read request.
> 
> Fix this by introducing an additional queue for responses. Responses may
> be sent while there's still a pending request/indication.
> ---
> Changes from v2:
> - Cancel responses in g_attrib_cancel_all even if the requests queue is NULL
> 

[snip]

Thanks. Ack.


Cheers,
-- 
Vinicius
