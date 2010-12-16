Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 11:30:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] remove error_common_reply()
Message-ID: <20101216093030.GE4322@jh-x301>
References: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
 <1292450823-17640-2-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292450823-17640-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Dec 15, 2010, Gustavo F. Padovan wrote:
> Remove old dbus error report function. This patch doesn't make things
> really really better, but is a start.
> ---
>  audio/gateway.c |   18 ++++++++++--------
>  audio/headset.c |   37 +++++++++++++++----------------------
>  audio/sink.c    |    7 ++++---
>  audio/source.c  |    7 ++++---
>  src/error.c     |   18 ------------------
>  src/error.h     |    3 ---
>  6 files changed, 33 insertions(+), 57 deletions(-)

Thanks. This patch has been pushed upstream. The other two will have to
wait since I can't apply them before the first one has been fixed.

Johan
