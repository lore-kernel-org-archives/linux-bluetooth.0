Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 16:52:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] core: Do not attempt to connect if adapter is
 not powered
Message-ID: <20131112145223.GA32476@x220.p-661hnu-f1>
References: <1384266749-309-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384266749-309-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 12, 2013, Luiz Augusto von Dentz wrote:
> If the adapter is not yet powered do not attempt to connect, also
> abort any connection attempt in case of error -EHOSTUNREACH is returned
> by the kernel which also means the adapter is not up or in case of
> -ECONNABORTED which means the adapter was powered down during the
> connection attempt.
> ---
> v2: Add better description, add comments what each error code means and
> treat -ECONNABORTED.
> 
>  src/device.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
