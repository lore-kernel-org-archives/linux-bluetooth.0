Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 10:07:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Atul Rai <a.rai@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH v3] tools/sdptool: Fix NULL pointer dereference
Message-ID: <20150729070743.GA7699@t440s.lan>
References: <1438074761-28359-1-git-send-email-a.rai@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438074761-28359-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atul,

On Tue, Jul 28, 2015, Atul Rai wrote:
> This patch fixes NULL pointer dereferences in case malloc fails
> and returns NULL.
> ---
>  tools/sdptool.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
