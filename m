Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 19:53:51 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix handling of suspend response
Message-ID: <20110405025351.GC29805@jh-x301>
References: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301907619-6684-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Apr 04, 2011, Luiz Augusto von Dentz wrote:
> finalize_suspend is being called twice when a resume request is queue
> after it or if start fails.
> ---
>  audio/a2dp.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
