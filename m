Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 11:50:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/bluemoon: Remove dead code
Message-ID: <20150108095013.GA10780@t440s.lan>
References: <1419920868-4637-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419920868-4637-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Tue, Dec 30, 2014, Syam Sidhardhan wrote:
> return statement never get executed after goto.
> ---
>  tools/bluemoon.c |    1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

Johan
