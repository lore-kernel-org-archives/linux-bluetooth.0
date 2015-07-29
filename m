Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 20:47:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH v2] tools/l2test:Fixed memory leak
Message-ID: <20150729174722.GA3234@t440s.P-661HNU-F1>
References: <1438159015-12311-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438159015-12311-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Wed, Jul 29, 2015, Anchit Narang wrote:
> Removed dynamic allocation of filename by strdup.
> Instead filename is directly pointing to the argv element.
> Closed the file  before returning from do_send function.
> ---
>  tools/l2test.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
