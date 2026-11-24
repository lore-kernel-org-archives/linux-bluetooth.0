Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526411;
	b=Ah2tON+MsEA9Veg/FTWl0jfGNmkuKs3RSjHy6Oh2lvWJAm/2W6Kl+8hbP643JFa6kF3Q
	 umCq1Dse5U+VEvptx9xM9edUy5JhQMhQRol18XCZLYIhwzIezL+YobOkuXQRgnSzlvZWZ
	 PFgXXq1G1lYqDfsztqtPwJGKPl+obKqSK+YIOi04+kX1V531WnGCeUEt5cn71kIWWml32
	 Ki4VAUA9o2AYutw4mzp2DSW5gKY5c7V+z0wNDH04rtArQhZwIVfa1QRDhJt388XrVu7k+
	 fH7DmFBuFi1Jfi+YGRETPy6CJitPwXfKDOekaAk0LIfWBopWm/zIYIs2bQqRzE+4T+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PiPTz5/mVuRPZryh3RYD3KEXj+0paRqOx+g1Trgwsd4=;
	b=R5bgEghJ3nd5rThRH+qGglVPlVzmoBuM//KjLUrlUrWOEoLKywaMpBitY7Afs54Pzokk
	 SX3isUp8jZnrGGR/9v5mcar8dG3DDWsWNVm/cz0Zd8pmODgnfs5sIzMvXRf7jMuPjeRpn
	 ooU3GwJ/0G8zF/ho5AhOk06VJ3BCJOGZiDpCoI3UqHPWb+EO8ONgO4dL/jgYIA5ktonsb
	 7m82mbxLA6ZFkt3C6qNR7W+U+mD6zrl/ealWBsW3rGzoAl9Qa7LMpbDrGx205ZTjsGsrJ
	 DRPYyvhi9AC/ibDvLucwAIMrSiVpjqwsgA8YooNZDoOkV9gfMZtY5u0G0o1pqG0aEPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lu+RdiUZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1533606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1533606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=lu+RdiUZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so37711365e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526409; x=1796131209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiPTz5/mVuRPZryh3RYD3KEXj+0paRqOx+g1Trgwsd4=;
        b=lu+RdiUZt7DDSQ4nvunCcYd0OcZA6Se6tKaDLCyAFT59HKWsC2ECD7PNEVJFaxb/Py
         yY5+rkOPyi51a6vOAK65RMZJpAeLI+sJtJOk+rVNaemMWwnpwkhgCoa8VOgRCqDO9Gd/
         IQHYg1DQsByd3lSSXNQfNLTSSyLtTpd7b52ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526409; x=1796131209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiPTz5/mVuRPZryh3RYD3KEXj+0paRqOx+g1Trgwsd4=;
        b=WoNrINzQX97hyU3tysfaEgS5emA+bkS36EbsCUiJ4TZGFWoblvW2p15N06mZ+E1MQb
         jw/JibhEJ6e7XZ2vZrWFQTgU7p8Nkw1BpTKZELknf++Fwlv8Obfk94XPABqTYenOaI7i
         LNFiJSdcSVftMmRVybTixQihIktB3ycJtpmegzJVaIOANTQ7ra7dTW3tiHVWk5Xk8bwK
         pzzCxUuLhdMy4q3xMPDV0sz665v8pycyOpJ6XpWiJhmVxDyzbwG3GTMP28ZFTfQRzmOF
         /UYrW00C/EBhcGDqDizNJKxqp2hVILuUL7oKE+HqeCImPtqJx7I3uy4T45cKG/Gxid7Y
         sd4w==
X-Gm-Message-State: APuU4Z/z6Iw3vA5NqJPnubXeyPIjbKH9FWjkSzbNENfbalgDe/VJ7amw
	/6OFT4O4GnWTyMfny4gKGG4rP27/nm/Nzsk3wpnNaiZbBmxErIEr6Qo0D9REb63LAwZ2F7Yx0x6
	kH3T/
X-Gm-Gg: AZFdTZcQ99b9vFZo939ZEBVbu0T4xxznfVd45qHO+r/KZoEU2VINx26kdidMIAZBOJw
	x175ocDHRidmqL0iOd29qx+Htl5hq6qiNrRR3PiyH0O29ypQI7N3ncIiEU/nJkqWXQDwpRo6UWO
	Da0VnSnfiUE95pWGQ5ksri7UswqaPjkWa9UQbfXfOjR8CgksGYJuDWG2sj0E96hKXL2VFQH0mQf
	VBqFxMGszuSyCL1kwvEy7DJwap6VzeT6BLBrR2ZNMp1yQ3qIYW8+0wSLuMRus/stFftAVoQbsrx
	2rq9kav92Kzu0ap++VEykG37VUri0Ce6KMxI6wk9bXDsN06CTUF44faquE7UPpLakUsjdHl4arK
	q8+1IIN8kueiymskz5NM9d0jaCcqOln1QFWmy9LawsPkLnoD5dNDzEhiJyMcy/GGU6qGDPkg8bH
	42EjR9ieWts1vWW6Gr/3eBveDdxmO+Sc3Kdjc+P3TFCn/+pOSqOD49NURVZihCSmIvYe2/WelcZ
	9uy1OBo98roBA1SgzxZViwIdyVt9YR0wNogCYxoLbNkFuSMLy8NanCuJdsCrVVZUj9jEgVE65OG
	7RKNjosyaM312xDonkamviI7dz/T1dweOc6i/XrF4aNI5YIHhg==
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4bb8881b511mr299818595e9.18.1795526409225;
        Tue, 24 Nov 2026 05:20:09 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm270963015e9.4.2026.11.24.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:20:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/4] shared/vcp: Add bt_vcp_get_mute and bt_vcp_set_mute
Date: Tue, 24 Nov 2026 14:20:01 +0100
Message-ID: <20261124132003.3899120-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
References: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the Mute field of Volume State next to the volume. As a client,
setting it writes Mute or Unmute to the remote Volume Control Point. As
a server, it updates the local Volume State and notifies it.

The volume callback now also runs when only the mute state changes, so
its user sees a remote client muting or unmuting the server.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/vcp.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/vcp.h |   3 ++
 2 files changed, 104 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c7f74956e..c0bb535ec 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -216,6 +216,7 @@ struct bt_vcp {
 
 	uint8_t volume;
 	uint8_t volume_counter;
+	uint8_t mute;
 
 	struct bt_vcp_client_op pending_op;
 
@@ -977,6 +978,18 @@ struct vocs_op_handler {
 	{}
 };
 
+static void vcp_mute_changed(struct bt_vcp *vcp, uint8_t mute)
+{
+	if (vcp->mute == mute)
+		return;
+
+	vcp->mute = mute;
+
+	/* The volume callback reports any Volume State change */
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume);
+}
+
 static void vcs_cp_write(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				const uint8_t *value, size_t len,
@@ -991,6 +1004,7 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 	};
 	uint8_t	*vcp_op;
 	struct vcs_op_handler *handler;
+	struct vol_state *vstate;
 	uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
 	DBG(vcp, "VCP Control Point Write");
@@ -1032,6 +1046,10 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 		DBG(vcp, "%s", handler->str);
 
 		ret = handler->func(vcs, vcp, &iov);
+
+		vstate = vdb_get_vstate(vcs->vdb);
+		if (!ret && vstate)
+			vcp_mute_changed(vcp, vstate->mute);
 	} else {
 		DBG(vcp, "Unknown opcode 0x%02x", *vcp_op);
 		ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
@@ -2076,6 +2094,7 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 
 	vcp->volume = vstate->vol_set;
 	vcp->volume_counter = vstate->counter;
+	vcp->mute = vstate->mute;
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
@@ -2207,6 +2226,87 @@ uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
 	return vcp->volume;
 }
 
+static void vcp_mute_cp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+
+	if (!success)
+		DBG(vcp, "setting mute failed: error 0x%x", err);
+}
+
+static bool vcp_set_mute_client(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcs_param req;
+	uint16_t value_handle;
+	struct bt_vcs *vcs = vcp_get_vcs(vcp);
+
+	if (!vcs || !vcs->vol_cp) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
+							NULL, NULL, NULL)) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	if (vcp->mute == mute)
+		return true;
+
+	req.op = mute ? BT_VCS_MUTE : BT_VCS_UNMUTE;
+	req.change_counter = vcp->volume_counter;
+
+	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *)&req,
+					sizeof(req), vcp_mute_cp_sent, vcp,
+					NULL)) {
+		DBG(vcp, "error writing mute");
+		return false;
+	}
+
+	return true;
+}
+
+static bool vcp_set_mute_server(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcp_db *vdb = vcp_get_vdb(vcp);
+	struct vol_state *vstate;
+
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		return false;
+	}
+
+	vstate = vdb_get_vstate(vdb);
+	if (!vstate) {
+		DBG(vcp, "error: VSTATE not available");
+		return false;
+	}
+
+	if (vstate->mute == mute)
+		return true;
+
+	vstate->mute = mute;
+	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
+			sizeof(struct vol_state), bt_vcp_get_att(vcp));
+	vcp_mute_changed(vcp, mute);
+	return true;
+}
+
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute)
+{
+	if (vcp->client)
+		return vcp_set_mute_client(vcp, mute);
+	else
+		return vcp_set_mute_server(vcp, mute);
+}
+
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp)
+{
+	return vcp->mute;
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -2320,6 +2420,7 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 
 	vcp->volume = vs->vol_set;
 	vcp->volume_counter = vs->counter;
+	vcp->mute = vs->mute;
 }
 
 static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index e031beafd..807d2bdbe 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -42,6 +42,9 @@ void bt_vcp_detach(struct bt_vcp *vcp);
 uint8_t bt_vcp_get_volume(struct bt_vcp *vcp);
 bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume);
 
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp);
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute);
+
 bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
 			void *user_data, bt_vcp_destroy_func_t destroy);
 
-- 
2.43.0

