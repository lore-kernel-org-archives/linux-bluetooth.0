Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Mar 2014 18:30:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix adding BR/EDR devices to auto connect
 list
Message-ID: <20140313163037.GA15104@localhost.P-661HNU-F1>
References: <1394720262-460-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394720262-460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 13, 2014, Luiz Augusto von Dentz wrote:
> This can happen with devices that export ATT profiles as SDP records
> such BlackBerry phones causing drivers to get probed which then call
> btd_device_add_attio_callback to get notified once connected.
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
