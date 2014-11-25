Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Nov 2014 11:18:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5] ath3k: Add support of MCI 13d3:3408 bt device
Message-ID: <20141125091853.GA16451@t440s.ger.corp.intel.com>
References: <54744242.8050209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54744242.8050209@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

On Tue, Nov 25, 2014, Dmitry Tunin wrote:
> Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
> This bluetooth module requires loading patch and sysconfig by ath3k driver.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> 
> ---

Seems you've forgotten the /sys/kernel/debug/usb/devices output from the
commit message? (you had it earlier but then dropped it for some reason)

Johan
