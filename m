Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 18:47:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mgmtops: Add missing compatibility header include
Message-ID: <20120224164702.GA14214@x220.P-661HNU-F1>
References: <1330094551-28244-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1330094551-28244-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Feb 24, 2012, Anderson Lizardo wrote:
> glib-compat.h needs to be included when either g_slist_free_full() or
> g_list_free_full() is used on a C file. Otherwise, it will fail to build
> on older (supported) Glib versions that lack these functions.
> 
> Fixes this build error on GLib 2.24.1:
> 
> plugins/mgmtops.c: In function ‘remove_controller’:
> plugins/mgmtops.c:180: error: implicit declaration of function
> ‘g_slist_free_full’
> ---
>  plugins/mgmtops.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
