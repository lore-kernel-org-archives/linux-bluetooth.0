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
	chuansheng.liu@intel.com,
	baolex.ni@intel.com,
	mhocko@suse.com,
	koct9i@gmail.com,
	aarcange@redhat.com,
	aryabinin@virtuozzo.com
Subject: [PATCH 1090/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:15:39 +0800
Message-Id: <20160802121539.22794-1-baolex.ni@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f52bcbf..a39a55d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1267,5 +1267,5 @@ void sco_exit(void)
 	proto_unregister(&sco_proto);
 }
 
-module_param(disable_esco, bool, 0644);
+module_param(disable_esco, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(disable_esco, "Disable eSCO connection creation");
-- 
2.9.2
