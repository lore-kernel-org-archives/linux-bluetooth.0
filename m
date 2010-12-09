Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 16:01:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix compiler flags when CFLAGS is set in the
 environment
Message-ID: <20101209140144.GB27789@jh-x301>
References: <1291902098-20765-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291902098-20765-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 09, 2010, Luiz Augusto von Dentz wrote:
> D_FILE_OFFSET_BITS need to be set even if CFLAGS is not empty
> ---
>  Makefile.am  |    2 +-
>  acinclude.m4 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
