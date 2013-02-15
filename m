Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 12:53:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix calling profile .connect multiple times
Message-ID: <20130215105338.GD15390@x220>
References: <1360317088-18852-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360317088-18852-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 08, 2013, Luiz Augusto von Dentz wrote:
> Sometimes profiles may complete the connection in different order
> than expected so the code has to check if it was actually the
> current pending profile to proceed to the next.
> ---
>  src/device.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied. Thanks.

Johan
