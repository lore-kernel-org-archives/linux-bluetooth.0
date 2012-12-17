Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Dec 2012 17:51:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] core: Fix set_pairable to not attempt to power
 on the adapter
Message-ID: <20121217155142.GA19325@x220.P-661HNU-F1>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 17, 2012, Luiz Augusto von Dentz wrote:
> Pairable flag is completely independent flag for the kernel so we can
> reflect this in the D-Bus API.
> ---
>  src/adapter.c | 20 --------------------
>  1 file changed, 20 deletions(-)

All five patches have been applied. Thanks.

Johan
