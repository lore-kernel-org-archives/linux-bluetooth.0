Return-Path: <cyrus@holtmann.org>
Message-ID: <55E08B77.6000700@intel.com>
Date: Fri, 28 Aug 2015 18:25:27 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_intel: Introduce LPM support
References: <1440778843-29860-1-git-send-email-loic.poulain@intel.com> <1440778843-29860-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1440778843-29860-2-git-send-email-loic.poulain@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


> Enable controller Low-Power-Mode if we have a pdev to manage host
> wake-up. Once LPM is enabled, controller notifies its TX status via
> a vendor specific packet (tx_idle/tx_active).
> tx_active means that there is more data upcoming from controller.
> tx_idle means that controller can be put in suspended state.
>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>   drivers/bluetooth/hci_intel.c | 95 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 92 insertions(+), 3 deletions(-)

v2: coding style, spin_lock restructuring

-- 
Intel Open Source Technology Center
http://oss.intel.com/
