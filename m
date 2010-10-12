Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Oct 2010 10:39:05 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Fix dead statement
Message-ID: <20101012093905.GC23502@jh-x301>
References: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
 <1286870891-5862-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286870891-5862-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 12, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Cannot reach dead statement "(*os->driver->close)(object);"
> ---
>  src/obex.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)

This one is also upstream.

Johan
