Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jul 2015 09:15:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] tools/rctest: Fixed memory leak
Message-ID: <20150730061529.GA23791@t440s.P-661HNU-F1>
References: <1438234207-7374-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438234207-7374-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Thu, Jul 30, 2015, Anchit Narang wrote:
> Removed dynamic allocation of filename and savefile by strdup.
> Instead filename and savefile are directly pointing to the argv element.
> Closed the file  before returning from do_send function.
> ---
>  tools/rctest.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I know I let it slip last time, but in principle independent fixes
should be in separate patches. So please split the fd leak to a separate
patch.

Johan
