Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 14:24:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Remove OOB data if device was discovered
 in band
Message-ID: <20121120122408.GB14255@x220.ger.corp.intel.com>
References: <1353407934-17831-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353407934-17831-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 20, 2012, Szymon Janc wrote:
> OOB authentication mechanism should be used only if pairing process
> has been activated by previous OOB information exchange (Core Spec
> 4.0 , vol. 1, Part A, 5.1.4.3). Stored OOB data for specific device
> should be removed if that device was discovered in band later on.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> V2:
> Move OOB data removal to hci_inquiry_cache_update to cover all inquiry
> events (ext/rssi) in one place.
> 
>  net/bluetooth/hci_core.c |    2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
