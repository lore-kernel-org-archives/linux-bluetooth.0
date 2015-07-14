Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 11:13:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sy39.ju@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_check_conn_params() check proper range
Message-ID: <20150714081337.GA29399@t440s.lan>
References: <1436776093-12090-1-git-send-email-sy39.ju@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436776093-12090-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seungyoun Ju,

On Mon, Jul 13, 2015, sy39.ju@samsung.com wrote:
> Slave latency range has been changed in Core Spec. 4.2 by Erratum 5419
> of ESR08_V1.0.0. And it should be applied to Core Spec. 4.0 and 4.1.
> 
> Before:
>    connSlaveLatency <= ((connSupervisionTimeout / connIntervalMax) - 1)
> 
> After:
>    connSlaveLatency <= ((connSupervisionTimeout / (connIntervalMax*2)) - 1)
> 
> This patch makes hci_check_conn_params() check the allowable slave
> latency range using the changed way.
> 
> Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
