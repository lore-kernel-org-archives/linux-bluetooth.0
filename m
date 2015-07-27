Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jul 2015 10:21:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com,
	anupam.r@smsung.com
Subject: Re: [PATCH] android/tester-main.c:Fixed Memory leak
Message-ID: <20150727072147.GA29130@t440s>
References: <1437539243-20709-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437539243-20709-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Wed, Jul 22, 2015, Anchit Narang wrote:
> This patch fixes memory leak issues in various functions
> by allocating memory to  structure step only after intial
> checks are performed as control was returning from these
> checks without freeing memory allocated to it.
> ---
>  android/tester-main.c |   36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
