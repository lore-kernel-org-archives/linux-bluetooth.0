Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 3/7] monitor: Filter duplicated advertisements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170718164627.20114-3-luiz.dentz@gmail.com>
Date: Tue, 18 Jul 2017 21:04:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8FC80CB5-4A7C-4F53-BFF6-7B679F21F3C4@holtmann.org>
References: <20170718164627.20114-1-luiz.dentz@gmail.com>
 <20170718164627.20114-3-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This reduces the verbosity and give a precise picture of how unique
> each report is.
> ---
> monitor/intel.c  |  28 +++---
> monitor/packet.c | 277 ++++++++++++++++++++++++++++++++++++-------------------
> monitor/vendor.h |   2 +-
> 3 files changed, 198 insertions(+), 109 deletions(-)
> 
> diff --git a/monitor/intel.c b/monitor/intel.c
> index 1ca9a95..9da188a 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -499,11 +499,11 @@ const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf)
> 	return NULL;
> }
> 
> -static void startup_evt(const void *data, uint8_t size)
> +static void startup_evt(uint8_t index, const void *data, uint8_t size)
> {
> }

NAK. I avoid this and want to keep avoiding it. There are different ways to get the actual index number if you need it. And also FYI, the index is a uint16_t.

Regards

Marcel

