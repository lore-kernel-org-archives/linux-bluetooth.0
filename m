Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Aug 2014 10:58:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Revert "gdbus: Don't include just added interfaces
 in GetManagedObjects"
Message-ID: <20140812075859.GA16197@t440s.ger.corp.intel.com>
References: <1407769117-21353-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407769117-21353-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Aug 11, 2014, Luiz Augusto von Dentz wrote:
> This actually creates a problem since the code now does flush any pending
> message on the queue any signal will be send right away before the
> actual reply to GetManagedObjects which will not contain those interfaces.
> ---
>  gdbus/object.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied. Thanks.

Johan
