Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Antoine Belvire <antoine.belvire@laposte.net>
Subject: [PATCH BlueZ] adapter: Don't refresh adv_manager for non-LE devices
To: linux-bluetooth@vger.kernel.org
Message-ID: <06461e3f-9f40-65ab-baa6-d5ae8e14beea@laposte.net>
Date: Mon, 26 Mar 2018 21:31:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_adv_manager_refresh is called upon MGMT_SETTING_DISCOVERABLE setting change
but as only LE adapters have an adv_manager, this leads to segmentation fault
for non-LE devices:

0  btd_adv_manager_refresh (manager=0x0) at src/advertising.c:1176
1  0x0000556fe45fcb02 in settings_changed (settings=<optimized out>,
     adapter=0x556fe53f7c70) at src/adapter.c:543
2  new_settings_callback (index=<optimized out>, length=<optimized out>,
     param=<optimized out>, user_data=0x556fe53f7c70) at src/adapter.c:573
3  0x0000556fe462c278 in request_complete (mgmt=mgmt@entry=0x556fe53f20c0,
     status=<optimized out>, opcode=opcode@entry=7, index=index@entry=0,
     length=length@entry=4, param=0x556fe53eb5f9) at src/shared/mgmt.c:261
4  0x0000556fe462cd9d in can_read_data (io=<optimized out>,
     user_data=0x556fe53f20c0) at src/shared/mgmt.c:353
5  0x0000556fe46396e3 in watch_callback (channel=<optimized out>,
     cond=<optimized out>, user_data=<optimized out>)
     at src/shared/io-glib.c:170
6  0x00007fe351c980e5 in g_main_context_dispatch ()
    from /usr/lib64/libglib-2.0.so.0
7  0x00007fe351c984b0 in ?? () from /usr/lib64/libglib-2.0.so.0
8  0x00007fe351c987c2 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
9  0x0000556fe45abc75 in main (argc=<optimized out>, argv=<optimized out>)
     at src/main.c:770

This commit prevents the call to btd_adv_manager_refresh for non-LE devices.
---
  src/adapter.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6d7d61504..e0f48cf9c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -540,7 +540,8 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
  		g_dbus_emit_property_changed(dbus_conn, adapter->path,
  					ADAPTER_INTERFACE, "Discoverable");
  		store_adapter_info(adapter);
-		btd_adv_manager_refresh(adapter->adv_manager);
+		if (adapter->supported_settings & MGMT_SETTING_LE)
+			btd_adv_manager_refresh(adapter->adv_manager);
  	}

  	if (changed_mask & MGMT_SETTING_BONDABLE) {
-- 
2.16.2
