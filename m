Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 07:05:35 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check capabilities in BR/EDR and LE-Only
 discovery
Message-ID: <20120301150535.GA19616@x220>
References: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Feb 23, 2012, Andre Guedes wrote:
> This patch add an extra check for BR/EDR and LE-Only discovery.
> This way, we are able to return error immediately if the discovery
> type requested is not supported by the device.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
