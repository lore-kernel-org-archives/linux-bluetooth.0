Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Sep 2012 14:53:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: mgmt: Fix enabling SSP while powered
 off
Message-ID: <20120903115336.GB29589@x220>
References: <1346227329-1686-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346227329-1686-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Aug 29, 2012, Andrzej Kaczmarek wrote:
> When new BT USB adapter is plugged in it's configured while still being powered
> off (HCI_AUTO_OFF flag is set), thus Set SSP will only set dev_flags but won't
> write changes to controller. As a result remote devices won't use Secure Simple
> Pairing with our device due to SSP Host Support flag disabled in extended
> features and may also reject SSP attempt from our side (with possible fallback
> to legacy pairing).
> 
> This patch ensures HCI Write Simple Pairing Mode is sent when Set Powered is
> called to power on controller and clear HCI_AUTO_OFF flag.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/mgmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
