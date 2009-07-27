Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jul 2009 13:10:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] remove the serial storage stuff
Message-ID: <20090727101040.GA10809@jh-x301>
References: <1248672690-13907-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248672690-13907-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Mon, Jul 27, 2009, Forrest Zhao wrote:
>  serial/Makefile.am |    2 +-
>  serial/proxy.c     |  100 ++-----------------------------------
>  serial/storage.c   |  138 ----------------------------------------------------
>  serial/storage.h   |   29 -----------
>  4 files changed, 7 insertions(+), 262 deletions(-)
>  delete mode 100644 serial/storage.c
>  delete mode 100644 serial/storage.h

The patch has been pushed upstream (with a slightly more informative
commit message). Thanks.

Johan
