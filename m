Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/av2sl+"
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D12D73
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:30:49 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4ac1988ca66so619827e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275448; x=1701880248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEvnSwSPxEV3VzbHSlrchJoCzzcwo+uaAK0ttWMzRiM=;
        b=V/av2sl+rd8TGogGfP9hzaCJ1OZ0BO5DNDlFmt5xbc46mj9zndbzvcY4BT5p7LI3M+
         M3A6kFieDK4zd39oaiRwnSR+0wvYk1p9SHIF07O2qqEdyZX0CkcXK+At29s/x9s5X2EC
         phZ1lnBXyTF8nrqbXJH/ZieZURVAWG4jWT6mtK6Y+D+xJcrIiLTZ0qgrTJWwPYjnL0qM
         aGHy6B/2xYq4KVfhlE3R7K5o1F11LLo15yBS4xLaL7CqKFjRSnfWHr6pWqtndlJyJUuY
         LNGFzRzSvEhUbKqJ7OVo2Rk9cKipA6Je+cgsLEomLl+NXuG0hGmQUvXJZrhbJjlXwNWp
         rZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275448; x=1701880248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEvnSwSPxEV3VzbHSlrchJoCzzcwo+uaAK0ttWMzRiM=;
        b=vny7wMbcsSgb+6mK8w4rqOmOVfodJAJD3U6BExE86z/CwTYVYhI+r4+xe/YbeapHMc
         V2hhpm9meJM9TI/vQ9V68a6oCT56ouma2ad+emBd0uNJWVKaMXZWWfJaqBUZnUJ+TaTi
         1SF1cpHfunV+Bpr2XviRSkfW98FzJGyWZqUyBTYF5NdQrzQDmLOB9m0+EWaS9CE8V94G
         MB1/nOsnNYf6ZbUcSVG8iX2GWwQu8W7Ph6ZZol/0F+Ju7sRdxQ9YN8hluh1kV6An6UW2
         gJZCWXKnNavhnag1OUyn8O4ch80fDFnKM8asSvMRKxIIR6KONkBtRxBquHqksfK+iBeB
         xYuQ==
X-Gm-Message-State: AOJu0YzOnqwv6S5sTmvAbU5tJImvcHH47qFRgcD6P04rWFahDNl0pCIs
	jvNqtoa6Slb4/+R/6kGUnK5GwRAOLMQBjA==
X-Google-Smtp-Source: AGHT+IEOBqpoZKNwjAMhUiDSYLzEsmXMgAfHuwveaFDZvX4KqfEwBXzJXWY5PRAjVIn1NuFD1YjuEg==
X-Received: by 2002:a1f:cb85:0:b0:49a:a6c8:c815 with SMTP id b127-20020a1fcb85000000b0049aa6c8c815mr13786862vkg.6.1701275445646;
        Wed, 29 Nov 2023 08:30:45 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id fm9-20020a056122290900b004acebe1af09sm2540063vkb.47.2023.11.29.08.30.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:30:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/vcp: Fix endianess errors
Date: Wed, 29 Nov 2023 11:30:40 -0500
Message-ID: <20231129163041.2075184-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129163041.2075184-1-luiz.dentz@gmail.com>
References: <20231129163041.2075184-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On big endian the followin error can be observed:
VOCS/SR/SGGIT/CHA/BV-02-C - init
VOCS/SR/SGGIT/CHA/BV-02-C - setup
VOCS/SR/SGGIT/CHA/BV-02-C - setup complete
VOCS/SR/SGGIT/CHA/BV-02-C - run
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Aborted
---
 src/shared/vcp.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 263da4c30c29..f2c04d184a08 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -714,7 +714,7 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 		DBG(vcp, "error: Value Out of Range");
 		return BT_ATT_ERROR_VALUE_OUT_OF_RANGE;
 	}
-	vstate->vol_offset = req->set_vol_offset;
+	vstate->vol_offset = le16_to_cpu(req->set_vol_offset);
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
 	gatt_db_attribute_notify(vdb->vocs->vos, (void *)vstate,
@@ -926,13 +926,13 @@ static void vocs_state_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_vocs *vocs = user_data;
-	struct iovec iov;
+	struct vol_offset_state state;
 
-	iov.iov_base = vocs->vostate;
-	iov.iov_len = sizeof(*vocs->vostate);
+	state.vol_offset = cpu_to_le16(vocs->vostate->vol_offset);
+	state.counter = vocs->vostate->counter;
 
-	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
-							iov.iov_len);
+	gatt_db_attribute_read_result(attrib, id, 0, (void *)&state,
+					sizeof(state));
 }
 
 static void vcs_flag_read(struct gatt_db_attribute *attrib,
@@ -958,7 +958,7 @@ static void vocs_voal_read(struct gatt_db_attribute *attrib,
 	struct bt_vocs *vocs = user_data;
 	struct iovec iov;
 
-	iov.iov_base = &vocs->vocs_audio_loc;
+	iov.iov_base = &cpu_to_le32(vocs->vocs_audio_loc);
 	iov.iov_len = sizeof(vocs->vocs_audio_loc);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
@@ -1376,8 +1376,8 @@ static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	DBG(vcp, "Vol Set:%x", vos->vol_offset);
-	DBG(vcp, "Vol Counter:%x", vos->counter);
+	DBG(vcp, "Vol Offset: 0x%04x", le16_to_cpu(vos->vol_offset));
+	DBG(vcp, "Vol Counter: 0x%02x", vos->counter);
 }
 
 static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
@@ -1386,6 +1386,7 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 				     void *user_data)
 {
 	uint32_t vocs_audio_loc;
+	struct iovec iov;
 
 	if (!value) {
 		DBG(vcp, "Unable to get VOCS Audio Location");
@@ -1398,9 +1399,15 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	memcpy(&vocs_audio_loc, value, length);
+	iov.iov_base = (void *)value;
+	iov.iov_len = length;
 
-	DBG(vcp, "VOCS Audio Loc: %x", vocs_audio_loc);
+	if (!util_iov_pull_le32(&iov, &vocs_audio_loc)) {
+		DBG(vcp, "Invalid size for VOCS Audio Location");
+		return;
+	}
+
+	DBG(vcp, "VOCS Audio Loc: 0x%8x", vocs_audio_loc);
 }
 
 
-- 
2.43.0

