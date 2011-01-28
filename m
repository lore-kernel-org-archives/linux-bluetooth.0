Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Jan 2011 15:29:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix using g_source_remove intead of
 g_dbus_remove_watch
Message-ID: <20110128132959.GA29696@jh-x301>
References: <1296220659-24165-1-git-send-email-luiz.dentz@gmail.com>
 <1296220659-24165-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296220659-24165-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jan 28, 2011, Luiz Augusto von Dentz wrote:
> Watches created with g_dbus_add_signal_watch cannot be removed with
> g_source_remove.
> ---
>  plugins/usb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
