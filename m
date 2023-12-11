Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnDjTWJ0"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9902ACD
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:11:39 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-59067f03282so2672457eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702314698; x=1702919498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VYsxF8iendFvCfB30+cNtqoKLEuvblDibwWIJ47MoI=;
        b=NnDjTWJ0KRP/Dvo4cipwNlSFrNYVH25OM2Y0axxpeLb8ZWz4Zq11iKelcyYX/AK1SQ
         db5C8kkE0RgVxoonvWf/WRpylz4lKLedfrmD8MnwXjBrAlUliqbQbGVg200If7VQmS9j
         Y06MeyPKmzJHpGpQeoEkBT85+cP/PhcaQf63GmQ8LI5rh3OHDFYFOXLcQe/0zhJlnEZq
         /i8No416ancD2WS1vgheNWSVtRJTq1XIRh4v/MOcmmx5EBn6O+6hFL9c/Z3+Gmc/dDQr
         O465Ts6aUHGYwWBcBK3dvcgE5KpJzgXhwyIKd7UoiRmLl84n+Awcf9N0rLM+/c9OIcAg
         zzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314698; x=1702919498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VYsxF8iendFvCfB30+cNtqoKLEuvblDibwWIJ47MoI=;
        b=JSilgnHIjnNNLtJMV9xzY68yq/Xb/NugDtCSfOPXH3P++9hQrrxg8/CrMByv0gkEQw
         hFzqM70t8L5G/LVBu0A7/sdkrtK9189i8Ps0LmM+5/GVpxkOTtI0LDKvBcFZCizEWiWn
         nsbswGg97S38qnKGqg6jnUYerP077StsqlBWw60NOLgitbVOXPSRfYBtAZMx2/XwxOQo
         cRdBB3hqNOIui3mO9xmoGC2uM/u1y/lG8mB2LrtcQQJ+25zbWTEO4bNENaBdGlRJoL/t
         bjqyKdOTh21CPjFUywmQTJ9wmSe+Zs94/n+Efei+j0BZYqUq/OkxPCPH7FTUbV30GGtW
         ehJQ==
X-Gm-Message-State: AOJu0YzGX9a+yOc6ALSYtqGA2WS6zKzNHFFj2unmn955ln11zP+ngiw5
	ixAskuHN8bHr1pCBEB/7en7/NWb5OC4=
X-Google-Smtp-Source: AGHT+IEC+gPHMqizTQr04z1omq4RcaWiDDLQ1Rjz3hnazJLPgsaA/HvQvu7UxBAuOs7mds7UgNC68g==
X-Received: by 2002:a05:6820:1501:b0:58e:1c48:1edb with SMTP id ay1-20020a056820150100b0058e1c481edbmr3075263oob.13.1702314698137;
        Mon, 11 Dec 2023 09:11:38 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z20-20020a4a6554000000b0059089f2e461sm1913779oog.0.2023.12.11.09.11.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:11:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/vcp: Fix notification endianness
Date: Mon, 11 Dec 2023 12:11:35 -0500
Message-ID: <20231211171135.437354-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4db4d5fa1c4f ("shared/vcp: Fix endianness errors") does attempt to fix
the endianness of stored volume offset but in the process it broke the
notification since the value is no longer stored in the Bluetooth byte
order (Little Endian) but instead in the cpu byte order which is then
used in the notification as is, to fix this instead of notifying using
the stored value it now uses a dedicated variable which does use the
value from the request itself.
---
 src/shared/vcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5d163266b480..e3451fa2a095 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -683,7 +683,7 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 				struct iovec *iov)
 {
 	struct bt_vcp_db *vdb;
-	struct vol_offset_state *vstate;
+	struct vol_offset_state *vstate, state;
 	struct bt_vocs_set_vol_off *req;
 
 	DBG(vcp, "Set Volume Offset");
@@ -720,9 +720,13 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 	/* Increment Change Counter */
 	vstate->counter = -~vstate->counter;
 
-	gatt_db_attribute_notify(vdb->vocs->vos, (void *)vstate,
-				 sizeof(struct vol_offset_state),
+	/* Notify change */
+	state.vol_offset = req->set_vol_offset;
+	state.counter = vstate->counter;
+
+	gatt_db_attribute_notify(vdb->vocs->vos, (void *)&state, sizeof(state),
 				 bt_vcp_get_att(vcp));
+
 	return 0;
 }
 
-- 
2.43.0

