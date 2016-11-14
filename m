Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 14 Nov 2016 13:51:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core/adapter: Fix using wrong address type to
 listen ATT
Message-ID: <20161114115118.GA5921@x1c>
References: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479123009-7190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 14, 2016, Luiz Augusto von Dentz wrote:
> bdaddr_type shall only matter for controllers supporting LE otherwise
> it may cause BDADDR_BREDR to be used for things like LE ATT socket
> listen breaking reconnections.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
