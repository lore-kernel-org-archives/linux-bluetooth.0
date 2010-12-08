Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 17:15:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add support for stat files bigger than 2GB on
 32-bit systems
Message-ID: <20101208151558.GA31117@jh-x301>
References: <1291821222-18990-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291821222-18990-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 08, 2010, Luiz Augusto von Dentz wrote:
> From stat documentation:
> 
> "(stat())  path  refers to a file whose size cannot be represented in the
> type off_t.  This can occur when an application compiled on a 32-bit
> platform without -D_FILE_OFFSET_BITS=64 calls stat() on a file whose size
> exceeds (2<<31)-1 bits."
> 
> To fix this now size header is omitted when the file is over 32-bit, but
> it is able to transfer it by using 64-bit variables. In addition to that
> folder-listing now should report such big sizes properly.
> ---
>  acinclude.m4         |    2 +-
>  client/transfer.c    |    5 +++--
>  plugins/filesystem.c |    7 ++++---
>  src/obex-priv.h      |    6 +++---
>  src/obex.c           |    7 ++++---
>  5 files changed, 15 insertions(+), 12 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
