Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Anchit Narang <anchit.n@samsung.com>,
	linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@smsung.com
Subject: Re: [PATCH] android/tester-main.c:Fixed Memory leak
In-Reply-To: <1437539243-20709-1-git-send-email-anchit.n@samsung.com>
References: <1437539243-20709-1-git-send-email-anchit.n@samsung.com>
Date: Fri, 24 Jul 2015 13:46:06 -0300
Message-ID: <87y4i54i7l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Anchit Narang <anchit.n@samsung.com> writes:

> This patch fixes memory leak issues in various functions
> by allocating memory to  structure step only after intial
> checks are performed as control was returning from these
> checks without freeing memory allocated to it.
> ---
>  android/tester-main.c |   36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>

Patch looks good.


Cheers,
--
Vinicius
