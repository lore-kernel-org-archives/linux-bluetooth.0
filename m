Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 21 Dec 2017 16:59:07 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] monitor: Fix out of the tree build
Message-ID: <20171221155907.GB417@x1c>
References: <20171221140506.21741-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221140506.21741-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 21, 2017, Luiz Augusto von Dentz wrote:
> When building outside the tree including uuid.h may not be found:
> 
> ../monitor/packet.c:52:18: fatal error: uuid.h: No such file or directory
> ---
>  monitor/packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
