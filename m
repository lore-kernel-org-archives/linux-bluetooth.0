Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 11:51:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH] tools/bccmd: Remove dead code
Message-ID: <20150108095106.GB10780@t440s.lan>
References: <1418995940-16166-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418995940-16166-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Dec 19, 2014, Gowtham Anandha Babu wrote:
> warning: Value stored to 'handle' is never read
>         handle = array[0] | (array[1] << 8);
>         ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~
> ---
>  tools/bccmd.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

Johan
