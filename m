Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 11:36:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	lucas.demarchi@profusion.mobi, david_stockwell@att.net
Subject: Re: [PATCH 1/5] Added more complete set of AVCTP/AVRCP defines
Message-ID: <20110812083634.GA26421@dell>
References: <201108110912.02268.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108110912.02268.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Aug 11, 2011, David Stockwell wrote:
> Added more complete set of AVCTP/AVRCP defines:
>   command type/response codes
>   passthrough key operation codes (CT->TG)
>   vendor-dependent message opcode (TG->CT)
>   AVRCP 1.3+ Protocol Definition Unit codes
>   AVRCP 1.3+ Event-IDs
>   Bluetooth SIG Company ID
>   1394 Trade Association AVC MTU for Control channel
> 
> Based on Release 4.96
> 
> ---
>  audio/control.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 115 insertions(+), 5 deletions(-)

Please rebase these patches against latest git (now that I applied the
patches from Lucas).

Johan
