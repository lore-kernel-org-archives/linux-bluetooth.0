Return-Path: <baolex.ni@intel.com>
From: Baole Ni <baolex.ni@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	jiangshanlai@gmail.com,
	m.chehab@samsung.com,
	gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com,
	kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	geliangtang@163.com,
	chuansheng.liu@intel.com,
	baolex.ni@intel.com,
	mhocko@suse.com,
	koct9i@gmail.com,
	aarcange@redhat.com,
	aryabinin@virtuozzo.com
Subject: [PATCH 1089/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:15:34 +0800
Message-Id: <20160802121534.22728-1-baolex.ni@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 net/bluetooth/rfcomm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7eb02f..4132114 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2240,16 +2240,16 @@ static void __exit rfcomm_exit(void)
 module_init(rfcomm_init);
 module_exit(rfcomm_exit);
 
-module_param(disable_cfc, bool, 0644);
+module_param(disable_cfc, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(disable_cfc, "Disable credit based flow control");
 
-module_param(channel_mtu, int, 0644);
+module_param(channel_mtu, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(channel_mtu, "Default MTU for the RFCOMM channel");
 
-module_param(l2cap_mtu, uint, 0644);
+module_param(l2cap_mtu, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(l2cap_mtu, "Default MTU for the L2CAP connection");
 
-module_param(l2cap_ertm, bool, 0644);
+module_param(l2cap_ertm, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(l2cap_ertm, "Use L2CAP ERTM mode for connection");
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-- 
2.9.2
