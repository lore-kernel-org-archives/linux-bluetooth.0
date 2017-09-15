Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] core: Fix segfault when detaching adapter
Message-ID: <d711261f-363f-ced3-ce6d-3624d8631f14@jp.fujitsu.com>
Date: Fri, 15 Sep 2017 17:46:10 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When set PairableTimeout to non-zero and run bluetoothd, and then
repeat attaching and detaching a bluetooth dongle, bluetoothd
frequently do segfault as below:

  ==6583== Process terminating with default action of signal 11 (SIGSEGV)
  ==6583==  Bad permissions for mapped region at address 0x4D3AC0
  ==6583==    at 0x4DBE27: mgmt_send (mgmt.c:592)
  ==6583==    by 0x48FFC2: set_mode (adapter.c:601)
  ==6583==    by 0x490471: pairable_timeout_handler (adapter.c:649)
  ==6583==    by 0x50CDAB2: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
  ==6583==    by 0x50CD049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
  ==6583==    by 0x50CD3EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
  ==6583==    by 0x50CD711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
  ==6583==    by 0x40CD28: main (main.c:781)

At another time, syslog and objdump of bluetoothd outputted below:

  Sep 14 13:43:46 fushimi bluetoothd[14192]: src/adapter.c:adapter_free() 0x2374350
  Sep 14 13:44:08 fushimi bluetoothd[14192]: src/adapter.c:set_mode() sending set mode command for index 32749
  Sep 14 13:44:09 fushimi bluetoothd[14192]: src/adapter.c:set_mode() sending set mode command for index 0
  Sep 14 13:44:09 fushimi kernel: [18030.384367] bluetoothd[14192]: segfault at c0 ip 00000000004dbe31 sp 00007fff19f2ca40 error 4 in bluetoothd[400000+147000]

          if (mgmt->next_request_id < 1)
    4dbe31:       8b 43 40                mov    0x40(%rbx),%eax
    4dbe34:       48 83 05 9c 75 2f 00    addq   $0x1,0x2f759c(%rip)        # 7d33d8 <__gcov0.mgmt_send+0x18>
---
 src/adapter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index a571b18..36562c0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -662,7 +662,8 @@ static void trigger_pairable_timeout(struct btd_adapter *adapter)
 		return;
 
 	if (adapter->pairable_timeout > 0)
-		g_timeout_add_seconds(adapter->pairable_timeout,
+		adapter->pairable_timeout_id =
+			g_timeout_add_seconds(adapter->pairable_timeout,
 					pairable_timeout_handler, adapter);
 }
 
@@ -4409,6 +4410,11 @@ static void adapter_free(gpointer user_data)
 
 	DBG("%p", adapter);
 
+	if (adapter->pairable_timeout_id > 0) {
+		g_source_remove(adapter->pairable_timeout_id);
+		adapter->pairable_timeout_id = 0;
+	}
+
 	if (adapter->load_ltks_timeout > 0)
 		g_source_remove(adapter->load_ltks_timeout);
 
-- 
2.7.4

