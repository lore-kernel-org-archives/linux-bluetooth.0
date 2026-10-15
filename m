Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACF4A0EFE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055305; cv=none; b=pCxvKZwdSRo35egq0IQ2BIIpb3e28LPA3HyUwkFrKatWP5BKWQsGdDCKZyLLxDauhvJl87APQqw5KXMI41aaCp5IBGT6qdSdowO6yi49i+svfJSNjFqmlQ/z0L061ppWwEmxuPxS0RL+bUvx1GnaVYFVu/xYtpfbfhxcgvPFM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055305; c=relaxed/simple;
	bh=zgbHaYqqwL1oJQI9q3kDO0rZLapnFkK1ldJxSMGFAg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i/dhWEwUSmdsjvk473duWTZbvbtqxEZYH2TWrVI9thPM4fCsnPDUYj73lO6mL7g3b6ywuaVljZA9nS0jZQFTTBxNTHIxdu6t/drzrNG6ukE3OSTmd9M6Et5SF/jy/WrDHLO5XdZIsiJr0krua4PpJ+bhtnuYjROmbnKYoohmFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+DilXh7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+DilXh7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9729C2BCC7;
	Thu, 15 Oct 2026 09:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792055304;
	bh=zgbHaYqqwL1oJQI9q3kDO0rZLapnFkK1ldJxSMGFAg0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=k+DilXh7J5PH3ZixUpoVMbQiRRbgPdiBLEypr/rYJPepdLymx8zG5qfhDa+S9VGEd
	 r8bDLz6J4ICVuJOULL7vL1wo3r83V6M140bmxlt31FoupeFM8G0fQq5EuMJ0kWncB/
	 o3UXdaa9Otnzh861KyLtfHWulBcVZslC3dTzvGvjFeBFOdBm8PWPA45rpdRwxc3geS
	 0fpkcdwp6tPE6l7NzW6qkgxagZpLlpEAOLVdVwvWu80lsSaO9Srlhu9FNfZi2J3fJr
	 9AaJy9PsFz3jEwE3EgVHJ7M+DhRuF2oCik8DJLdjcp7pHwdk3V0V3pld7UtcaeeuJz
	 PldecmhFACbWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0CCC6B38;
	Thu, 15 Oct 2026 09:08:24 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 15 Oct 2026 17:08:21 +0800
Subject: [PATCH BlueZ bluez v2] hci: add ext adv interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-extend_adv_api-v2-1-8b76d8a1c0ef@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAAWY0GoC/3WNyw6CMBREf4XctTVtVWxc+R+GkD5u4SZASYsNS
 vh3G/Yuz0zmzAYJI2GCR7VBxEyJwlRAniqwvZ46ZOQKg+SyFlxcGa4LTq7VLrd6JlYLY5S6aKv
 UDcpojuhpPYQvMMMbv9CUuKe0hPg5brI4yn/GLJhgtXb87r1U3MunHofQkT3bMEKz7/sPBmYTF
 rUAAAA=
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792055302; l=9022;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=CFVcfoepW0WE78+88YnEyXs9ltTQS4fleF18kRL6/CI=;
 b=d3UimNl8kHcTA8PTg4Znp8HGeHVNCwvUuMmk7nB517yopghqJapwixDuW/YOGK5j7wmXfsZvg
 vUk3GLUpyKAB8gdooKzKaB24rZaNE6Y59xVN28j0xDuioY31kYUlFbT
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Wrap extended advertising HCI command interfaces.

---
Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Fixed coding style.
- Link to v1: https://patch.msgid.link/20261014-extend_adv_api-v1-1-6ad07ff280f2@amlogic.com
---
 lib/bluetooth/hci.c     | 194 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bluetooth/hci.h     |  55 ++++++++++++++
 lib/bluetooth/hci_lib.h |  16 ++++
 3 files changed, 265 insertions(+)

diff --git a/lib/bluetooth/hci.c b/lib/bluetooth/hci.c
index f50a30c61..fe74ba2a5 100644
--- a/lib/bluetooth/hci.c
+++ b/lib/bluetooth/hci.c
@@ -3017,6 +3017,200 @@ int hci_le_set_advertise_enable(int dd, uint8_t enable, int to)
 	return 0;
 }
 
+int hci_le_set_ext_adv_params(int dd, uint8_t handle, uint16_t evt_properties,
+			uint32_t min_interval, uint32_t max_interval,
+			uint8_t channel_map, uint8_t own_addr_type,
+			uint8_t peer_addr_type, const bdaddr_t *peer_addr,
+			uint8_t filter_policy, int8_t tx_power,
+			uint8_t primary_phy, uint8_t secondary_max_skip,
+			uint8_t secondary_phy, uint8_t sid,
+			uint8_t notif_enable, int to)
+{
+	struct hci_request rq;
+	le_set_ext_adv_params_cp cp;
+	struct {
+		uint8_t status;
+		int8_t  tx_power;
+	} rsp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = handle;
+	cp.evt_properties = evt_properties;
+	cp.min_interval[0] = min_interval & 0xff;
+	cp.min_interval[1] = (min_interval >> 8) & 0xff;
+	cp.min_interval[2] = (min_interval >> 16) & 0xff;
+	cp.max_interval[0] = max_interval & 0xff;
+	cp.max_interval[1] = (max_interval >> 8) & 0xff;
+	cp.max_interval[2] = (max_interval >> 16) & 0xff;
+	cp.channel_map = channel_map;
+	cp.own_addr_type = own_addr_type;
+	cp.peer_addr_type = peer_addr_type;
+	if (peer_addr)
+		memcpy(&cp.peer_addr, peer_addr, sizeof(cp.peer_addr));
+	cp.filter_policy = filter_policy;
+	cp.tx_power = tx_power;
+	cp.primary_phy = primary_phy;
+	cp.secondary_max_skip = secondary_max_skip;
+	cp.secondary_phy = secondary_phy;
+	cp.sid = sid;
+	cp.notif_enable = notif_enable;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_EXT_ADV_PARAMS;
+	rq.cparam = &cp;
+	rq.clen = sizeof(cp);
+	rq.rparam = &rsp;
+	rq.rlen = sizeof(rsp);
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rsp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+int hci_le_set_ext_adv_data(int dd, uint8_t handle, uint8_t operation,
+				uint8_t fragment_pref, const uint8_t *data,
+				uint8_t data_len, int to)
+{
+	struct hci_request rq;
+	le_set_ext_adv_data_cp *cp;
+	uint8_t status;
+	size_t plen = sizeof(*cp) + data_len;
+
+	cp = malloc(plen);
+	if (!cp) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	memset(cp, 0, plen);
+	cp->handle = handle;
+	cp->operation = operation;
+	cp->fragment_preference = fragment_pref;
+	cp->data_len = data_len;
+	if (data && data_len)
+		memcpy(cp->data, data, data_len);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_EXT_ADV_DATA;
+	rq.cparam = cp;
+	rq.clen = plen;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	if (hci_send_req(dd, &rq, to) < 0) {
+		free(cp);
+		return -1;
+	}
+
+	free(cp);
+
+	if (status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+int hci_le_set_ext_scan_rsp_data(int dd, uint8_t handle, uint8_t operation,
+				uint8_t fragment_pref, const uint8_t *data,
+				uint8_t data_len, int to)
+{
+	struct hci_request rq;
+	le_set_ext_adv_data_cp *cp;
+	uint8_t status;
+	size_t plen = sizeof(*cp) + data_len;
+
+	cp = malloc(plen);
+	if (!cp) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	memset(cp, 0, plen);
+	cp->handle = handle;
+	cp->operation = operation;
+	cp->fragment_preference = fragment_pref;
+	cp->data_len = data_len;
+	if (data && data_len)
+		memcpy(cp->data, data, data_len);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_EXT_SCAN_RSP_DATA;
+	rq.cparam = cp;
+	rq.clen = plen;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	if (hci_send_req(dd, &rq, to) < 0) {
+		free(cp);
+		return -1;
+	}
+
+	free(cp);
+
+	if (status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+int hci_le_set_ext_adv_enable(int dd, uint8_t enable, uint8_t num_of_sets,
+				const void *sets, int to)
+{
+	struct hci_request rq;
+	le_set_ext_adv_enable_cp *cp;
+	uint8_t status;
+	size_t set_entry_len = 4; /* handle(1) + duration(2) + max_events(1) */
+	size_t plen =
+		sizeof(le_set_ext_adv_enable_cp) + (num_of_sets * set_entry_len);
+
+	cp = malloc(plen);
+	if (!cp) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	memset(cp, 0, plen);
+	cp->enable = enable;
+	cp->num_of_sets = num_of_sets;
+	if (sets && num_of_sets)
+		memcpy(cp->sets, sets, num_of_sets * set_entry_len);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_EXT_ADV_ENABLE;
+	rq.cparam = cp;
+	rq.clen = plen;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	if (hci_send_req(dd, &rq, to) < 0) {
+		free(cp);
+		return -1;
+	}
+
+	free(cp);
+
+	if (status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,
 		bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
diff --git a/lib/bluetooth/hci.h b/lib/bluetooth/hci.h
index 2e4aa394e..7d8b81f2d 100644
--- a/lib/bluetooth/hci.h
+++ b/lib/bluetooth/hci.h
@@ -1735,6 +1735,61 @@ typedef struct {
 } __attribute__ ((packed)) le_set_address_resolution_enable_cp;
 #define LE_SET_ADDRESS_RESOLUTION_ENABLE_CP_SIZE 1
 
+#define OCF_LE_SET_EXT_ADV_PARAMS		0x0036
+typedef struct {
+	uint8_t  handle;
+	uint16_t evt_properties;
+	uint8_t  min_interval[3];
+	uint8_t  max_interval[3];
+	uint8_t  channel_map;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	bdaddr_t peer_addr;
+	uint8_t  filter_policy;
+	int8_t   tx_power;
+	uint8_t  primary_phy;
+	uint8_t  secondary_max_skip;
+	uint8_t  secondary_phy;
+	uint8_t  sid;
+	uint8_t  notif_enable;
+} __attribute__ ((packed)) le_set_ext_adv_params_cp;
+#define LE_SET_EXT_ADV_PARAMS_CP_SIZE 25
+
+typedef struct {
+	uint8_t status;
+	int8_t  selected_tx_power;
+} __attribute__ ((packed)) le_set_ext_adv_params_rp;
+#define LE_SET_EXT_ADV_PARAMS_RP_SIZE 9
+
+#define OCF_LE_SET_EXT_ADV_DATA			0x0037
+typedef struct {
+	uint8_t handle;
+	uint8_t operation;
+	uint8_t fragment_preference;
+	uint8_t data_len;
+	uint8_t data[0];
+} __attribute__ ((packed)) le_set_ext_adv_data_cp;
+#define LE_SET_EXT_ADV_DATA_CP_MAX_SIZE  (4 + 251)
+
+#define OCF_LE_SET_EXT_SCAN_RSP_DATA		0x0038
+typedef struct {
+	uint8_t advertising_handle;
+	uint8_t operation;
+	uint8_t fragment_preference;
+	uint8_t scan_response_data_length;
+	uint8_t scan_response_data[31];
+} __attribute__((packed)) le_set_ext_scan_rsp_data_cp;
+#define LE_SET_EXT_SCAN_RSP_DATA_CP_SIZE (4 + 31)
+
+#define OCF_LE_SET_EXT_ADV_ENABLE		0x0039
+typedef struct {
+	uint8_t enable;
+	uint8_t num_of_sets;
+	/* followed by ext adv set entries: handle(1), duration(2), max_events(1) */
+	uint8_t sets[0];
+} __attribute__ ((packed)) le_set_ext_adv_enable_cp;
+#define LE_SET_EXT_ADV_ENABLE_CP_SIZE (2 + 4)
+
 /* Vendor specific commands */
 #define OGF_VENDOR_CMD		0x3f
 
diff --git a/lib/bluetooth/hci_lib.h b/lib/bluetooth/hci_lib.h
index eeb51411a..4a06a9383 100644
--- a/lib/bluetooth/hci_lib.h
+++ b/lib/bluetooth/hci_lib.h
@@ -112,6 +112,22 @@ int hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup, int t
 int hci_le_set_scan_parameters(int dev_id, uint8_t type, uint16_t interval,
 					uint16_t window, uint8_t own_type,
 					uint8_t filter, int to);
+int hci_le_set_ext_adv_params(int dev_id, uint8_t handle, uint16_t evt_properties,
+				uint32_t min_interval, uint32_t max_interval,
+				uint8_t channel_map, uint8_t own_addr_type,
+				uint8_t peer_addr_type, const bdaddr_t *peer_addr,
+				uint8_t filter_policy, int8_t tx_power,
+				uint8_t primary_phy, uint8_t secondary_max_skip,
+				uint8_t secondary_phy, uint8_t sid,
+				uint8_t notif_enable, int to);
+int hci_le_set_ext_adv_data(int dev_id, uint8_t handle, uint8_t operation,
+				uint8_t fragment_pref, const uint8_t *data,
+				uint8_t data_len, int to);
+int hci_le_set_ext_scan_rsp_data(int dev_id, uint8_t handle, uint8_t operation,
+				uint8_t fragment_pref, const uint8_t *data,
+				uint8_t data_len, int to);
+int hci_le_set_ext_adv_enable(int dev_id, uint8_t enable, uint8_t num_of_sets,
+				const void *sets, int to);
 int hci_le_set_advertise_enable(int dev_id, uint8_t enable, int to);
 int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
 		uint8_t initiator_filter, uint8_t peer_bdaddr_type,

---
base-commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
change-id: 20261014-extend_adv_api-61bb883ac885

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


