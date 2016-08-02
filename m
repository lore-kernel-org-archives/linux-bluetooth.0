Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1088/1285] Replace numeric parameter like 0444 with macro
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160802121527.22660-1-baolex.ni@intel.com>
Date: Tue, 2 Aug 2016 15:56:28 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, jiangshanlai@gmail.com,
	m.chehab@samsung.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	chuansheng.liu@intel.com, mhocko@suse.com, koct9i@gmail.com,
	Andrea Arcangeli <aarcange@redhat.com>, aryabinin@virtuozzo.com
Message-Id: <9FB95BB0-0382-41AF-9B1E-5D17D1523F3B@holtmann.org>
References: <20160802121527.22660-1-baolex.ni@intel.com>
To: Baole Ni <baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Baole,

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index eb4f5f2..1dfb4bc 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7636,5 +7636,5 @@ void l2cap_exit(void)
> 	l2cap_cleanup_sockets();
> }
> 
> -module_param(disable_ertm, bool, 0644);
> +module_param(disable_ertm, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");

I am not taking any of these patches for the Bluetooth subsystem or its drivers. They are pretty much pointless to me and do not improve readability. I think they actually decrease readability. Every Unix/Linux developers knowns what 0644 (and all its magic cousins) mean.

The only way I would accept any patches to change this is if they would introduce module_param_rw / module_param_ro or something alike. Since I am pretty sure the majority is 644 and 444 here anyway.

Regards

Marcel
