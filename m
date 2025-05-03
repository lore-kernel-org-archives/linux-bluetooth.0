Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689F83CC7
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746284813; cv=pass; b=hActxzbHHiVemXf3IHlFxvdZAzDFLr+VdGlm9mdvsbDBj4ox6MjRlMFc2ejLpYvWPbSRKMXyAHjGiiv0AsJlBh68t+JOhJPkeVpyWUf5I9+8VE0+X2peGivB6Db3LtPaCNdsxDXF5R57SFFNtJU0seMUzIwYmuhMq4BOfxmCNEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746284813; c=relaxed/simple;
	bh=yF+DtikCwBnbZ/U7ut4vKgVj8cdycYOoCgI2bY/iv+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vyun1AK+aWtPCsjFEASNjF+n+Zw52eFzCdfeNEJ5kmfrRcDRh24Pu68AAINpcnrI+bTQnyqwVRBbInVUBxhX2arJ7A0FLb/BocOHmmoryne5ibzSxIUfsuVDPcFD6uKIqUjcv49SFLA0ReojOkEKZxBtgJfTZNBPJdrgJ0iTvP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dVz+/tMV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dVz+/tMV"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZqWN362jqz49Q8y;
	Sat,  3 May 2025 18:06:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1746284804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=khfZdy19GvRmfeNWtRR/0dZx71S8vMUwvMtO7bnkqVU=;
	b=dVz+/tMVzPBQkSTkzK3tvYzZs/9gGGZQaOtadXMQ3kIP2Mnwrq2muKJ9BlLkctsjq4fJ2F
	6z1g/tnoM7Yq9MWnki5+Ey8r5P/RE0so0PHDUHuEsQbMQ5q597QWwl2eye1EkifeApbjYN
	lljogjc4Wqvhc6QJlVWsl7WYbbAn5K+NHIc16HDPpmahwpe4WtR6nN4RJupjWeI1jcF8Cl
	UtTZTfe76zg/D891KhFpTz5dilSsbgGK9fmESM67f9G8leqCiVlyeTqysTvhEfbTAOWzWl
	azL8yDnVCbzWCSe1nvtvkqS110lIU3kydNYtJSLEH+uWl1JpSPNo6lg1ASGHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1746284804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=khfZdy19GvRmfeNWtRR/0dZx71S8vMUwvMtO7bnkqVU=;
	b=jYbMLHDkZ3x2xsi9ZJZ/NNj1XsgfsIe/8M6xOilPPC9T04xMWzvwqmsXH68oHNLgumOu6E
	JJ/xxI+5h9So3YwMolWYStuSbFRsAvSVn+6DGA5RPNZuarTXFGAbMhSOoIJ7ueS5qUtQjr
	RLqt+sel1pJ346Kdx3F5y3adqwBdTHT2cV5r8EEXleJR50QPKI5ZlXSMDfY/vnzvCbDxLX
	9YcCEdxnRQG+YfvW6LNIA2GeVX+fs/UxhtNH2QeuohgV1P9dxE4NrHFf8COBHLWEeyOuwn
	pVXZ+OlHkcnNqbhbhqnuBWcOLvZv3HKbjTWkYkGJU2RVZCp1cRf+3Ic5NATY8A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1746284804; a=rsa-sha256;
	cv=none;
	b=bJ/HsQS/9NCC7/E38ZIufdQdJzoomJDc2umXWhs+qi2nxgaDTeo9fvXNuLxW5WHFYVV8hq
	sUFfYPdp2Cb4M7kAGuL8dg42jQeg31XVARUsG0rT4IGVRLaoogOSqpmdwJ5xxXIgM5VaCs
	vPIXngiO+493+QWRe108pAqWRnGFv3IZaJn20N2TG4FEl8b//iqhFYRS9V0RFo32MdMmwB
	B3L84a3AVtdP3UacbD+/paaCWb6wtJPulZPYlmUb4KaX7lGz3BMPPw+Do9MmS+a8K0IZQe
	GOohcS4fcxppoFAt4g02OEvyG5KobFH8h35WQ/gXLmOwaL7B7hcCNNzuFUbUog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/vcp: use iov_pull in input parsing
Date: Sat,  3 May 2025 18:06:41 +0300
Message-ID: <a401b67e1969c6987641108d353ff4cce3281d1b.1746284567.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check input is right size by using iov_pull* when parsing.

Also replace custom iov_pull_mem by equivalent util_iov_pull_mem, and
add iov_pull_string.

Fixes handling of zero-length string-valued descriptors, !value is not
error.

Fixes crashes like:

ERROR: AddressSanitizer: stack-buffer-overflow
WRITE of size 3 at 0x7b878bb77161 thread T0
    #0 0x7f878eee4821 in memcpy
    #1 0x0000009544d4 in read_aics_aud_ip_type src/shared/vcp.c:2713
    #2 0x000000950cec in vcp_pending_complete src/shared/vcp.c:2394
    #3 0x00000088b2ce in read_cb src/shared/gatt-client.c:2717
---
 src/shared/vcp.c | 238 +++++++++++++++++++++++++----------------------
 1 file changed, 128 insertions(+), 110 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 321686774..c96ad4376 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -303,17 +303,24 @@ static struct queue *vcp_db;
 static struct queue *vcp_cbs;
 static struct queue *sessions;
 
-static void *iov_pull_mem(struct iovec *iov, size_t len)
+static char *iov_pull_string(struct iovec *iov)
 {
-	void *data = iov->iov_base;
+	char *res;
 
-	if (iov->iov_len < len)
+	if (!iov)
 		return NULL;
 
-	iov->iov_base += len;
-	iov->iov_len -= len;
+	res = malloc(iov->iov_len + 1);
+	if (!res)
+		return NULL;
 
-	return data;
+	if (iov->iov_len)
+		memcpy(res, iov->iov_base, iov->iov_len);
+
+	res[iov->iov_len] = 0;
+
+	util_iov_pull(iov, iov->iov_len);
+	return res;
 }
 
 static struct bt_vcp_db *vcp_get_vdb(struct bt_vcp *vcp)
@@ -577,7 +584,7 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -620,7 +627,7 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -663,7 +670,7 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -707,7 +714,7 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -751,7 +758,7 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 	if (!req)
 		return 0;
 
@@ -794,7 +801,7 @@ static uint8_t vcs_unmute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -833,7 +840,7 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter)
 		return 0;
 
@@ -869,7 +876,7 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 		return 0;
 	}
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 	if (!req)
 		return 0;
 
@@ -992,9 +999,9 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 		goto respond;
 	}
 
-	vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
+	vcp_op = util_iov_pull_mem(&iov, sizeof(*vcp_op));
 	if (!vcp_op) {
-		DBG(vcp, "iov_pull_mem() returned NULL");
+		DBG(vcp, "util_iov_pull_mem() returned NULL");
 		goto respond;
 	}
 
@@ -1056,9 +1063,9 @@ static void vocs_cp_write(struct gatt_db_attribute *attrib,
 		goto respond;
 	}
 
-	vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
+	vcp_op = util_iov_pull_mem(&iov, sizeof(*vcp_op));
 	if (!vcp_op) {
-		DBG(vcp, "iov_pull_mem() returned NULL");
+		DBG(vcp, "util_iov_pull_mem() returned NULL");
 		goto respond;
 	}
 
@@ -1270,7 +1277,7 @@ static uint8_t aics_set_gain_setting(struct bt_aics *aics,
 
 	}
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 	if (!req) {
 		ret = 0;
 		goto respond;
@@ -1333,7 +1340,7 @@ static uint8_t aics_unmute(struct bt_aics *aics, struct bt_vcp *vcp,
 		goto respond;
 
 	}
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter) {
 		ret = 0;
 		goto respond;
@@ -1385,7 +1392,7 @@ static uint8_t aics_mute(struct bt_aics *aics, struct bt_vcp *vcp,
 		ret = 0;
 		goto respond;
 	}
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter) {
 		ret = 0;
 		goto respond;
@@ -1437,7 +1444,7 @@ static uint8_t aics_set_manual_gain_mode(struct bt_aics *aics,
 		goto respond;
 	}
 
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter) {
 		ret = 0;
 		goto respond;
@@ -1496,7 +1503,7 @@ static uint8_t aics_set_auto_gain_mode(struct bt_aics *aics, struct bt_vcp *vcp,
 		ret = 0;
 		goto respond;
 	}
-	change_counter = iov_pull_mem(iov, sizeof(*change_counter));
+	change_counter = util_iov_pull_mem(iov, sizeof(*change_counter));
 	if (!change_counter) {
 		ret = 0;
 		goto respond;
@@ -1592,9 +1599,9 @@ static void aics_ip_cp_write(struct gatt_db_attribute *attrib,
 		goto respond;
 	}
 
-	aics_op = iov_pull_mem(&iov, sizeof(*aics_op));
+	aics_op = util_iov_pull_mem(&iov, sizeof(*aics_op));
 	if (!aics_op) {
-		DBG(vcp, "iov_pull_mem() returned NULL");
+		DBG(vcp, "util_iov_pull_mem() returned NULL");
 		goto respond;
 	}
 
@@ -2045,16 +2052,21 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
-	struct vol_state vstate;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	struct vol_state *vstate;
 
-	memcpy(&vstate, value, sizeof(struct vol_state));
+	vstate = util_iov_pull_mem(&iov, sizeof(*vstate));
+	if (!vstate) {
+		DBG(vcp, "Invalid Vol State");
+		return;
+	}
 
-	DBG(vcp, "Vol Settings 0x%x", vstate.vol_set);
-	DBG(vcp, "Mute Status 0x%x", vstate.mute);
-	DBG(vcp, "Vol Counter 0x%x", vstate.counter);
+	DBG(vcp, "Vol Settings 0x%x", vstate->vol_set);
+	DBG(vcp, "Mute Status 0x%x", vstate->mute);
+	DBG(vcp, "Vol Counter 0x%x", vstate->counter);
 
-	vcp->volume = vstate.vol_set;
-	vcp->volume_counter = vstate.counter;
+	vcp->volume = vstate->vol_set;
+	vcp->volume_counter = vstate->counter;
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
@@ -2190,27 +2202,32 @@ static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
-	struct vol_offset_state vostate;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	struct vol_offset_state *vostate;
 
-	memcpy(&vostate, value, sizeof(struct vol_offset_state));
+	vostate = util_iov_pull_mem(&iov, sizeof(*vostate));
+	if (!vostate) {
+		DBG(vcp, "Invalid Vol Offset State");
+		return;
+	}
 
-	DBG(vcp, "Vol Offset 0x%x", vostate.vol_offset);
-	DBG(vcp, "Vol Offset Counter 0x%x", vostate.counter);
+	DBG(vcp, "Vol Offset 0x%x", vostate->vol_offset);
+	DBG(vcp, "Vol Offset Counter 0x%x", vostate->counter);
 }
 
 static void vcp_audio_loc_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
-	uint32_t *vocs_audio_loc_n = malloc(sizeof(uint32_t));
-	*vocs_audio_loc_n = 0;
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint32_t audio_loc;
 
-	if (value != NULL)
-		memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
+	if (!util_iov_pull_le32(&iov, &audio_loc)) {
+		DBG(vcp, "Invalid VOCS Audio Location");
+		return;
+	}
 
-	DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
-
-	free(vocs_audio_loc_n);
+	DBG(vcp, "VOCS Audio Location 0x%x", audio_loc);
 }
 
 
@@ -2220,20 +2237,29 @@ static void vcp_audio_descriptor_notify(struct bt_vcp *vcp,
 					uint16_t length,
 					void *user_data)
 {
-	char vocs_audio_dec_n[256] = {'\0'};
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	char *vocs_audio_dec;
 
-	memcpy(vocs_audio_dec_n, value, length);
+	vocs_audio_dec = iov_pull_string(&iov);
+	if (!vocs_audio_dec)
+		return;
 
-	DBG(vcp, "VOCS Audio Descriptor 0x%s", *vocs_audio_dec_n);
+	DBG(vcp, "VOCS Audio Descriptor 0x%s", vocs_audio_dec);
+
+	free(vocs_audio_dec);
 }
 
 static void vcp_vflag_notify(struct bt_vcp *vcp, uint16_t value_handle,
 			     const uint8_t *value, uint16_t length,
 			     void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
 	uint8_t vflag;
 
-	memcpy(&vflag, value, sizeof(vflag));
+	if (!util_iov_pull_u8(&iov, &vflag)) {
+		DBG(vcp, "Invalid Vol Flag");
+		return;
+	}
 
 	DBG(vcp, "Vol Flag 0x%x", vflag);
 }
@@ -2242,24 +2268,20 @@ static void read_vol_flag(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
-	uint8_t *vol_flag;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
+	uint8_t vol_flag;
 
 	if (!success) {
 		DBG(vcp, "Unable to read Vol Flag: error 0x%02x", att_ecode);
 		return;
 	}
 
-	vol_flag = iov_pull_mem(&iov, sizeof(*vol_flag));
-	if (!vol_flag) {
+	if (!util_iov_pull_u8(&iov, &vol_flag)) {
 		DBG(vcp, "Unable to get Vol Flag");
 		return;
 	}
 
-	DBG(vcp, "Vol Flag:%x", *vol_flag);
+	DBG(vcp, "Vol Flag:%x", vol_flag);
 }
 
 static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
@@ -2277,7 +2299,7 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 		return;
 	}
 
-	vs = iov_pull_mem(&iov, sizeof(*vs));
+	vs = util_iov_pull_mem(&iov, sizeof(*vs));
 	if (!vs) {
 		DBG(vcp, "Unable to get Vol State");
 		return;
@@ -2308,7 +2330,7 @@ static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vos = iov_pull_mem(&iov, sizeof(*vos));
+	vos = util_iov_pull_mem(&iov, sizeof(*vos));
 	if (!vos) {
 		DBG(vcp, "Unable to get Vol Offset State");
 		return;
@@ -2323,13 +2345,8 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 				     const uint8_t *value, uint16_t length,
 				     void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
 	uint32_t vocs_audio_loc;
-	struct iovec iov;
-
-	if (!value) {
-		DBG(vcp, "Unable to get VOCS Audio Location");
-		return;
-	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x",
@@ -2337,9 +2354,6 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	iov.iov_base = (void *)value;
-	iov.iov_len = length;
-
 	if (!util_iov_pull_le32(&iov, &vocs_audio_loc)) {
 		DBG(vcp, "Invalid size for VOCS Audio Location");
 		return;
@@ -2354,12 +2368,8 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 				       const uint8_t *value, uint16_t length,
 				       void *user_data)
 {
-	char *vocs_ao_dec_r;
-
-	if (!value) {
-		DBG(vcp, "Unable to get VOCS Audio Location");
-		return;
-	}
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	char *vocs_ao_dec;
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
@@ -2367,12 +2377,13 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = util_memdup(value, length + 1);
-	memset(vocs_ao_dec_r + length, 0, 1);
+	vocs_ao_dec = iov_pull_string(&iov);
+	if (!vocs_ao_dec)
+		return;
 
-	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
-	free(vocs_ao_dec_r);
-	vocs_ao_dec_r = NULL;
+	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec);
+
+	free(vocs_ao_dec);
 }
 
 static void vcp_pending_destroy(void *data)
@@ -2632,9 +2643,9 @@ static void read_aics_audio_ip_state(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	ip_st = iov_pull_mem(&iov, sizeof(*ip_st));
+	ip_st = util_iov_pull_mem(&iov, sizeof(*ip_st));
 	if (!ip_st) {
-		DBG(vcp, "Unable to get Audio Input State");
+		DBG(vcp, "Invalid Audio Input State");
 		return;
 	}
 
@@ -2648,14 +2659,19 @@ static void aics_ip_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
-	struct aud_ip_st ip_st;
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
+	struct aud_ip_st *ip_st;
 
-	memcpy(&ip_st, value, sizeof(struct aud_ip_st));
+	ip_st = util_iov_pull_mem(&iov, sizeof(*ip_st));
+	if (!ip_st) {
+		DBG(vcp, "Invalid Audio Input State");
+		return;
+	}
 
-	DBG(vcp, "Audio Input State, Gain Setting:%d", ip_st.gain_setting);
-	DBG(vcp, "Audio Input State, Mute:%x", ip_st.mute);
-	DBG(vcp, "Audio Input State, Gain Mode:%x", ip_st.gain_mode);
-	DBG(vcp, "Audio Input State, Change Counter:%x", ip_st.chg_counter);
+	DBG(vcp, "Audio Input State, Gain Setting:%d", ip_st->gain_setting);
+	DBG(vcp, "Audio Input State, Mute:%x", ip_st->mute);
+	DBG(vcp, "Audio Input State, Gain Mode:%x", ip_st->gain_mode);
+	DBG(vcp, "Audio Input State, Change Counter:%x", ip_st->chg_counter);
 }
 
 static void read_aics_gain_setting_prop(struct bt_vcp *vcp, bool success,
@@ -2663,16 +2679,8 @@ static void read_aics_gain_setting_prop(struct bt_vcp *vcp, bool success,
 					 const uint8_t *value, uint16_t length,
 					 void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	struct gain_setting_prop *aics_gain_setting_prop;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
-
-	if (!value) {
-		DBG(vcp, "Unable to get Gain Setting Properties Char");
-		return;
-	}
 
 	if (!success) {
 		DBG(vcp,
@@ -2681,7 +2689,7 @@ static void read_aics_gain_setting_prop(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	aics_gain_setting_prop = iov_pull_mem(&iov,
+	aics_gain_setting_prop = util_iov_pull_mem(&iov,
 				sizeof(*aics_gain_setting_prop));
 	if (!aics_gain_setting_prop) {
 		DBG(vcp, "Unable to get Gain Setting Properties Char");
@@ -2701,6 +2709,7 @@ static void read_aics_aud_ip_type(struct bt_vcp *vcp, bool success,
 					 const uint8_t *value, uint16_t length,
 					 void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	uint8_t ip_type;
 
 	if (!success) {
@@ -2710,7 +2719,10 @@ static void read_aics_aud_ip_type(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	memcpy(&ip_type, value, length);
+	if (!util_iov_pull_u8(&iov, &ip_type)) {
+		DBG(vcp, "Invalid Audio Input Type Char");
+		return;
+	}
 
 	DBG(vcp, "Audio Input Type : %x", ip_type);
 }
@@ -2720,6 +2732,7 @@ static void read_aics_audio_ip_status(struct bt_vcp *vcp, bool success,
 					 const uint8_t *value, uint16_t length,
 					 void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	uint8_t ip_status;
 
 	if (!success) {
@@ -2728,7 +2741,10 @@ static void read_aics_audio_ip_status(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	memcpy(&ip_status, value, length);
+	if (!util_iov_pull_u8(&iov, &ip_status)) {
+		DBG(vcp, "Invalid Audio Input Status Char");
+		return;
+	}
 
 	DBG(vcp, "Audio Input Status : %x", ip_status);
 }
@@ -2738,9 +2754,13 @@ static void aics_ip_status_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				uint16_t length,
 				void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	uint8_t	ip_status;
 
-	memcpy(&ip_status, value, length);
+	if (!util_iov_pull_u8(&iov, &ip_status)) {
+		DBG(vcp, "Invalid Audio Input Status Char");
+		return;
+	}
 
 	DBG(vcp, "Audio Input Status, %x", ip_status);
 }
@@ -2751,13 +2771,9 @@ static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
 					   uint16_t length,
 					   void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	char *ip_descrptn;
 
-	if (!value) {
-		DBG(vcp, "Unable to get Audio Input Description");
-		return;
-	}
-
 	if (!success) {
 		DBG(vcp,
 			"Unable to read Audio Input Description Char: error 0x%02x",
@@ -2765,27 +2781,29 @@ static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	ip_descrptn = util_memdup(value, length + 1);
-	memset(ip_descrptn + length, 0, 1);
+	ip_descrptn = iov_pull_string(&iov);
+	if (!ip_descrptn)
+		return;
 
 	DBG(vcp, "Audio Input Description: %s", ip_descrptn);
+
 	free(ip_descrptn);
-	ip_descrptn = NULL;
 }
 
 static void aics_audio_ip_desr_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
+	struct iovec iov = { .iov_base = (void *) value, .iov_len = length };
 	char *aud_ip_desr;
 
-	aud_ip_desr = malloc(length+1);
-	memset(aud_ip_desr, 0, length+1);
-	memcpy(aud_ip_desr, value, length);
+	aud_ip_desr = iov_pull_string(&iov);
+	if (!aud_ip_desr)
+		return;
 
 	DBG(vcp, "Audio Input Description Notify, %s", aud_ip_desr);
+
 	free(aud_ip_desr);
-	aud_ip_desr = NULL;
 }
 
 static void foreach_aics_char(struct gatt_db_attribute *attr, void *user_data)
-- 
2.49.0

