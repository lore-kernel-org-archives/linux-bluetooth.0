Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Dec 2014 14:31:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH] monitor/l2cap: Fix buffer overflow issue
Message-ID: <20141216123133.GA9035@t440s.lan>
References: <1418651954-15378-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418651954-15378-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Dec 15, 2014, Gowtham Anandha Babu wrote:
> String copy function overflows destination buffer.
> 	strcat(str, "LinkKey ");
> 	^~~~~~~~~~~~~~~~~~~~~~~
> ---
>  monitor/l2cap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
