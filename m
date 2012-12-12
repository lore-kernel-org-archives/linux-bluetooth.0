Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 14:20:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] obex-client: Remove calls to org.bluez.Manager and
 org.bluez.Adapter
Message-ID: <20121212122043.GA20483@x220.ger.corp.intel.com>
References: <1355314591-8773-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355314591-8773-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 12, 2012, Luiz Augusto von Dentz wrote:
> With BlueZ 5 this API no longer exist or have changed.
> ---
>  obexd/client/bluetooth.c | 199 +----------------------------------------------
>  1 file changed, 2 insertions(+), 197 deletions(-)

Applied. Thanks.

Johan
