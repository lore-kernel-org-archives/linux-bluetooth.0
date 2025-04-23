Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D82701D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400036; cv=none; b=KQn16B5JHui0zKtNjmUBzGwEwZq8G6QE8Z+ZiEja13s7LASiuShu5BiXKa6Sw7E7wMpS4jSxLAgvmsVTXDTLIRveNwNQvL9kcOD7yqgUZmHMuNCOVwIEHnKDC6JE7AwANIFcjTvPTMrYeHJyddwKbjLuDzj4eUtnrW5+P3TzVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400036; c=relaxed/simple;
	bh=A0WHHh0IJmdnq+AwTdvKB4ljSfc8o9DA1mLKUSLe8cQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cI8BuimDlsqkSYG4gaweE0vheU71j+YL7Du511MdUuU2bO42vu5IjCUAMlgvUekaCJDR4CWnxkhAwurw+/jxKY9g1b7Ye+iiGcUNRdQygm/3k7hhhOHib+kXSLMhNBldN8I32uqb2B4P5xMjP9y4RcBRRTAe956i+KTZQHTu3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J+q/1sud; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J+q/1sud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745400032;
	bh=A0WHHh0IJmdnq+AwTdvKB4ljSfc8o9DA1mLKUSLe8cQ=;
	h=From:To:Subject:Date:From;
	b=J+q/1sudyZ7SjAQBuESeOnvzNzfk2OyNMkNG1wCOWNDf62gtS7RgaqTVA8Zo78Gep
	 iA8RM8aM8NRm5/JHlg15BdrTEP+pqL01EdmtqcCX+cjLj1VJao9pRHgGEayoVJ5xgy
	 bqpWlajo4mXIh/E7fvsNbxYIFKmDpYjXOLb2tInTs65N/Xaj2VHrvnxJw+noX5Q7vZ
	 XWnumdGSl+P0aP5VZtREJwJQUNm5qAvNfZ2MMZDGALVKUX5dxFd+K+gjc1Qly1T3Vh
	 7m9A5sC/eBFehOdYw5NeUb45fef5pgc/9LJzSsnYarj8qw6x7c21chURV0enCUqbKZ
	 6MbkQv4FFhTcg==
Received: from fdanis-XPS-13-9370.. (2A02-8428-Af44-1001-407B-1669-Aa99-BCde.rev.sfr.net [IPv6:2a02:8428:af44:1001:407b:1669:aa99:bcde])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5FF9717E0649
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 11:20:32 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/source: Fix crash on authentication failure
Date: Wed, 23 Apr 2025 11:20:26 +0200
Message-ID: <20250423092027.230229-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The AVDTP reference count may decrease under 0 if authentication fails
and avdtp_unref() is called from source_unregister() then when changing
state from SOURCE_STATE_CONNECTING to SOURCE_STATE_DISCONNECTED:

src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:28:D3:0B:3B:7B
 connected eir_len 33
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0011
src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
 type 0 status 0x5
src/device.c:device_bonding_complete() bonding (nil) status 0x05
src/device.c:device_bonding_failed() status 5
src/adapter.c:resume_discovery()
src/profile.c:ext_connect() Hands-Free unit failed connect to
 EC:28:D3:0B:3B:7B: Permission denied (13)
src/service.c:change_state() 0x556200cee6d0: device EC:28:D3:0B:3B:7B
 profile Hands-Free unit state changed: connecting -> disconnected (-13)
src/device.c:device_profile_connected() Hands-Free unit Permission
 denied (13)
profiles/audio/a2dp.c:a2dp_source_connect() path
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=1
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=2
profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=1
profiles/audio/source.c:source_set_state() State changed
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_DISCONNECTED ->
 SOURCE_STATE_CONNECTING
profiles/audio/source.c:source_connect() stream creation in progress
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: disconnected -> connecting (0)
src/service.c:btd_service_unref() 0x556200cee6d0: ref=1
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
src/adapter.c:dev_disconnected() Device EC:28:D3:0B:3B:7B disconnected,
 reason 0
src/adapter.c:adapter_remove_connection()
src/device.c:device_remove_connection() connection removed while
 Connect() is waiting reply
plugins/policy.c:disconnect_cb() reason 0
src/adapter.c:bonding_attempt_complete() hci0 bdaddr EC:28:D3:0B:3B:7B
 type 0 status 0xe
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
src/device.c:device_bonding_failed() status 14
src/adapter.c:resume_discovery()
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: connecting -> disconnected (-103)
src/device.c:device_profile_connected() a2dp-source Software caused
 connection abort (103)
src/service.c:change_state() 0x556200d08470: device EC:28:D3:0B:3B:7B
 profile a2dp-source state changed: disconnected -> unavailable (0)
profiles/audio/source.c:source_unregister()
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=1
profiles/audio/a2dp.c:setup_ref() 0x556200cf3760: ref=2
profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=1
profiles/audio/a2dp.c:a2dp_cancel() aborting setup 0x556200cf3760
profiles/audio/a2dp.c:setup_unref() 0x556200cf3760: ref=0
profiles/audio/a2dp.c:setup_free() 0x556200cf3760
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=0
profiles/audio/avdtp.c:avdtp_ref() 0x556200d2fb80: ref=1
profiles/audio/avdtp.c:connection_lost() Disconnected from
 EC:28:D3:0B:3B:7B
profiles/audio/source.c:source_set_state() State changed
 /org/bluez/hci0/dev_EC_28_D3_0B_3B_7B: SOURCE_STATE_CONNECTING ->
 SOURCE_STATE_DISCONNECTED
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=0
profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80
profiles/audio/a2dp.c:channel_remove() chan 0x556200cf5400
profiles/audio/avdtp.c:avdtp_unref() 0x556200d2fb80: ref=-1
profiles/audio/avdtp.c:avdtp_free() 0x556200d2fb80

This has been tested with:
- BlueZ 5.77 + kernel 5.4
- BlueZ upstream + kernel 6.11
---
 profiles/audio/source.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 885e218bf..b549ed114 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -306,8 +306,10 @@ static void source_free(struct btd_service *service)
 		avdtp_stream_remove_cb(source->session, source->stream,
 					source->cb_id);
 
-	if (source->session)
+	if (source->session) {
 		avdtp_unref(source->session);
+		source->session = NULL;
+	}
 
 	if (source->connect_id > 0) {
 		btd_service_connecting_complete(source->service, -ECANCELED);
-- 
2.43.0

