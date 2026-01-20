Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B742B741
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926985; cv=none; b=AtX56jQLfMqQPxsT22dP/ivXRFj7/L5QubUSx9N+C3ehd1/KRBYIBdyzDmuBhQBX+hVaUXLHf9eFqzDmMUlyJdekvvXpFR6y2eB4bcT+AypuFzJyyOu9m3sPDRVBu9UFDWbV0IuiFTi2w4VLIYyRvLxiDcHvrb6WJ41oyRFDHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926985; c=relaxed/simple;
	bh=Z0jmm2x3BSu/Qk8BFaKENkLsJvcC/1T3PUcKESzpzBA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ridhtvWkGExrOKsPGW30IKS70Jbhutu7Ll/F4FHFVfln+gAG6ApvWqgBy+GncA4M+2aa1BnEQdVQvZFZRt0lPKsyvZVNWeER/zER3OiDeDCd3RitiyINPfcYWRmSwLrHF7bFX17tM3t+kkDtdYfikbS8VEu/aMzlVibnEvNd28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XKtv1mLq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XKtv1mLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768926979;
	bh=Z0jmm2x3BSu/Qk8BFaKENkLsJvcC/1T3PUcKESzpzBA=;
	h=From:To:Subject:Date:From;
	b=XKtv1mLqwLP2FoBYzLn6P3j+lcUuxWyka9Pm6UOhP1+GYPKhUO9vtiwVb3Fpcn8lO
	 /F2b2h91bvxSEXUJCLd5KSZNGwtb9SEUQViPqos405vxdUTa+TmIehPcELH/IanDbQ
	 qUBZkxtQ55SAmQ3Ov4xQokBrqRUSd/aXe8RIZmiNcLDTu/c7P2/lOTJlvD/d/t2QJe
	 zA/qJ5o9VkjgU11frBjHwH0NBK1ioRfG68J5gL+GfomY9tBE7Qg48/IVYKAOM6jGNF
	 1fv5m/fsqDFc7lP5UUj2aG6qGSwgcAzsPX/JzAJdmIl65zy5fUMuB/BI41h58HhgJB
	 bW8D05OrSxnLA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-3b6a-bdBA-3D1e-236E.rev.sfr.net [IPv6:2a02:8428:af44:1001:3b6a:bdba:3d1e:236e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F45117E1355
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:36:19 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix bt_uuid_hash() crash
Date: Tue, 20 Jan 2026 17:36:14 +0100
Message-ID: <20260120163614.261494-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is reproducible on Ubuntu 24.04, which enables libasan, by
calling org.bluez.AdminPolicySet1.SetServiceAllowList() method with
an array of UUIDs like ['110c','110e']:

bluetoothd[9975]: [:1.1435:method_call] > org.bluez.AdminPolicySet1.SetServiceAllowList [#468]
bluetoothd[9975]: plugins/admin.c:set_service_allowlist() sender :1.1435
=================================================================
==9975==ERROR: AddressSanitizer: unknown-crash on address 0x763aef383ee4 at pc 0x648113f85064 bp 0x7fffe4db4970 sp 0x7fffe4db4960
WRITE of size 16 at 0x763aef383ee4 thread T0
    #0 0x648113f85063 in bt_uuid16_to_uuid128 lib/bluetooth/uuid.c:35
    #1 0x648113f85063 in bt_uuid_to_uuid128 lib/bluetooth/uuid.c:73
    #2 0x648113e90459 in bt_uuid_hash src/adapter.c:3891
    #3 0x763af2700a5b in g_hash_table_add (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x49a5b) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #4 0x648113fa7232 in queue_foreach src/shared/queue.c:207
    #5 0x648113eb69df in btd_adapter_set_allowed_uuids src/adapter.c:3924
    #6 0x648113cd6f11 in service_allowlist_set plugins/admin.c:165
    #7 0x648113cd8162 in set_service_allowlist plugins/admin.c:382
    #8 0x648113f97564 in process_message gdbus/object.c:293
    #9 0x763af2f6f553 in dbus_connection_dispatch (/lib/x86_64-linux-gnu/libdbus-1.so.3+0x18553) (BuildId: 47829078e4267099473c6cf5f5742f16ccb2644d)
    #10 0x648113f86d47 in message_dispatch gdbus/mainloop.c:59
    #11 0x763af271440d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d40d) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #12 0x763af2773766  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc766) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #13 0x763af2714ef6 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5def6) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #14 0x6481140bf9d8 in mainloop_run src/shared/mainloop-glib.c:65
    #15 0x6481140c0306 in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #16 0x648113c93d58 in main src/main.c:1550
    #17 0x763af1a2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #18 0x763af1a2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #19 0x648113c96854 in _start (/home/fdanis/src/bluez/src/bluetoothd+0x65d854) (BuildId: 4e2b98c227059c308efb311ffe5b023d60e142ac)

Address 0x763aef383ee4 is located in stack of thread T0 at offset 36 in frame
    #0 0x648113e903df in bt_uuid_hash src/adapter.c:3884

  This frame has 1 object(s):
    [32, 48) 'uuid_128' (line 3886) <== Memory access at offset 36 partially overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: unknown-crash lib/bluetooth/uuid.c:35 in bt_uuid16_to_uuid128
Shadow bytes around the buggy address:
  0x763aef383c00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383c80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383d00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383d80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383e00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
=>0x763aef383e80: f5 f5 f5 f5 f5 f5 f5 f5 f1 f1 f1 f1[00]00 f3 f3
  0x763aef383f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef383f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
---
 src/adapter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a5de7cee1..b319594ae 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3879,14 +3879,15 @@ static void add_uuid_to_uuid_set(void *data, void *user_data)
 static guint bt_uuid_hash(gconstpointer key)
 {
 	const bt_uuid_t *uuid = key;
-	uint64_t uuid_128[2];
+	bt_uuid_t my_uuid;
 
 	if (!uuid)
 		return 0;
 
-	bt_uuid_to_uuid128(uuid, (bt_uuid_t *)uuid_128);
+	bt_uuid_to_uuid128(uuid, &my_uuid);
 
-	return g_int64_hash(uuid_128) ^ g_int64_hash(uuid_128+1);
+	return g_int64_hash(&my_uuid.value.u128.data[0]) ^
+		g_int64_hash(&my_uuid.value.u128.data[8]);
 }
 
 static gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
-- 
2.43.0

