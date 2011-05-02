Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 May 2011 10:24:04 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when calling finalize_setup_errno
Message-ID: <20110502172404.GA13914@jh-x301>
References: <1304074563-16865-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304074563-16865-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Apr 29, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> finalize_setup_errno last parameter must be NULL otherwise it may access
> invalid memory.
> ---
>  audio/a2dp.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)

Pushed upstream. Thanks.

Johan
