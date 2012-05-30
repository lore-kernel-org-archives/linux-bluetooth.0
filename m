Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:42:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ido Yariv <ido@wizery.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v3] gattrib: Fix a request/response command deadlock
Message-ID: <20120530074224.GD6539@x220>
References: <20120529024058.GA2382@echo>
 <1338280763-3050-1-git-send-email-ido@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338280763-3050-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ido,

On Tue, May 29, 2012, Ido Yariv wrote:
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
>  attrib/gattrib.c |  111 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 87 insertions(+), 24 deletions(-)

Applied. Thanks.

Johan
