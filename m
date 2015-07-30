Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jul 2015 10:54:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] tools/rctest: Closed File to fix memory leak
Message-ID: <20150730075450.GA32115@t440s.P-661HNU-F1>
References: <1438239003-30647-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438239003-30647-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Thu, Jul 30, 2015, Anchit Narang wrote:
> Closed the file  before returning from do_send function.
> ---
>  tools/rctest.c |    1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
